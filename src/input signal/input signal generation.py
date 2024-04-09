import numpy as np
import matplotlib.pyplot as plt
from scipy.signal import firwin
import os

"""""""""""""""""""""""""""""""""""
        INPUT SIGNAL GENERATION
"""""""""""""""""""""""""""""""""""

# Function to convert float to hex
#   f = float value to convert to hex
def float_to_q78_hex(f):
    q78_value = int(np.round(f * 2**8)) & 0xFFFF  
    return format(q78_value, '04X')  

# Function to create a sine_wave
#   time = signal in time (seconds)
#   frequency = sine wave frequency
def create_sine_wave(time, frequency):
    return np.sin(2 * np.pi * frequency * time)

# Funtion to convert signal data to Q7.8
def convert_toQ78(signal):
    return np.round(signal * (2**8)).astype(np.int8) / (2**8)

# Funtion to convert signal data in Q7.8 to Hex
def convert_Q78_toHex(signal):
    return np.round(signal * (2**8)).astype(np.int16) / (2**8)

# Function to print the signal values tabulated
def print_data(time, signal, signal_q78, signal_Hex):
    print("\n*** INPUT SIGNAL ***\n")
    print("Time (s) \t Signal Data \t\t Q7.8 Data \t\t Hex Data")
    for t, value, value_Q78, value_Q78_toHex in zip(time, signal, signal_q78, signal_Hex):
        hex_value = float_to_q78_hex(value_Q78_toHex)
        print(f"{t:.2f} \t\t {value:.8f} \t\t {value_Q78:.8f} \t\t {hex_value}")

# Funtion to plot signal
def plot_signal(x_signal, y_signal):
    plt.stem(x_signal, y_signal)
    plt.title('Wave')
    plt.xlabel('Time (s)')
    plt.show()

# Generate sine wave
period = 5
samples = 39200 * 5
time = np.linspace(0, period, samples, endpoint=False)
frequency = 1
sine_wave = create_sine_wave(time, frequency)

# Convert to Q7.8 and Hex
sine_q78 = convert_toQ78(sine_wave)
sine_q78_Hex = convert_Q78_toHex(sine_wave)

# Print data
print_data(time, sine_wave, sine_q78, sine_q78_Hex)

# Plot
plot_signal(time, sine_wave)



"""""""""""""""""""""""""""""""""""
        COEFFICIENT GENERATION
"""""""""""""""""""""""""""""""""""

# Function to generate the filter coefficients
#   frequency = filter cutoff frequency
#   filter_order = filter order (number of coefficients)    
def create_coefficients(frequency, filter_order):
    filter_coefficients = firwin(filter_order + 1, frequency)
    max_abs_coefficient = max(abs(filter_coefficients))
    normalized_coefficients = filter_coefficients / max_abs_coefficient

    if max(abs(normalized_coefficients)) > 1:
        normalized_coefficients /= max(abs(normalized_coefficients))

    normalized_coefficients = np.round(normalized_coefficients, 8)

    return normalized_coefficients

# Function to print the coefficients values tabulated
def print_data(signal, signal_q78, signal_Hex):
    print("\n*** COEFFICIENTS ***\n")
    print("Coefficients Data \t Q7.8 Data \t\t Hex Data")
    for value, value_Q78, value_Q78_toHex in zip(signal, signal_q78, signal_Hex):
        hex_value = float_to_q78_hex(value_Q78_toHex)
        print(f"{value:.8f} \t\t {value_Q78:.8f} \t\t {hex_value}")

# Generate coefficients
frequency = 0.1
filter_order = 31

coefficients = create_coefficients(frequency, filter_order)
coefficients_q78 = convert_toQ78(coefficients)
coefficients_q78_Hex = convert_Q78_toHex(coefficients_q78)

print_data(coefficients, coefficients_q78, coefficients_q78_Hex)


"""""""""""""""""""""""""""""""""""
        .MIF FILE GENERATION
"""""""""""""""""""""""""""""""""""

# Function to create .mif file
def create_mif_file(depth, width, sine_q78_Hex, coefficients_q78_Hex):
    # Directory path
    current_directory = os.path.dirname(os.path.abspath(__file__))
    os.makedirs(current_directory, exist_ok=True)

    # Create and open the .mif file for writing
    with open(os.path.join(current_directory, 'sine_wave.mif'), 'w') as mif_file:
        mif_file.write(f"DEPTH = {depth};\n")
        mif_file.write(f"WIDTH = {width};\n\n")
        mif_file.write("ADDRESS_RADIX = DEC;\n")
        mif_file.write("DATA_RADIX = HEX;\n\n")
        mif_file.write("CONTENT BEGIN\n")
        
        pos = 0
        hex_values_concatenated = "" 

        # Write the signal data in hexadecimal format
        for address, value_Q78_toHex in enumerate(sine_q78_Hex):
            hex_value = float_to_q78_hex(value_Q78_toHex)
            hex_values_concatenated += hex_value  
            
            if len(hex_values_concatenated) == 64:
                mif_file.write(f"\t{pos} : {hex_values_concatenated};\n")
                hex_values_concatenated = "" 
                pos += 1
        
        hex_values_concatenated = "" 
        
        # Write the coefficients data
        for value_Q78_Hex in coefficients_q78_Hex:
            hex_value = float_to_q78_hex(value_Q78_Hex)
            hex_values_concatenated += hex_value  

            if len(hex_values_concatenated) == 64:
                mif_file.write(f"\t{pos} : {hex_values_concatenated};\n")
                hex_values_concatenated = "" 
                pos += 1

        # Initialize remaining memory locations with zeros
        for address in range(pos, depth):
            mif_file.write(f"\t{address} : {'0'*64};\n")        

        # End the content of the .mif file
        mif_file.write("END;")

    print("\nThe .mif file was created successfully.\n")

# Create .mif file
depth = 12288  
width = 256

create_mif_file(depth, width, sine_q78_Hex, coefficients_q78_Hex)

# LINE 0 - 12249        : AUDIO FILE
# LINE 12250 - 12251    : COEFFICIENTS
# LINE 12252 - 12287    : EMPY SPACE