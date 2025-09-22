# ~/.config/hypr/scripts/swww-manager.sh
#!/bin/bash
# Swww wallpaper management script with smooth transitions

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"
CURRENT_THEME_FILE="$HOME/.config/hypr/themes/current.conf"

# Create wallpaper directory if it doesn't exist
mkdir -p "$WALLPAPER_DIR"

# Initialize swww daemon if not running
init_swww() {
    if ! pgrep -x "swww-daemon" > /dev/null; then
        echo "Starting swww daemon..."
        swww init
        sleep 1
    fi
}

# Set wallpaper with transition effects
set_wallpaper() {
    local theme="$1"
    local wallpaper_file="$WALLPAPER_DIR/$theme.jpg"
    local transition_type="${2:-wipe}"
    local transition_duration="${3:-1.5}"
    
    init_swww
    
    if [[ -f "$wallpaper_file" ]]; then
        echo "Setting wallpaper for theme: $theme"
        
        # Choose transition based on theme
        case "$theme" in
            "dark-space")
                # Space theme gets a fade transition
                swww img "$wallpaper_file" \
                    --transition-type fade \
                    --transition-duration 2.0 \
                    --transition-fps 60
                ;;
            "dune-orange") 
                # Desert theme gets a wipe transition
                swww img "$wallpaper_file" \
                    --transition-type wipe \
                    --transition-angle 30 \
                    --transition-duration 1.5 \
                    --transition-fps 60
                ;;
            "light")
                # Light theme gets a grow transition
                swww img "$wallpaper_file" \
                    --transition-type grow \
                    --transition-pos 0.5,0.5 \
                    --transition-duration 1.8 \
                    --transition-fps 60
                ;;
            *)
                # Default smooth transition
                swww img "$wallpaper_file" \
                    --transition-type "$transition_type" \
                    --transition-duration "$transition_duration" \
                    --transition-fps 60
                ;;
        esac
        
        echo "✓ Wallpaper set successfully"
    else
        echo "Warning: Wallpaper file $wallpaper_file not found"
        create_sample_wallpaper "$theme" "$wallpaper_file"
    fi
}

# Create sample wallpapers if they don't exist
create_sample_wallpaper() {
    local theme="$1"
    local output_file="$2"
    
    case "$theme" in
        "dark-space")
            # Create a space-themed wallpaper with stars effect
            convert -size 1920x1080 \
                -define gradient:vector="45,45 1875,1035" \
                gradient:"#0f172a-#1e293b-#312e81" \
                \( +clone -blur 0x1 \) \
                -compose multiply -composite \
                \( -size 1920x1080 xc:black +noise Random -channel G -separate +channel -threshold 99.8% -fill white +opaque black \) \
                -compose screen -composite \
                "$output_file" 2>/dev/null || {
                    # Fallback to simple gradient
                    convert -size 1920x1080 gradient:"#0f172a-#312e81" "$output_file" 2>/dev/null
                }
            ;;
        "dune-orange")
            # Create a desert/dune themed wallpaper
            convert -size 1920x1080 \
                -define gradient:vector="0,540 1920,540" \
                gradient:"#451a03-#92400e-#f59e0b" \
                \( +clone -blur 0x2 \) \
                -compose multiply -composite \
                "$output_file" 2>/dev/null || {
                    convert -size 1920x1080 gradient:"#451a03-#f59e0b" "$output_file" 2>/dev/null
                }
            ;;
        "light")
            # Create a clean light wallpaper
            convert -size 1920x1080 \
                -define gradient:vector="0,0 1920,1080" \
                gradient:"#f8fafc-#e2e8f0-#cbd5e1" \
                \( +clone -blur 0x1 \) \
                -compose multiply -composite \
                "$output_file" 2>/dev/null || {
                    convert -size 1920x1080 gradient:"#f8fafc-#cbd5e1" "$output_file" 2>/dev/null
                }
            ;;
    esac
    
    if [[ ! -f "$output_file" ]]; then
        echo "ImageMagick not available. Please add wallpapers manually to:"
        echo "$WALLPAPER_DIR/"
    fi
}

