Received:  by oss.sgi.com id <S553742AbQJSWa5>;
	Thu, 19 Oct 2000 15:30:57 -0700
Received: from gateway-490.mvista.com ([63.192.220.206]:15611 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553735AbQJSWad>;
	Thu, 19 Oct 2000 15:30:33 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id e9JMTBx07311;
	Thu, 19 Oct 2000 15:29:11 -0700
Message-ID: <39EF765A.EC787ED6@mvista.com>
Date:   Thu, 19 Oct 2000 15:31:54 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     linux-mips@oss.sgi.com
Subject: pthread_create() gets BUS ERROR
Content-Type: multipart/mixed;
 boundary="------------E4DC32CC784EC842672D31C4"
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

This is a multi-part message in MIME format.
--------------E4DC32CC784EC842672D31C4
Content-Type: text/plain; charset=iso-2022-jp
Content-Transfer-Encoding: 7bit


I am running a simple pthread_create() test.  The thread gets created,
but the creating thread gets BUS error after the function call.  In
fact, it gets SIGUSR1 signal.  Does anybody know what is wrong here?

It looks to me that creating thread is waiting for the created thread to
start up, but somehow did not install the signal handler correctly!?

I am running with the "stable" toolchain that I generated recently,
i.e., binutil 2.8.1, egcs 1.0.3a and glibc2.0.6.

I attached the program and the strace output.

Thanks.

Jun
--------------E4DC32CC784EC842672D31C4
Content-Type: text/plain; charset=iso-2022-jp;
 name="pthread.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="pthread.c"

#include <pthread.h>
#include <stdio.h>
#include <errno.h>

typedef void * (*pthread_func_t) (void *);


void myfunc(void *arg)
{
   printf("slave : myfunc runs.\n");
}

main()
{
    int ret;

    pthread_t thread;

    printf("master : before create a thread ... \n");

    ret = pthread_create(&thread, NULL, (pthread_func_t)myfunc, NULL);
    perror("after creating a thread ... :");
   printf("master : after create a thread ... %d(%s)\n", ret, strerror(ret));

   if (ret == EAGAIN) {
      printf("error is EAGAIN\n");
   }
}

--------------E4DC32CC784EC842672D31C4
Content-Type: text/plain; charset=iso-2022-jp;
 name="output"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="output"

execve("./pthread", ["./pthread"], [/* 15 vars */]) = 0
brk(0)                                  = 0x10010fb0
cacheflush(0x7ffffbb8, 0x28, 0x3)       = 0
cacheflush(0x7ffffb40, 0x28, 0x3)       = 0
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 715829248
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or directory)
cacheflush(0x7ffffaa8, 0x28, 0x3)       = 0
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or directory)
open("/lib/libpthread.so.0", O_RDONLY)  = 3
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 715833344
munmap(0x2aaac000, 4096)                = 0
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 715833344
mprotect(0x2aab7000, 281200, PROT_NONE) = 0
mmap(NULL, 0, PROT_NONE, MAP_FILE, 0, 0) = 0x2aaf6000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 716161024
munmap(0x2aafc000, 4096)                = 0
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 716161024
mprotect(0x2abb3000, 330496, PROT_NONE) = 0
mmap(0x18f, 0, 0x8f380000, MAP_SHARED|MAP_FIXED|MAP_RENAME|0x180, 0, 0x8f380000) = 0x2abf2000
mmap(0x8f364045, 87, PROT_NONE, MAP_FILE|0x8f380000, 121, 0ptrace: umoven: Input/output error
) = 717201408
close(3)                                = 0
mprotect(0x2aafc000, 749568, PROT_READ|PROT_WRITE) = 0
mprotect(0x2aafc000, 749568, PROT_READ|PROT_EXEC) = 0
mprotect(0x2aaac000, 45056, PROT_READ|PROT_WRITE) = 0
mprotect(0x2aaac000, 45056, PROT_READ|PROT_EXEC) = 0
personality(PER_LINUX)                  = 0
getpid()                                = 92
getpid()                                = 92
sigaction(SIGUSR1, {0x10000000, [TRAP EMT BUS SEGV SYS ALRM USR2 CHLD WINCH IO TSTP TTIN VTALRM XCPU], 0}, NULL, 0x5c) = 0
sigaction(SIGUSR2, {SIG_DFL}, NULL, 0x5c) = 0
sigprocmask(SIG_BLOCK, [USR1], NULL)    = 0
fstat(1, {st_mode=S_IFCHR|0620, st_rdev=makedev(3, 0), ...}) = 0
mmap(ptrace: umoven: Input/output error
ptrace: umoven: Input/output error
)                                  = 717242368
ioctl(1, TCGETS, {B9600 opost isig icanon echo ...}) = 0
write(1, "master : before create a thread "..., 37master : before create a thread ... 
) = 37
brk(0)                                  = 0x10010fb0
brk(0x10012fa8)                         = 0x10012fa8
brk(0x10013000)                         = 0x10013000
pipe([717225552, 0])                    = 3
clone(child_stack=0x10012f78, flags=CLONE_VM|CLONE_FS|CLONE_FILES|CLONE_SIGHAND) = 93
sigprocmask(SIG_SETMASK, NULL, [USR1])  = 0
write(4, "\0\220\257*\0\0\0\0\0\0\0\0\220\v@\0\0\0\0\0\0\200\0\0"..., 148) = 148
sigprocmask(SIG_SETMASK, NULL, [USR1])  = 0
sigsuspend(~[HUP INT QUIT ILL EMT FPE BUS] <unfinished ...>
--- SIGUSR1 (User defined signal 1) ---
<... sigsuspend resumed> )              = -1 EINTR (Interrupted system call)
sigreturn()                             = ? (mask now [TRAP FPE BUS SEGV SYS ALRM TERM CHLD PWR PROF])
--- SIGBUS (Bus error) ---
+++ killed by SIGBUS +++
sh-2.03# slave : myfunc runs.


--------------E4DC32CC784EC842672D31C4--
