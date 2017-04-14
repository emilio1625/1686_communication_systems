function x = pseudoanalog(f0, N, t)
    x = 0 * t;
    for i = 1:N
        A = rand(1);
        O = rand(1) * pi;
        x = x + A * cos(2 * pi * i * f0 * t - O);
    end
