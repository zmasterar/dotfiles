alias pjt='cd ~/pjt'

alias jsl='code ~/pjt/devops/jenkins-shared-libraries'
alias k8s-manifests='code ~/pjt/devops/k8s-manifests'

alias agenda='cd ~/pjt/desarrollo/agenda'
alias airflow='cd ~/pjt/infraestructura/airflow'
alias audiencias-civiles='cd ~/pjt/desarrollo/audiencias-civiles'
alias boletin-judicial='cd ~/pjt/desarrollo/boletin-judicial'
alias common-services='cd ~/pjt/desarrollo/common-services'
alias consulta-acordadas='cd ~/pjt/desarrollo/consulta-acordadas'
alias devops='cd ~/pjt/devops'
alias estadistica='cd ~/pjt/estadistica'
alias expediente-virtual='cd ~/pjt/desarrollo/expediente-virtual'
alias flipbook='cd ~/pjt/desarrollo/flipbook'
alias iluvatar-project='cd ~/pjt/desarrollo/iluvatar-project'
alias infraestructura='cd ~/pjt/infraestructura'
alias inicio-expedientes='cd ~/pjt/desarrollo/inicio-expedientes'
alias justicia-de-paz='cd ~/pjt/desarrollo/justicia-de-paz'
alias oga='cd ~/pjt/desarrollo/oga'
alias padron-electoral='cd ~/pjt/desarrollo/padron-electoral'
alias portal-del-sae-v2='cd ~/pjt/desarrollo/portal-del-sae-v2'
alias portal-del-sae='cd ~/pjt/desarrollo/portal-del-sae'
alias puas='cd ~/pjt/desarrollo/puas'
alias rrhh='cd ~/pjt/rrhh'
alias sistemas-no-jurisdiccionales='cd ~/pjt/desarrollo/sistemas-no-jurisdiccionales'
alias sitio-principal='cd ~/pjt/desarrollo/sitio-principal'
alias vosk='cd ~/pjt/desarrollo/vosk'

# e.g. rm -f $HOME/pjt/kubeconfig && ln -s $HOME/pjt/kubeconfig-ws15desa $HOME/pjt/kubeconfig
export KUBECONFIG=$HOME/pjt/kubeconfig
alias wakelazarus='ssh raspi400 wakelazarus'

hints () {
  usage () {
    echo "Usage:"
    echo "hints -h | --help"
    echo "hints a | hints all # Shows all hints"
    echo "hints db # Shows all DB hints"
    echo "hints create_database"
    echo "hints dump_database"
    echo "hints restore_database"
    echo "hints fix_ownership"
  }

  create_database () {
    echo '### Create database'
    echo "CREATE ROLE example WITH LOGIN
VALID UNTIL 'infinity'
NOINHERIT NOCREATEDB NOCREATEROLE NOREPLICATION NOSUPERUSER;
CREATE DATABASE example WITH OWNER example;
\c example
GRANT CONNECT ON DATABASE example TO zbx_monitor;"
    echo
  }

  dump_database () {
    echo '### Dump database'
    echo 'export database_name=demo; pg_dump --format=custom --no-acl --no-owner --no-privileges --file=$database_name-$(date +%Y%m%d).dump $database_name'
    echo
  }

  restore_database () {
    echo '### Restore database'
    echo 'pg_restore -Fc -d database_name -xO file.dmp'
    echo
  }

  fix_ownership () {
    echo '### Change ownerwhip of tables and sequences'
    echo 'export PGPASSWORD=postgres;export PGUSER=postgres;export PGHOST=localhost;export DBNAME=personal;for tbl in $(psql -qAt -c "select tablename from pg_tables where schemaname = '\''public'\'';" $DBNAME); do psql -c "alter table \"$tbl\" owner to $DBNAME" $DBNAME; done; for seq in $(psql -qAt -c "SELECT sequencename FROM pg_sequences where schemaname = '\''public'\'';" $DBNAME); do psql -c "ALTER SEQUENCE \"$seq\" OWNER TO $DBNAME" $DBNAME; done'
    echo
  }

  show_all_hints () {
    create_database
    dump_database
    restore_database
    fix_ownership
  }

  show_all_db_hints () {
    create_database
    dump_database
    restore_database
    fix_ownership
  }

  case "$1" in
    a | all ) show_all_hints; return;;
    db | show_all_dbs_hints ) show_all_db_hints; return;;
    create_database | create_db | create) create_database; return;;
    dump ) dump_database; return;;
    restore ) restore_database; return;;
    fix_ownership ) fix_ownership; return;;
    -h | --help ) usage; return;;
  esac
  
  usage
}
