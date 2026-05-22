#include <unistd.h>
#include <fcntl.h>

int main() {

    char message[] = "Hello from C!\n";
    char buffer[32];

    int fd;
    fd = open("test.txt", O_CREAT | O_WRONLY, 0666);

    write(fd, message, sizeof(message) - 1);

    close(fd);
    fd = open("test.txt", O_RDONLY);

 
    read(fd, buffer, sizeof(message) - 1);

    close(fd);
    write(1, buffer, sizeof(message) - 1);

    return 0;
}