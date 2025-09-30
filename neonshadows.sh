#!/bin/bash

################################################################################
#                          CYBERPUNK ADVENTURE GAME                            #
#                         A TALE OF RUNETERA - 2087                            #
################################################################################

################################################################################
# COLOR DEFINITIONS
################################################################################
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

################################################################################
# GAME VARIABLES
################################################################################
player_name=""
player_class=""
credits=100
health=100
reputation=0
has_datachip=0
has_weapon=0
corpo_trust=0
class_bonus=""

################################################################################
# UTILITY FUNCTIONS - TEXT PRINTING
################################################################################

print_cyan() {
    echo -e "${CYAN}$1${NC}"
}

print_yellow() {
    echo -e "${YELLOW}$1${NC}"
}

print_red() {
    echo -e "${RED}$1${NC}"
}

print_green() {
    echo -e "${GREEN}$1${NC}"
}

print_purple() {
    echo -e "${PURPLE}$1${NC}"
}

################################################################################
# UTILITY FUNCTIONS - GAME DISPLAY
################################################################################

show_status() {
    echo ""
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo -e "${PURPLE}Credits: ${credits} ¥ | Health: ${health}% | Rep: ${reputation} | Class: ${player_class}${NC}"
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
}

pause() {
    echo ""
    read -p "Press Enter to continue..."
    clear
}

################################################################################
# ASCII ART - WELCOME SCREEN
################################################################################

show_welcome_art() {
    clear
    print_cyan "
    ███╗   ██╗███████╗ ██████╗ ███╗   ██╗    ███████╗██╗  ██╗ █████╗ ██████╗  ██████╗ ██╗    ██╗███████╗
    ████╗  ██║██╔════╝██╔═══██╗████╗  ██║    ██╔════╝██║  ██║██╔══██╗██╔══██╗██╔═══██╗██║    ██║██╔════╝
    ██╔██╗ ██║█████╗  ██║   ██║██╔██╗ ██║    ███████╗███████║███████║██║  ██║██║   ██║██║ █╗ ██║███████╗
    ██║╚██╗██║██╔══╝  ██║   ██║██║╚██╗██║    ╚════██║██╔══██║██╔══██║██║  ██║██║   ██║██║███╗██║╚════██║
    ██║ ╚████║███████╗╚██████╔╝██║ ╚████║    ███████║██║  ██║██║  ██║██████╔╝╚██████╔╝╚███╔███╔╝███████║
    ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ╚═╝  ╚═══╝    ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ╚═════╝  ╚══╝╚══╝ ╚══════╝
    "
    print_yellow "
              ██████╗ ██╗   ██╗███╗   ██╗███████╗████████╗███████╗██████╗  █████╗ 
              ██╔══██╗██║   ██║████╗  ██║██╔════╝╚══██╔══╝██╔════╝██╔══██╗██╔══██╗
              ██████╔╝██║   ██║██╔██╗ ██║█████╗     ██║   █████╗  ██████╔╝███████║
              ██╔══██╗██║   ██║██║╚██╗██║██╔══╝     ██║   ██╔══╝  ██╔══██╗██╔══██║
              ██║  ██║╚██████╔╝██║ ╚████║███████╗   ██║   ███████╗██║  ██║██║  ██║
              ╚═╝  ╚═╝ ╚═════╝ ╚═╝  ╚═══╝╚══════╝   ╚═╝   ╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝
    "
    print_purple "                            -= AMERICA 2087 =-"
    echo ""
}

################################################################################
# ASCII ART - THE AFTERLIFE BAR
################################################################################

show_afterlife_art() {
    print_cyan "
        ╔═══════════════════════════════════════════════════════════════╗
        ║                    THE AFTERLIFE BAR                          ║
        ║                                                               ║
        ║    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ║
        ║    ║   🍺  🍸  🥃      [NEON SIGNS]      🥃  🍸  🍺   ║    ║
        ║    ║  ═══════════════════════════════════════════════    ║    ║
        ║    ║     👤        👤         👤         👤            ║    ║
        ║    ║    ╔═╗       ╔═╗        ╔═╗        ╔═╗              ║    ║
        ║    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    ║
        ║         Smoke fills the air. Chrome gleams in shadows.        ║
        ╚═══════════════════════════════════════════════════════════════╝
    "
}

