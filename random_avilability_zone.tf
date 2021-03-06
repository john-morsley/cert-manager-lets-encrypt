#      _____                 _                 
#     |  __ \               | |                
#     | |__) |__ _ _ __   __| | ___  _ __ ___  
#     |  _  // _` | '_ \ / _` |/ _ \| '_ ` _ \ 
#     | | \ \ (_| | | | | (_| | (_) | | | | | |
#     |_|  \_\__,_|_| |_|\__,_|\___/|_| |_| |_|
#                        _ _       _     _ _ _ _         
#              /\            (_) |     | |   (_) (_) |        
#             /  \__   ____ _ _| | __ _| |__  _| |_| |_ _   _ 
#            / /\ \ \ / / _` | | |/ _` | '_ \| | | | __| | | |
#           / ____ \ V / (_| | | | (_| | |_) | | | | |_| |_| |
#          /_/    \_\_/ \__,_|_|_|\__,_|_.__/|_|_|_|\__|\__, |
#                ______                                  __/ |
#               |___  /                                 |___/ 
#                  / / ___  _ __   ___  
#                 / / / _ \| '_ \ / _ \
#                / /_| (_) | | | |  __/
#               /_____\___/|_| |_|\___|

resource "random_shuffle" "availability-zones" {
  input = data.aws_availability_zones.available.names
  result_count = 1
}