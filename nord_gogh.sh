#!/usr/bin/env bash
# Download apply script
wget https://github.com/Gogh-Co/Gogh/raw/master/apply-colors.sh
# Download desired themes from ./installs/ like this:
wget https://github.com/Gogh-Co/Gogh/raw/master/installs/nord.sh

# Optional - download Alacritty dependency (may require additional python packages, see requirements.txt for more)
#wget https://github.com/Gogh-Co/Gogh/raw/master/apply-alacritty.py
# Optional - download Terminator dependency (may require additional python packages, see requirements.txt for more)
#wget https://github.com/Gogh-Co/Gogh/raw/master/apply-terminator.py

# You can also specify where to find the apply scripts with the following environmental variables:
GOGH_APPLY_SCRIPT=/path/to/apply-colors.sh
GOGH_ALACRITTY_SCRIPT=/path/to/apply-alacritty.py   # only needed if applying to Alacritty terminal
GOGH_TERMINATOR_SCRIPT=/path/to/apply-terminator.py # only needed if applying to Terminator terminal

# Control Gogh behavior with the following:
TERMINAL=gnome-terminal # Select for which terminal to install the theme
                        # (see apply-colors.sh for all supported terminals)
GOGH_NONINTERACTIVE= # Make output silent and answer all prompts with default value
                     # (errors will still be printed)
GOGH_USE_NEW_THEME= # Make theme the currently used/default one of the terminal
                    # Actual effect may differ between terminals
                    # Supported terminals: xfce4-terminal

# Apply downloaded theme (apply script must be in the same folder)
TERMINAL=gnome-terminal bash ./selenized-dark.sh
# OR specify apply script path
GOGH_APPLY_SCRIPT=/path/to/file/apply-colors.sh bash ./selenized-dark.sh