class AddMemberTsvTrigger < ActiveRecord::Migration[5.0]
 def up
   execute <<-DOC
     CREATE OR REPLACE FUNCTION update_members_tsv(member_id integer) RETURNS void
     LANGUAGE plpgsql
     AS $_$
     DECLARE
     BEGIN
       UPDATE members
          SET tsv =
                setweight(to_tsvector('english', coalesce(heading, '')), 'A')
       WHERE members.id = member_id;
     END
     $_$;

     CREATE OR REPLACE FUNCTION members_tsv_trigger() RETURNS trigger
       LANGUAGE plpgsql
       AS $$
     declare
     begin
       if (tg_op = 'INSERT') then
         perform update_members_tsv(new.id);
       elsif (tg_op = 'UPDATE') then
         if row(new) is distinct from row(old) then
           perform update_members_tsv(new.id);
         end if;
       end if;
       return null;
     end;
     $$;

     CREATE TRIGGER members_tsv_tr
     AFTER INSERT OR UPDATE ON members
     FOR EACH ROW
     EXECUTE PROCEDURE members_tsv_trigger();
   DOC
 end

 def down
   execute <<-DOC
     DROP TRIGGER members_tsv_tr ON members;
     DROP FUNCTION members_tsv_trigger();
     DROP FUNCTION update_members_tsv(integer);
   DOC
 end
end
