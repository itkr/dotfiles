#!/bin/sh

cli=/Applications/Karabiner.app/Contents/Library/bin/karabiner

$cli set remap.mouse_keys_mode_holding_m 1
/bin/echo -n .
$cli set repeat.initial_wait 533
/bin/echo -n .
$cli set remap.right_command_arrow_to_scroll 1
/bin/echo -n .
$cli set remap.simultaneouskeypresses_mouse_keys_mode_df 1
/bin/echo -n .
$cli set general.treat_unifying_as_pointing_device 1
/bin/echo -n .
$cli set general.disable_internal_keyboard_if_external_keyboard_exsits 1
/bin/echo -n .
$cli set remap.hjkl_arrow 1
/bin/echo -n .
$cli set parameter.mouse_key_scroll_not_natural_direction 1
/bin/echo -n .
$cli set repeat.wait 33
/bin/echo -n .
$cli set remap.right_command_leftrightarrow_to_scroll 1
/bin/echo -n .
$cli set remap.pointing_relative_middleclick_to_scroll 1
/bin/echo -n .
$cli set option.mousekeys_mode_wer2click 1
/bin/echo -n .
/bin/echo