# Get current theme
get_current_theme() {
    if [[ -L "$CURRENT_THEME_FILE" ]]; then
        basename "$(readlink "$CURRENT_THEME_FILE")" .conf
    else
        echo "dark-space"
    fi
}

# Cycle through different transition effects
cycle_transition() {
    local theme="$1"
    local transitions=("fade" "wipe" "grow" "center" "outer" "random")
    local random_transition=${transitions[$RANDOM % ${#transitions[@]}]}
    set_wallpaper "$theme" "$random_transition" "2.0"
}

# Main execution
case "${1:-current}" in
    "dark-space"|"dune-orange"|"light")
        set_wallpaper "$1"
        ;;
    "current")
        current_theme=$(get_current_theme)
        set_wallpaper "$current_theme"
        ;;
    "cycle")
        # Cycle through themes with transitions
        current_theme=$(get_current_theme)
        case "$current_theme" in
            "dark-space") next_theme="dune-orange" ;;
            "dune-orange") next_theme="light" ;;
            "light") next_theme="dark-space" ;;
        esac
        cycle_transition "$next_theme"
        ;;
    "random")
        # Random wallpaper with random transition
        themes=("dark-space" "dune-orange" "light")
        random_theme=${themes[$RANDOM % ${#themes[@]}]}
        cycle_transition "$random_theme"
        ;;
    "init")
        # Initialize swww and set up wallpapers
        init_swww
        for theme in "dark-space" "dune-orange" "light"; do
            wallpaper_file="$WALLPAPER_DIR/$theme.jpg"
            if [[ ! -f "$wallpaper_file" ]]; then
                echo "Creating sample wallpaper: $theme"
                create_sample_wallpaper "$theme" "$wallpaper_file"
            fi
        done
        current_theme=$(get_current_theme)
        set_wallpaper "$current_theme"
        ;;
    "kill")
        # Stop swww daemon
        swww kill
        echo "Swww daemon stopped"
        ;;
    *)
        echo "Usage: $0 {dark-space|dune-orange|light|current|cycle|random|init|kill}"
        echo ""
        echo "Commands:"
        echo "  dark-space  - Set dark space theme wallpaper"
        echo "  dune-orange - Set dune orange theme wallpaper"
        echo "  light       - Set light theme wallpaper"
        echo "  current     - Set wallpaper for current theme"
        echo "  cycle       - Cycle to next theme with transition"
        echo "  random      - Random theme with random transition"
        echo "  init        - Initialize swww and sample wallpapers"
        echo "  kill        - Stop swww daemon"
        exit 1
        ;;
esac

#═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════
# Updated ~/.config/hypr/autostart.conf section for swww
# Replace the hyprpaper line with:

# Wallpaper daemon (swww)
exec-once = swww init
exec-once = ~/.config/hypr/scripts/swww-manager.sh init

#═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════  
# Updated theme switcher section for ~/.config/hypr/scripts/theme-switcher.sh

# Replace wallpaper switching section with:
# Update wallpaper with smooth transition
if command -v swww >/dev/null 2>&1; then
    ~/.config/hypr/scripts/swww-manager.sh "$NEXT_THEME"
elif command -v hyprpaper >/dev/null 2>&1; then
    # Fallback to hyprpaper
    pkill hyprpaper
    sleep 0.5
    hyprpaper &
fi

#═══════════════════════════════════════════════════════════════════════════════════════════════════════════════════
# ~/.config/hypr/scripts/wallpaper-effects.sh
#!/bin/bash
# Advanced wallpaper effects and transitions

WALLPAPER_DIR="$HOME/.config/hypr/wallpapers"

