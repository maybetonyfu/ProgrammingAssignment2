## This module contains a user defined data structure
## that can memorise the calculation of inversing a matrix.
## The result will be saved in case a same computation is wanted again.


## makeCacheMatrix create a matrix wrapped in a list.
## The list contains four functions:
##   get: accesses the original matrix
##   set: replaces the original matrix
##   getinverse: accesses the cached inversed matrix (or NULL)
##   setinverse: caches a inversed matrix to save future calculation
makeCacheMatrix <- function(x = matrix()) {
    cached_inverse <- NULL
    get <- function() {
        x
    }
    set <- function(y) {
        x <<- y
        cached_inverse <<- NULL
    }
    getinverse <- function() {
        cached_inverse
    }
    setinverse <- function(inverse) {
        cached_inverse <<- inverse
    }
    list(
        set = set,
        get = get,
        setinverse = setinverse,
        getinverse = getinverse
    )
}


## cacheSolve behaves like solve, with a key difference being
## that solve operates on a normal matrix but cacheSolve operates on
## a matrix generated by makeCacheMatrix.
## Internally, cacheSolve will calculate the inverse once and save
## the result using cahceinverse function for next time.
cacheSolve <- function(x, ...) {
    inverse <- x$getinverse()
    if (!is.null(inverse)) {
        message("getting cached data")
        return(inverse)
    }
    data <- x$get()
    inverse <- solve(data, ...)
    x$setinverse(inverse)
    inverse
}