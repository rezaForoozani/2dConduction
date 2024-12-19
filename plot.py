import numpy as np
import matplotlib.pyplot as plt

# Read data from the file
data = np.loadtxt('RESULT.dat')

# Extract X, Y, and T values
x = data[:, 0]  # Index 0 for x
y = data[:, 1]  # Index 1 for y
T = data[:, 2]  # Index 2 for temperature

# Reshape the arrays to match the grid
ni, nj = 61, 31
x = x.reshape((nj, ni))
y = y.reshape((nj, ni))
T = T.reshape((nj, ni))

# Plot the temperature distribution
plt.figure(figsize=(10, 6))
contour = plt.contourf(x, y, T, 20, cmap='jet')
plt.colorbar(contour)
plt.xlabel('X (m)')
plt.ylabel('Y (m)')
plt.title('Temperature Distribution in Square Plate')

# Save the figure
plt.savefig('temperature_distribution.png')

# Close the plot to avoid displaying it
plt.close()

