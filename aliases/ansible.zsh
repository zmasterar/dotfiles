findip() {
    ansible-playbook -K $HOME/pjt/infraestructura/ansible/find_ip.yaml --extra-vars "ip_or_host=$1" 
}
