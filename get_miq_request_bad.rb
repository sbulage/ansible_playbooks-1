---
- name: Get miq request object and update user message
  hosts: localhost
  connection: local
  vars:
  - object: root

  gather_facts: False
  roles:
  - syncrou.manageiq-automate
  - syncrou.manageiq-vmdb

  tasks:
    - name: "Get miq_request object reference"
      manageiq_automate:
 #      workspace: "{{ workspace }}"
        href: "{{ manageiq.request_task }}"
        get_attribute:
          object: "root"
          attribute: "miq_request"
      register: miq_request

    - debug: msg="miq_request is {{ miq_request.value }}"

    - name: Update user message in miq_request
      manageiq_vmdb:
        href: "{{ miq_request.value }}"
        action: edit
        data: 
          options:
            user_message: "hello from Ansible"
      register:    result

    - debug: msg="attribute result dictionary {{ result }}"
