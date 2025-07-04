# Numerical Integration Tests 

In order to verify that all numerical integration schemes work as expected for the different element-source point arrangements we will define the problems as such:

## 0. Element coordinate definition

### 0.1 Linear Quadrilateral Element 1 (LQE1)

```julia
nodes = [
    1.0 1.0 0.0
    2.5 1.0 0.0
    2.5 2.5 0.0
    1.0 2.5 0.0
]

IEN = [
    1 2 3 4
]
```

## 1. Outer integration

### 1.1 Linear Triangular Element


### 1.2 Linear Quadrilateral Element


### 1.3 Quadratic Triangualar Element


### 1.4 Quadratic Triangular Element 




## 2. Near integration

### 2.1 Linear Quarilateral Element With Source Point on plane




### 2.2 Linear Quadrilateral Element With Source Out of plane



## 3. Singular integration