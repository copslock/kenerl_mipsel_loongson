Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f2T7uUx26867
	for linux-mips-outgoing; Wed, 28 Mar 2001 23:56:30 -0800
Received: from surfers.oz.agile.tv (agile-50.OntheNet.com.au [203.144.13.50])
	by oss.sgi.com (8.11.3/8.11.3) with ESMTP id f2T7uOM26864
	for <linux-mips@oss.sgi.com>; Wed, 28 Mar 2001 23:56:25 -0800
Received: from agile.tv (IDENT:ldavies@tugun.oz.agile.tv [192.168.16.20])
	by surfers.oz.agile.tv (8.11.0/8.11.0) with ESMTP id f2T7uOo21807;
	Thu, 29 Mar 2001 17:56:24 +1000
Message-ID: <3AC2EAA7.C6089289@agile.tv>
Date: Thu, 29 Mar 2001 17:56:23 +1000
From: Liam Davies <ldavies@agile.tv>
Reply-To: ldavies@oz.agile.tv
Organization: Agile TV
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.16-22 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-mips@oss.sgi.com
Subject: PThread troubles with glibc-2.2.2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I am having troubles with the pthread libs. I currently have installed
(from Maciej's site)
glibc-2.2.2-2
glibc-devel-2.2.2-2
gcc-2.95.3-14
binutils-2.10.1-3
kernel 2.4.0

When compiled with -lpthread the program just loops around doing
sysmips(ATOMIC_SET...)
and sched_yield. It doesn't do it if I have no -l or use some other lib
such as -lm -lz. Static/
dynamic doesn't make any difference.

Any help appreciated.. straces are attached

Thanks
Liam


-------------------

#include <stdio.h>

int
main (void)
{
        int i;

        for(i=0;i< 10; i++){
                printf("%d ", i);
        }

  return 0;
}

------------
gcc -g -Wall -D_REENTRANT -o ex1 ex1.c -lpthread

execve("./ex1", ["./ex1"], [/* 21 vars */]) = 0
uname({sys="Linux", node="node4.oz.agile.tv", ...}) = 0
brk(0)                                  = 0x100000a0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaab000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11630, ...}) = 0
mmap(NULL, 11630, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aaac000
close(3)                                = 0
open("/lib/libpthread.so.0", O_RDONLY)  = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0pD\376"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=120080, ...}) = 0
mmap(NULL, 367264, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2aaaf000
mprotect(0x2aac2000, 289440, PROT_NONE) = 0
mmap(0x2ab01000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x12000) = 0x2ab01000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\244X\377"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1647420, ...}) = 0
mmap(NULL, 1719184, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2ab09000

mprotect(0x2ac62000, 306064, PROT_NONE) = 0
mmap(0x2aca1000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x158000) = 0x2aca1000
mmap(0x2aca9000, 15248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2aca9000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\244X\377"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1647420, ...}) = 0
close(3)                                = 0
mprotect(0x2ab09000, 1413120, PROT_READ|PROT_WRITE) = 0
mprotect(0x2ab09000, 1413120, PROT_READ|PROT_EXEC) = 0
mprotect(0x2aaaf000, 77824, PROT_READ|PROT_WRITE) = 0
mprotect(0x2aaaf000, 77824, PROT_READ|PROT_EXEC) = 0
munmap(0x2aaac000, 11630)               = 0
sysmips(0x7d1, 0x2aca5e38, 0x1, 0)      = 4149
sched_yield(0x7ffffbf0, 0, 0x1, 0, 0x2ab10450) = 0
sysmips(0x7d1, 0x2aca5e38, 0x1, 0)      = 4149
sched_yield(0x7ffffbf0, 0, 0x1, 0, 0x2ab10450) = 0
sysmips(0x7d1, 0x2aca5e38, 0x1, 0)      = 4149
sched_yield(0x7ffffbf0, 0, 0x1, 0, 0x2ab10450) = 0
sysmips(0x7d1, 0x2aca5e38, 0x1, 0)      = 4149
sched_yield(0x7ffffbf0, 0, 0x1, 0, 0x2ab10450) = 0
sysmips(0x7d1, 0x2aca5e38, 0x1, 0)      = 4149
sched_yield(0x7ffffbf0, 0, 0x1, 0, 0x2ab10450) = 0
...

-----------------

gcc -g -Wall  -D_REENTRANT -o ex1 ex1.c

execve("./ex1", ["./ex1"], [/* 22 vars */]) = 0
uname({sys="Linux", node="node4.oz.agile.tv", ...}) = 0
brk(0)                                  = 0x100000a0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaab000
open("/etc/ld.so.preload", O_RDONLY)    = -1 ENOENT (No such file or
directory)
open("/etc/ld.so.cache", O_RDONLY)      = 3
fstat64(3, {st_mode=S_IFREG|0644, st_size=11630, ...}) = 0
mmap(NULL, 11630, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2aaac000
close(3)                                = 0
open("/lib/libc.so.6", O_RDONLY)        = 3
read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\244X\377"...,
1024) = 1024
fstat64(3, {st_mode=S_IFREG|0755, st_size=1647420, ...}) = 0
mmap(NULL, 1719184, PROT_READ|PROT_EXEC, MAP_PRIVATE, 3, 0) = 0x2aaaf000

mprotect(0x2ac08000, 306064, PROT_NONE) = 0
mmap(0x2ac47000, 32768, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED, 3,
0x158000) = 0x2ac47000
mmap(0x2ac4f000, 15248, PROT_READ|PROT_WRITE,
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2ac4f000
close(3)                                = 0
mprotect(0x2aaaf000, 1413120, PROT_READ|PROT_WRITE) = 0
mprotect(0x2aaaf000, 1413120, PROT_READ|PROT_EXEC) = 0
munmap(0x2aaac000, 11630)               = 0
getpid()                                = 17640
fstat64(1, {st_mode=S_IFREG|0644, st_size=1296, ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0)
= 0x2aaac000
write(1, "0 1 2 3 4 5 6 7 8 9 ", 200 1 2 3 4 5 6 7 8 9 )    = 20
munmap(0x2aaac000, 4096)                = 0
exit(0)                                 = ?