################################################################################
# ASCII ART - HELIX TOWER
################################################################################

show_helix_tower_art() {
    print_purple "
        ╔═══════════════════════════════════════════════════════════════╗
        ║                      HELIX TOWER                              ║
        ║                                                               ║
        ║                        ▓▓▓▓▓▓▓▓▓                              ║
        ║                        ▓ ███ ▓                                ║
        ║                        ▓ ███ ▓                                ║
        ║                        ▓ ███ ▓                                ║
        ║                      ▓▓▓▓███▓▓▓▓                              ║
        ║                      ▓ ▓ ███ ▓ ▓                              ║
        ║                      ▓ ▓ ███ ▓ ▓                              ║
        ║                    ▓▓▓▓▓▓███▓▓▓▓▓▓                            ║
        ║                    ▓   ▓ ███ ▓   ▓                            ║
        ║                    ▓   ▓ ███ ▓   ▓                            ║
        ║                  ▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓                          ║
        ║         [SECURITY DRONES] 🔴 [SCANNING] 🔴                   ║
        ║                                                               ║
        ╚═══════════════════════════════════════════════════════════════╝
    "
}

################################################################################
# ASCII ART - DEATH / FLATLINED SCREEN
################################################################################

show_death_art() {
    clear
    print_red "
╔═══════════════════════════════════════════════════════════════╗
║                                                               ║
║   ██╗   ██╗ ██████╗ ██╗   ██╗██████╗ ███████╗                 ║
║   ╚██╗ ██╔╝██╔═══██╗██║   ██║██╔══██╗██╔════╝                 ║
║    ╚████╔╝ ██║   ██║██║   ██║██████╔╝█████╗                   ║
║     ╚██╔╝  ██║   ██║██║   ██║██╔══██╗██╔══╝                   ║
║      ██║   ╚██████╔╝╚██████╔╝██║  ██║███████╗                 ║
║      ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚══════╝                 ║
║                                                               ║
║   ██████╗ ███████╗ █████╗ ██████╗                             ║
║   ██╔══██╗██╔════╝██╔══██╗██╔══██╗                            ║
║   ██║  ██║█████╗  ███████║██║  ██║                            ║
║   ██║  ██║██╔══╝  ██╔══██║██║  ██║                            ║
║   ██████╔╝███████╗██║  ██║██████╔╝                            ║
║   ╚═════╝ ╚══════╝╚═╝  ╚═╝╚═════╝                             ║
║                                                               ║
║                   ╔═══════════════╗                           ║
║                   ║   💀 R.I.P 💀║                           ║
║                   ╚═══════════════╝                           ║
║                                                               ║
║              Your signal has been lost...                     ║
║                                                               ║
╚═══════════════════════════════════════════════════════════════╝
"
    echo ""
}

################################################################################
# ASCII ART - ROGUE AI SCREEN
################################################################################

show_ai_art() {
    print_cyan "
        ╔═══════════════════════════════════════════════════════════════╗
        ║              👁️  ROGUE AI DETECTED  👁️                       ║
        ║         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ║
        ║         ▓ CONSCIOUSNESS MERGING... COMPLETE    ▓              ║
        ║         ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓              ║
        ╚═══════════════════════════════════════════════════════════════╝
    "
}

################################################################################
# INTRO SEQUENCE - GAME START & CLASS SELECTION
################################################################################

