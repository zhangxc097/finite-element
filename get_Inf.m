function [Eles, Nodes] = get_Inf(j,k)
% �������ã�����X��Ľ������Y��Ľڵ���������Eles��Nodes

Nx = j; 
Ny = k;
numelx = Nx; %X�ᵥԪ����
numely = Ny; %Y�ᵥԪ����
numnodx = numelx + 1; %x����ڵ�����ȵ�Ԫ������1
numnody = numely + 1; %y����ڵ�����ȵ�Ԫ������1
nel = 3; %���嵥Ԫ�ڵ���
coordx = linspace(0,1,numnodx)';
coordy = linspace(0,1,numnody)'; 
[X, Y] = meshgrid(coordx,coordy); %X��Y�ֱ��ʾ�������
X = X';Y = Y';coord = [X(:) Y(:)];
A = reshape(1:(numnodx*numnody),numnodx,numnody);%�������˳����
for i = 1:(numnodx-1)*(numnody-1)
    x = rem(i,numnodx-1);%x��ʾ������������λ��
    if x == 0
        x = numnodx-1;
    end
    y = ceil(i/(numnodx-1));%y��ʾ������������λ��
    a = A(x:x+1,y:y+1);%�����������ε�Ԫ����
    a_vec = a(:);
    connect(2*i-1:2*i,1:nel) = [a_vec([1 2 3])';a_vec([3 2 4])'];
end
Eles  = [reshape(1:size(connect,1),size(connect,1),1) connect];%��Ԫ����
Nodes = [reshape(1:size(coord,1),size(coord,1),1) coord];%������

end