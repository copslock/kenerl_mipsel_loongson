Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Oct 2011 23:29:29 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11599 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903606Ab1J0V3Z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Oct 2011 23:29:25 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ea9cd840000>; Thu, 27 Oct 2011 14:30:44 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 14:29:20 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 27 Oct 2011 14:29:19 -0700
Message-ID: <4EA9CD2F.8040408@cavium.com>
Date:   Thu, 27 Oct 2011 14:29:19 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Bruno Haible <bruno@clisp.org>
CC:     David Daney <david.daney@cavium.com>,
        "bug-gnulib@gnu.org" <bug-gnulib@gnu.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: bug in fchownat in n32 and 64 ABIs
References: <201110272107.38510.bruno@clisp.org> <4EA9B072.5000107@cavium.com>
In-Reply-To: <4EA9B072.5000107@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Oct 2011 21:29:19.0988 (UTC) FILETIME=[7CDD6340:01CC94EF]
X-archive-position: 31315
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19983

On 10/27/2011 12:26 PM, David Daney wrote:
> On 10/27/2011 12:07 PM, Bruno Haible wrote:
>> Hi Linux/MIPS folks,
>>
>> Found this bug by running the gnulib POSIX test suite: In the fchownat()
>> call, an uid_t or gid_t of value (uid_t)-1 or (gid_t)-1 means no change.
>> See<http://pubs.opengroup.org/onlinepubs/9699919799/functions/fchownat.html>.
>> This value is correctly recognized on all Unices, _except_ Linux/MIPS
>> in n32 and 64 ABIs.
>>
> [...]
>> $ gcc -Wall -mabi=64 foo.c
>> $ ./a.out ; echo $?
>> fchownat: Operation not permitted
>> fchownat: Operation not permitted
>> fchownat: Operation not permitted
>> 14
>> $ gcc -Wall -mabi=n32 foo.c
>> $ ./a.out ; echo $?
>> fchownat: Operation not permitted
>> fchownat: Operation not permitted
>> fchownat: Operation not permitted
>> 14
>> $ gcc -Wall -mabi=32 foo.c
>> $ ./a.out ; echo $?
>>
>> Other relevant data:
>> - kernel version is 2.6.27.1
>> - glibc version is 2.7
>> - gcc version is 4.3.2 (Debian).
>
> Debian doesn't support 64-bit ABIs, so this list is incomplete.  Where
> did you get your 64-bit libc ?
>
>>
>> 'strace' of this program shows that the system call that returns with -1/EPERM
>> is a call to SYS_6254 (in n32 ABI) or SYS_5250 (in 64 ABI).
>>
> Can you get strace -- version 4.5.20 or later and build it for the
> corresponding ABI?  That should properly decode the relevant syscalls.
>
> Once you have that, you might post the strace output.
>
> In the mean time I might give it a try with my 2.9 glibc on a 2.6.32.27
> kernels.
>

n64 seems to work for me.  Witness:

# strace ./fchownat-test
execve("./fchownat-test", ["./fchownat-test"], [/* 6 vars */]) = 0
brk(0)                                  = 0x12a14b000
uname({sys="Linux", node="(none)", ...}) = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x5558e31000
access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or 
directory)
open("/etc/ld.so.cache", O_RDONLY)      = -1 ENOENT (No such file or 
directory)
open("/lib64/tls/octeon/libc.so.6", O_RDONLY) = -1 ENOENT (No such file 
or directory)
stat("/lib64/tls/octeon", 0xffffc9db70) = -1 ENOENT (No such file or 
directory)
open("/lib64/tls/libc.so.6", O_RDONLY)  = -1 ENOENT (No such file or 
directory)
stat("/lib64/tls", 0xffffc9db70)        = -1 ENOENT (No such file or 
directory)
open("/lib64/octeon/libc.so.6", O_RDONLY) = -1 ENOENT (No such file or 
directory)
stat("/lib64/octeon", 0xffffc9db70)     = -1 ENOENT (No such file or 
directory)
open("/lib64/libc.so.6", O_RDONLY)      = 3
read(3, 
"\177ELF\2\2\1\0\0\0\0\0\0\0\0\0\0\3\0\10\0\0\0\1\0\0\0\0\0\3Wx"..., 
832) = 832
lseek(3, 59248, SEEK_SET)               = 59248
read(3, 
"\0\0\0\4\0\0\0\20\0\0\0\1GNU\0\0\0\0\0\0\0\0\2\0\0\0\6\0\0\0\n", 32) = 32
fstat(3, {st_mode=S_IFREG|0555, st_size=1680968, ...}) = 0
mmap(NULL, 1604224, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 
0) = 0x5558e43000
mprotect(0x5558fa7000, 61440, PROT_NONE) = 0
mmap(0x5558fb6000, 69632, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x163000) = 0x5558fb6000
mmap(0x5558fc7000, 14976, PROT_READ|PROT_WRITE, 
MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x5558fc7000
close(3)                                = 0
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x5558e32000
mmap(NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) 
= 0x5558e33000
set_thread_area(0x5558e39b00)           = 0
mprotect(0x5558fb6000, 53248, PROT_READ) = 0
mprotect(0x5558e40000, 4096, PROT_READ) = 0
stat("foo.c", {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
fchownat(AT_FDCWD, "foo.c", 4294967295, 0, 0) = 0
fchownat(AT_FDCWD, "foo.c", 55, 4294967295, 0) = 0
fchownat(AT_FDCWD, "foo.c", 4294967295, 4294967295, 0) = 0
exit_group(0)                           = ?
