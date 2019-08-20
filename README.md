This is an easy process: 

* Modify configuration file `config.yaml`.

* Generate install scripts with:
~~~
./generate_scripts.sh
~~~

* Place RPMs in `rpms/` 

* Create a tar archive of the directory and deliver it to the customer:
~~~
tar -czf <file name> <dir name>
~~~

* On the target system, extract the tarball, go to directory scripts and run:
~~~
cd scripts/
bash generate_hotfix.sh
~~~

If needed / desired, run:
~~~
bash start_hotfix_container.sh
~~~
