function [Eles, Nodes] = get_Inf(j,k)
% 函数作用：输入X轴的结点数和Y轴的节点数，计算Eles和Nodes

Nx = j; 
Ny = k;
numelx = Nx; %X轴单元数量
numely = Ny; %Y轴单元数量
numnodx = numelx + 1; %x方向节点个数比单元个数多1
numnody = numely + 1; %y方向节点个数比单元个数多1
nel = 3; %定义单元节点数
coordx = linspace(0,1,numnodx)';
coordy = linspace(0,1,numnody)'; 
[X, Y] = meshgrid(coordx,coordy); %X和Y分别表示结点坐标
X = X';Y = Y';coord = [X(:) Y(:)];
A = reshape(1:(numnodx*numnody),numnodx,numnody);%结点总数顺序编号
for i = 1:(numnodx-1)*(numnody-1)
    x = rem(i,numnodx-1);%x表示从左往右数的位置
    if x == 0
        x = numnodx-1;
    end
    y = ceil(i/(numnodx-1));%y表示从下往上数的位置
    a = A(x:x+1,y:y+1);%将两个三角形单元连接
    a_vec = a(:);
    connect(2*i-1:2*i,1:nel) = [a_vec([1 2 3])';a_vec([3 2 4])'];
end
Eles  = [reshape(1:size(connect,1),size(connect,1),1) connect];%单元个数
Nodes = [reshape(1:size(coord,1),size(coord,1),1) coord];%结点个数

end