# Transition showcase - cycles through different effects
showcase_transitions() {
    local wallpaper="$1"
    
    if [[ ! -f "$wallpaper" ]]; then
        echo "Wallpaper file not found: $wallpaper"
        return 1
    fi
    
    echo "Showcasing swww transitions..."
    
    # Fade
    echo "1. Fade transition..."
    swww img "$wallpaper" --transition-type fade --transition-duration 2.0
    sleep 3
    
    # Wipe with angle
    echo "2. Wipe transition..."
    swww img "$wallpaper" --transition-type wipe --transition-angle 45 --transition-duration 1.5
    sleep 3
    
    # Grow from center
    echo "3. Grow transition..."
    swww img "$wallpaper" --transition-type grow --transition-pos 0.5,0.5 --transition-duration 2.0
    sleep 3
    
    # Center outward
    echo "4. Center transition..."
    swww img "$wallpaper" --transition-type center --transition-duration 1.8
    sleep 3
    
    # Outer inward
    echo "5. Outer transition..."
    swww img "$wallpaper" --transition-type outer --transition-duration 1.8
    sleep 3
    
    # Random effect
    echo "6. Random transition..."
    swww img "$wallpaper" --transition-type random --transition-duration 2.0
    
    echo "Transition showcase complete!"
}

# Live wallpaper effect (cycles between themes)
live_wallpaper() {
    local interval="${1:-10}"
    
    echo "Starting live wallpaper cycling (${interval}s intervals)"
    echo "Press Ctrl+C to stop"
    
    local themes=("dark-space" "dune-orange" "light")
    local transitions=("fade" "wipe" "grow" "center" "outer")
    
    while true; do
        for theme in "${themes[@]}"; do
            local wallpaper="$WALLPAPER_DIR/$theme.jpg"
            if [[ -f "$wallpaper" ]]; then
                local transition=${transitions[$RANDOM % ${#transitions[@]}]}
                local duration=$(echo "scale=1; $RANDOM % 20 / 10 + 1.5" | bc 2>/dev/null || echo "2.0")
                
                echo "Setting $theme with $transition transition (${duration}s)"
                swww img "$wallpaper" \
                    --transition-type "$transition" \
                    --transition-duration "$duration" \
                    --transition-fps 60
            fi
            sleep "$interval"
        done
    done
}

# Time-based wallpaper (changes based on time of day)
time_based_wallpaper() {
    local hour=$(date +%H)
    
    # Morning (6-11): Light theme
    # Afternoon (12-17): Dune theme  
    # Evening/Night (18-5): Dark space theme
    
    if [[ $hour -ge 6 && $hour -le 11 ]]; then
        theme="light"
        echo "Good morning! Setting light theme..."
    elif [[ $hour -ge 12 && $hour -le 17 ]]; then
        theme="dune-orange"
        echo "Good afternoon! Setting dune theme..."
    else
        theme="dark-space"  
        echo "Good evening! Setting dark space theme..."
    fi
    
    ~/.config/hypr/scripts/swww-manager.sh "$theme"
}

# Main execution
case "${1:-help}" in
    "showcase")
        wallpaper="${2:-$WALLPAPER_DIR/dark-space.jpg}"
        showcase_transitions "$wallpaper"
        ;;
    "live")
        interval="${2:-10}"
        live_wallpaper "$interval"
        ;;
    "time")
        time_based_wallpaper
        ;;
    *)
        echo "Advanced Swww Wallpaper Effects"
        echo ""
        echo "Usage: $0 {showcase|live|time}"
        echo ""
        echo "Commands:"
        echo "  showcase [wallpaper] - Demo all transition effects"
        echo "  live [interval]      - Cycle wallpapers every N seconds (default: 10)"
        echo "  time                 - Set wallpaper based on time of day"
        echo ""
        echo "Examples:"
        echo "  $0 showcase ~/.config/hypr/wallpapers/dark-space.jpg"
        echo "  $0 live 15"
        echo "  $0 time"
        ;;
esac