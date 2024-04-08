import numpy as np
import matplotlib.pyplot as plt

"""""""""""""""""""""""""""""""""""
        INPUT SIGNAL GENERATION
"""""""""""""""""""""""""""""""""""
# Function to convert float to hex
def float_to_q78_hex(f):
    q78_value = int(np.round(f * 2**8)) & 0xFFFF  
    return format(q78_value, '04X')  

# Signal parameters
T = 1 # period (seconds)
fs = 100 # sampling frequency (Hz)
time = np.linspace(0, T, fs, endpoint=False)

# Generate sine wave
frequency_sine = 1 # frequency (Hz)
sine_wave = np.sin(2 * np.pi * frequency_sine * time)

# Convert to Q7.8 and Hex
sine_q78 = np.round(sine_wave * (2**8)).astype(np.int8) / (2**8)
sine_q78_toHex = np.round(sine_wave * (2**8)).astype(np.int16) / (2**8)

# Print the values tabulated
print("Time (s) \t Sine Wave Data \t Q7.8 Data \t\t Hex Data")
for t, value, value_Q78, value_Q78_toHex in zip(time, sine_wave, sine_q78, sine_q78_toHex):
    hex_value = float_to_q78_hex(value_Q78_toHex)
    print(f"{t:.2f} \t\t {value:.8f} \t\t {value_Q78:.8f} \t\t {hex_value}")

# Plot
plt.stem(time, sine_wave)
plt.title('Sine Wave')
plt.xlabel('Time (s)')
plt.show()



"""""""""""""""""""""""""""""""""""
        .MIF FILE GENERATION
"""""""""""""""""""""""""""""""""""
# Parameters for the .mif file
depth = fs  
width = 16  

# Create and open the .mif file for writing
with open('src\input signal\sine_wave.mif', 'w') as mif_file:
    mif_file.write(f"DEPTH = {depth};\n")
    mif_file.write(f"WIDTH = {width};\n\n")
    mif_file.write("ADDRESS_RADIX = HEX;\n")
    mif_file.write("DATA_RADIX = HEX;\n\n")
    mif_file.write("CONTENT BEGIN\n")
    
    # Write the data in hexadecimal format
    for address, value_Q78_toHex in enumerate(sine_q78_toHex):
        hex_value = float_to_q78_hex(value_Q78_toHex)
        mif_file.write(f"\t{address:04X} : {hex_value};\n")
    
    # End the content of the .mif file
    mif_file.write("END;\n")

print("The .mif file was created successfully.")