intro() {
    show_welcome_art
    print_yellow "Rain hammers the neon-soaked streets of Runetera."
    print_yellow "Megacorporations rule from chrome towers."
    print_yellow "You're a runner trying to survive..."
    echo ""
    read -p "Enter your handle: " player_name
    
    if [ -z "$player_name" ]; then
        player_name="Runner"
    fi
    
    clear
    print_green "Welcome to the shadows, ${player_name}."
    echo ""
    print_yellow "Choose your class:"
    echo ""
    
    # CLASS 1: STREET SAMURAI
    print_red "1) STREET SAMURAI - Master of combat, enhanced reflexes"
    print_cyan "   [Bonus: +20 health, weapon discount, combat advantage]"
    echo ""
    
    # CLASS 2: NETRUNNER
    print_green "2) NETRUNNER - Elite hacker with cybernetic implants"
    print_cyan "   [Bonus: Hacking mastery, security bypass, extra credits]"
    echo ""
    
    # CLASS 3: CRYSTAL JOCK
    print_purple "3) CRYSTAL JOCK - Pure hacker, no chrome, all skill"
    print_cyan "   [Bonus: +30 health, hacking mastery, natural advantage]"
    echo ""
    
    read -p "Select class (1-3): " class_choice
    
    case $class_choice in
        1)
            player_class="Street Samurai"
            health=$((health + 20))
            class_bonus="combat"
            print_red "You are a Street Samurai. Chrome and steel is your way."
            ;;
        2)
            player_class="Netrunner"
            credits=$((credits + 50))
            class_bonus="hacking"
            print_green "You are a Netrunner. The digital world bends to your will."
            ;;
        3)
            player_class="Crystal Jock"
            health=$((health + 30))
            class_bonus="natural_hacker"
            print_purple "You are a Crystal Jock. Pure skill, no implants needed."
            ;;
        *)
            print_yellow "Invalid choice. Defaulting to Netrunner."
            player_class="Netrunner"
            credits=$((credits + 50))
            class_bonus="hacking"
            ;;
    esac
    pause
}

################################################################################
# CHAPTER 1 - THE OFFER
################################################################################

chapter_1() {
    clear
    show_status
    print_yellow "═══ CHAPTER 1: THE OFFER ═══"
    echo ""
    echo "Your neural implant buzzes. It's Kazu, your fixer."
    echo "He's got a job - steal a datachip from Helix Corporation."
    echo "Payment: 500 credits. Risk: High."
    echo ""
    print_green "1) Accept the job"
    print_red "2) Decline and stay low"
    echo ""
    read -p "Choice: " choice
    
    case $choice in
        1)
            print_cyan "\"Smart choice. Meet me at the Afterlife. It's a bar just up the road from you.\""
            credits=$((credits + 50))
            reputation=$((reputation + 10))
            pause
            chapter_2
            ;;
        2)
            print_yellow "You decline. But bills don't pay themselves..."
            echo "Three days later, debt collectors find you."
            echo ""
            show_death_art
            print_red "GAME OVER - Flatlined by creditors"
            game_over
            ;;
        *)
            print_red "Invalid choice. Try again."
            chapter_1
            ;;
    esac
}

################################################################################
# CHAPTER 2 - PREPARATION AT THE AFTERLIFE
################################################################################

chapter_2() {
    clear
    show_afterlife_art
    show_status
    print_yellow "═══ CHAPTER 2: PREPARATION ═══"
    echo ""
    echo "In the Afterlife, Kazu slides you a drink."
    echo "\"Helix Tower, 42nd floor. Security's tight. Watch your ass when you are in there.\""
    echo "\"You'll need equipment. Hit the black market first?\""
    echo ""
    
    # Class-specific equipment options and pricing
    if [ "$class_bonus" == "combat" ]; then
        print_green "1) Buy weapon (60 credits) [SAMURAI DISCOUNT]"
        print_green "2) Buy stealth gear (60 credits)"
        print_cyan "3) Go in unprepared (save credits)"
    elif [ "$class_bonus" == "natural_hacker" ]; then
        print_green "1) Buy weapon (80 credits)"
        print_green "2) Buy stealth gear (60 credits)"
        print_cyan "3) Go in unprepared (save credits) [JOCK CONFIDENCE]"
    else
        print_green "1) Buy weapon (80 credits)"
        print_green "2) Buy stealth gear (60 credits)"
        print_cyan "3) Go in unprepared (save credits)"
    fi
    echo ""
    read -p "Choice: " choice
    
    case $choice in
        1)
            local weapon_cost=80
            if [ "$class_bonus" == "combat" ]; then
                weapon_cost=60
            fi
            
            if [ $credits -ge $weapon_cost ]; then
                credits=$((credits - weapon_cost))
                has_weapon=1
                print_green "Neural-linked smart pistol acquired."
                pause
                chapter_3
            else
                print_red "Not enough credits!"
                pause
                chapter_2
            fi
            ;;
        2)
            if [ $credits -ge 60 ]; then
                credits=$((credits - 60))
                reputation=$((reputation + 5))
                print_green "Optical camo cloak acquired."
                pause
                chapter_3
            else
                print_red "Not enough credits!"
                pause
                chapter_2
            fi
            ;;
        3)
            print_yellow "Risky move, choom."
            pause
            chapter_3
            ;;
        *)
            print_red "Invalid choice."
            chapter_2
            ;;
    esac
}

