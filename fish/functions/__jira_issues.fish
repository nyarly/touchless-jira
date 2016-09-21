function __jira_issues
	set -l username $JIRA_USERNAME
  set -l password $JIRA_PASSWORD
  set -l jql $JIRA_JQL
  set -l jarfile $JIRA_JARFILE
  set -l server $JIRA_SERVER
  set -l extra_jql 'and sprint in openSprints()'
  #'and assignee = currentUser()'

  if test -z $username
    set username (git config --get jira.user)
    if test $status -ne 0
      return 1
    end
  end

if test -z $password
  set password (git config --get jira.password)
  if test $status -ne 0
    return 1
end
end

if test -z $jarfile
  set jarfile (git config --get jira.jarfile)
  if test $status -ne 0
    return 1
end
 end

 if test -z $server
   set server (git config --get jira.server)
   if test $status -ne 0
     return 1
end
end

if test -z $jql
  set jql (git config --get jira.jql)
  if test $status -ne 0
    return 1
end
end

java -jar "$jarfile" --server "$server" --user "$username" --password "$password" --action getIssueList --columns key,summary,status --jql "$jql $extra_jql" | sed -E 's/^"|"$//g' | awk -F '"*,"*' 'NR > 2 && NF == 3 { print $1 "	" $2 " [" $3 "]" }'
end

function __cached_jira_issues
	__cache_zap jira .git -amin +60
  __cache_or_get jira .git '__jira_issues'
end
function __cache_zap --description 'Deletes cache files for the current directory under <ns>' --argument ns anchor extra_find
	set -l constraints ""
  if [ (count $argv) -gt 2 ]
    set contraints $argv[3..-1]
  end
	for f in (eval find (__cache_dir $ns) -name (__cache_key $anchor) $contraints -print)
    rm $f
  end
end
function __cache_or_get -a ns anchor get_cmd
  set -l cache_file (__cache_path $ns $anchor)

  if not test -f "$cache_file"
    eval $get_cmd > "$cache_file"
  end
  cat "$cache_file"
end
