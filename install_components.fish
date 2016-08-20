#! /usr/local/bin/fish

# ---------- Utils ----------

function is_command_exist
  command -v $1 > /dev/null
end

# ---------- Helpers ----------

function validate_component
end

function install_component
end

function boostrap_component
end

function config_component
end

function post_install_component
end

# ---------- Main Steps ----------

function install_components
  set starting_dir (pwd)
  cd (dirname (status --current-filename))

  for component in ./*
    if test -d $component; and validate_component $component;
      install_component $component
      boostrap_component $component
      config_component $component
      post_install_component $component
    end
  end

  cd $starting_dir
end

# ---------- Exec Installations ----------

install_components