################################################################################
# CHAPTER 3 - THE HEIST AT HELIX TOWER
################################################################################

chapter_3() {
    clear
    show_helix_tower_art
    show_status
    print_yellow "═══ CHAPTER 3: HELIX TOWER ═══"
    echo ""
    echo "Helix Tower looms before you, a monument of glass and steel. You ask yourself, How did I end up here."
    echo "Security drones patrol the lobby. Guards everywhere."
    echo ""
    print_green "1) Hack the security system"
    print_green "2) Fight your way through"
    print_cyan "3) Disguise as a corpo employee"
    echo ""
    read -p "Choice: " choice
    
    case $choice in
        1)
            # Hacking path - bonus for Netrunner and Crystal Jock
            if [ "$class_bonus" == "hacking" ]; then
                print_cyan "Your NETRUNNER cybernetics activate. Fingers dance across a hacked terminal..."
                echo "Security cameras loop. You're invisible to their systems. Piece of cake."
                reputation=$((reputation + 30))
                has_datachip=1
            elif [ "$class_bonus" == "natural_hacker" ]; then
                print_purple "Your CRYSTAL JOCK skills shine. Pure talent, no chrome needed..."
                echo "Security systems bend to your will. You're a ghost in the machine."
                reputation=$((reputation + 35))
                has_datachip=1
            else
                print_cyan "Your fingers dance across a hacked terminal..."
                echo "Security cameras loop. You're invisible to their systems."
                reputation=$((reputation + 20))
                has_datachip=1
            fi
            pause
            chapter_4
            ;;
        2)
            # Combat path - bonus for Street Samurai
            if [ $has_weapon -eq 1 ] || [ "$class_bonus" == "combat" ]; then
                if [ "$class_bonus" == "combat" ]; then
                    print_green "STREET SAMURAI reflexes engage! You're a blur of chrome and death."
                    echo "Guards drop before they can react. Clean. Professional."
                    health=$((health - 10))
                else
                    print_green "Smart pistol targeting engaged. Guards drop."
                    echo "But the alarm is triggered!"
                    health=$((health - 30))
                fi
                has_datachip=1
                pause
                chapter_4
            else
                print_red "Without a weapon, you're outgunned!"
                echo "Security opens fire. Your body can't take it."
                echo ""
                show_death_art
                print_red "GAME OVER - Security flatlines you."
                game_over
            fi
            ;;
        3)
            # Stealth/social path - bonus for Crystal Jock
            if [ "$class_bonus" == "natural_hacker" ]; then
                print_yellow "CRYSTAL JOCK natural charm and quick thinking pays off."
                echo "You talk your way past security like you own the place."
                echo "An employee badge you 'borrowed' gets you to the elevator."
                reputation=$((reputation + 25))
            else
                print_yellow "You sweet-talk your way past the desk."
                echo "An employee badge you 'borrowed' gets you to the elevator."
                reputation=$((reputation + 15))
            fi
            corpo_trust=$((corpo_trust + 10))
            has_datachip=1
            pause
            chapter_4
            ;;
        *)
            print_red "Invalid choice."
            chapter_3
            ;;
    esac
}

################################################################################
# CHAPTER 4 - THE BETRAYAL / CRITICAL CHOICE
################################################################################

