# FibMad

**Little Fibonacci Server Proof of Concept**

## Usage

**From the `iex` terminal**

1. Run the application using the following command 
`iex -S mix `

2. You can use the app as follows
### Calculate
We want a *fibonnacci server* that calculates numbers like this:

```elixir
iex> Fibonacci.calculate(0)
{:ok, 0}
iex> Fibonacci.calculate(100)
{:ok, 354224848179261915075}
iex> Fibonacci.calculate(1)
{:ok, 1}
iex> Fibonacci.calculate(0)
{:ok, 0}
```

### Cache results
The server should look after performance, so that means not to calculate again the already calculated number.

### Multiple calculations
Also we want a function to retrieve multiple fibonnacci numbers in one call, this should be the faster as possible:

```elixir
iex> Fibonacci.calculate([0,1,100])
{:ok, [0, 1, 354224848179261915075]}
```

### Historification
Also the module should keep track of the already calculated numbers. The history should be ordered from first to last call.
We should be able to retrieve the history like this:

```elixir
iex> Fibonacci.history()
[{0, 0}, {100, 354224848179261915075}, {1, 1}, {0, 0}]
```

### Group and count
We want the fibonnacci server to group the history by the times that a number was calculated.


```elixir
iex> Fibonacci.history_count()
%{
   0 => 2,
   1 => 1,
   100 ==> 1
 }
```

**From the JSON endpoint**

1. Run the application using either of the following 
`iex -S mix `
or 
`mix run --no-halt`

2 You should notice  the following log 

```elixir
16:39:32.847 [info]  Starting application on port 5006
```

This indicates you have a JSON endpoint running at 

`http://localhost:5006`

Which you can use with links like the following

- http://localhost:5006/sum/6

- http://localhost:5006/sums/1,2,3,400,500

- http://localhost:5006/count

- http://localhost:5006/history

All the above endpoints should deliver a JSON payload of some sort 

**Reservations**

- [ ] You may notice the `history_counts` callback does not order items according to a sorted manner this is due to how maps work in Elixir see below an
excerpt from the [elixir docs](https://hexdocs.pm/elixir/Map.html#content)
```
Key-value pairs in a map do not follow any order (that's why the printed map in the example above has a different order than the map that was created).
```


- [ ] Did not handle negative numbers or parameter checking for non number inputs
- [ ] Did not property test the application for unknown edge cases 



Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/fib_mad](https://hexdocs.pm/fib_mad).

