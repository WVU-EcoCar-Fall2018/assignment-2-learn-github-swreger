bungeeParams;

for k = 1:50
    simout = sim('bungee','StopTime','50');
    t = get(simout,'tout');
    y = get(simout,'yout');
    if min(y)>0
        break
    end
end
plot(t,y)
disp(['minimum k is ',num2str(k)])