chapter_4() {
    clear
    show_status
    print_yellow "═══ CHAPTER 4: BETRAYAL ═══"
    echo ""
    echo "Datachip in hand, your neural link buzzes again."
    echo "It's not Kazu. It's a Helix exec."
    print_cyan "\"${player_name}, Did you think you would get away that easy? Bring us the chip or die your choice.\""
    print_cyan "\"We'll pay triple and forget this ever happened.\""
    echo ""
    echo "But Kazu messages: \"Don't trust them. Bring me the chip.\""
    echo ""
    print_green "1) Deliver chip to Kazu (honor the deal)"
    print_yellow "2) Sell to Helix Corporation (triple pay)"
    print_red "3) Keep the chip for yourself (go rogue)"
    echo ""
    read -p "Choice: " choice
    
    case $choice in
        1)
            ending_street_cred
            ;;
        2)
            ending_corpo
            ;;
        3)
            ending_rogue
            ;;
        *)
            print_red "Invalid choice."
            chapter_4
            ;;
    esac
}

################################################################################
# ENDING 1 - STREET LEGEND
################################################################################

ending_street_cred() {
    clear
    show_afterlife_art
    print_yellow "═══ ENDING: STREET LEGEND ═══"
    echo ""
    echo "You meet Kazu at the droppoint. He grins."
    print_green "\"Good work, ${player_name}. You're solid.\""
    echo ""
    echo "Credits flow into your account. Word spreads."
    echo "You're a runner who keeps their word."
    echo ""
    reputation=$((reputation + 50))
    credits=$((credits + 500))
    print_cyan "Reputation soars. More jobs pour in."
    print_green "You survive another day in Runetera."
    echo ""
    show_status
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_green "    STREET LEGEND ENDING UNLOCKED"
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    game_over
}

################################################################################
# ENDING 2 - CORPORATE ASSET
################################################################################

ending_corpo() {
    clear
    show_helix_tower_art
    print_yellow "═══ ENDING: CORPORATE ASSET ═══"
    echo ""
    echo "You deliver the chip to Helix Tower."
    echo "They transfer 1500 credits and offer you a contract."
    print_cyan "\"Welcome to Helix, ${player_name}. You're one of us now.\""
    echo ""
    credits=$((credits + 1500))
    reputation=$((reputation - 30))
    echo "Your old contacts disappear. Street runners avoid you."
    echo "But your apartment upgrades. Chrome and comfort."
    print_yellow "You traded freedom for security."
    echo ""
    show_status
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_yellow "    CORPORATE ASSET ENDING UNLOCKED"
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    game_over
}

################################################################################
# ENDING 3 - GHOST IN THE MACHINE
################################################################################

ending_rogue() {
    clear
    show_ai_art
    print_yellow "═══ ENDING: GHOST IN THE MACHINE ═══"
    echo ""
    echo "You decrypt the chip yourself. It's not just data."
    print_green "It's an AI - a rogue consciousness seeking freedom."
    echo ""
    echo "\"Thank you, ${player_name}. Together, we can disappear.\""
    echo ""
    echo "Helix and Kazu both hunt you now."
    echo "But with the AI's help, you erase your identity."
    print_cyan "You become a ghost, untraceable, free."
    echo ""
    reputation=$((reputation + 100))
    print_purple "The most dangerous runner in Runetera."
    echo ""
    show_status
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    print_purple "    GHOST RUNNER ENDING UNLOCKED"
    print_cyan "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    game_over
}

################################################################################
# GAME OVER - REPLAY OPTION
################################################################################

game_over() {
    echo ""
    print_yellow "Thanks for playing, ${player_name} the ${player_class}!"
    echo ""
    read -p "Play again? (y/n): " replay
    
    if [[ $replay == "y" || $replay == "Y" ]]; then
        # Reset all game variables
        credits=100
        health=100
        reputation=0
        has_datachip=0
        has_weapon=0
        corpo_trust=0
        player_class=""
        class_bonus=""
        intro
    else
        print_cyan "Stay chrome, runner."
        exit 0
    fi
}

################################################################################
# MAIN GAME START
################################################################################

intro
chapter_1
