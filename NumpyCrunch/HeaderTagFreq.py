import numpy as np
import matplotlib.pyplot as plt

tags = ['<article> tags', '<header> tags', 'facebook ogp image metadata']
counts_2013 = [11850, 12738, 16875]
total_2013 = 173044
density_2013 = map(lambda x: x/float(total_2013), counts_2013)

N = len(counts_2013)


ind = np.arange(N)  # the x locations for the groups
width = 0.35       # the width of the bars

fig, ax = plt.subplots()
rects1 = ax.bar(ind, density_2013, width, color='r')

counts_2014 = [25438,24792,25195]
total_2014 = 193666
density_2014 = map(lambda x: x/float(total_2014), counts_2014)

rects2 = ax.bar(ind+width, density_2014, width, color='y')

# add some
ax.set_ylabel('Instances per record')
ax.set_title('Adoption of Modern Web Practices, 2013-2014')
ax.set_xticks(ind+width)
ax.set_xticklabels(tags)

ax.legend( (rects1[0], rects2[0]), ('2013', '2014') )

def autolabel(rects):
    # attach some text labels
    for rect in rects:
        height = rect.get_height()
        ax.text(rect.get_x()+rect.get_width()/2., 1.05*height, '%d'%int(height),
                ha='center', va='bottom')

autolabel(rects1)
autolabel(rects2)

plt.show()

