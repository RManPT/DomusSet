net = patternnet(10);
net = train(net,Xnn,Xt);
view(net)
y = net(Xnn);
perf = perform(net,Xt,y);
classes = vec2ind(y);