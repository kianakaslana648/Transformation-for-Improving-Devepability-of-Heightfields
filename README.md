# Transformation-of-Improving-Devepability-of-Heightfields

### Introduction

A developable surface is a surface with zero Gaussian curvature everywhere, which can be proved to be flattened onto a plane without distortion. We can somehow have the discrete version definition of local Gaussian curvature over surfaces composed of triangle patches, with the vertices in the form of a heightfield. With the numerical method of ADMM for a specific group of convex programs, we can optimize the global sum of Gaussian curvature, which means we are improving the developability of the surface.

### Referred Paper
https://www.dgp.toronto.edu/projects/compressed-developables/

### Primary Work
Bidirectional transformations between 3-dimensional points to heightfields.  

Transformation from a heightfield with irregular-triangle-based grid onto a corresponding hexagonal grid through interpolation.

Application of ADMM to minimize the Gaussian curvature(improve the devepability). 

$\textbf{Sorry for some of the messy instruction text. The original work was done in Chinese and I have no time to fix that.}$
