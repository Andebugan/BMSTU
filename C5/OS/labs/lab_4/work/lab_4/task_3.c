#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

int pid;
int child_pid_1;
int child_pid_2;

int main(void)
{
    printf("Parent process|pid: %d|group: %d\n", getpid(), getpgrp());

    child_pid_1 = fork();
    if (child_pid_1 == -1)
    {
        perror("Error: fork cannot be executed!");
        return 1;
    }
    else if (child_pid_1 == 0)
    {
        printf("Child №1 process|pid: %d|ppid: %d|group: %d\n", getpid(), getppid(), getpgrp());
        int exec_result = execlp("/media/sf_manjaro_shared/BMSTU/OS/labs/lab_4/test/test_sort_str.exe", 0);
        if (exec_result == -1)
            perror("Error: execlp cannot be executed!");
            return 2;
    }

    child_pid_2 = fork();
    if (child_pid_2 == -1)
    {
        perror("Error: fork cannot be executed!");
        return 1;
    }
    else if (child_pid_2 == 0)
    {
        printf("Child №2 process|pid: %d|ppid: %d|group: %d\n", getpid(), getppid(), getpgrp());
        int exec_result = execlp("/media/sf_manjaro_shared/BMSTU/OS/labs/lab_4/test/test_min_max.exe", "10", "5", "-1", "15", 0);
        if (exec_result == -1)
            perror("Error: execlp cannot be executed!");
            return 2;
    }

    int return_status[2];
    pid_t child_pid[2];
    for (int i = 0; i < 2; i++)
    {
        child_pid[i] = wait(&(return_status[i]));
        printf("Child process finished|pid = %d|status = %d\n", child_pid[i], return_status[i]);
        int status_value;
        if (WIFEXITED(status_value))
        {
            printf("Child process exited succesfully with code %d\n", WEXITSTATUS(status_value));
        }
    }

    printf("Child pids of parent process|child №1: %d|child №2: %d\n", child_pid_1, child_pid_1);
    printf("End of parent process\n");
    return 0;
}