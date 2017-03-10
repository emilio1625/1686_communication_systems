function plot_coef(n)
    global amp; global w; global t;
    [An, On] = coef(n);
    x = 0 .* t .+ amp / 2;
    for i = 1:n
        x = x + An(i) * cos(w * i * t .- On(i));
    endfor
    plot(t, x);