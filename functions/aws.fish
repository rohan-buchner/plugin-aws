function aws -a cmd -d 'Universal CLI for AWS'
  switch "$cmd"
    case profile
      if set -q argv[2]
        set -gx AWS_PROFILE "$argv[2]"
      else if set -q FILTER
        aws profiles | command env $FILTER | read -gx AWS_PROFILE
        echo $AWS_PROFILE
      else
        echo $AWS_PROFILE
      end

    case profiles
      command cat ~/.aws/{config,credentials} | string replace -r -f "^\[(profile[[:space:]]*)*(.*)\]" '$2' | sort -u

    case '*'
      command aws $argv
  end
end
