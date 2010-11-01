Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Nov 2010 19:25:16 +0100 (CET)
Received: from tvwna-ip-c-172.princeton.org ([66.180.187.89]:37897 "EHLO
        localhost.m.enhanced.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491207Ab0KASZM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Nov 2010 19:25:12 +0100
Received: from camm by localhost.m.enhanced.com with local (Exim 4.69)
        (envelope-from <camm@maguirefamily.org>)
        id 1PCz3r-0003eM-Dz; Mon, 01 Nov 2010 14:24:51 -0400
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        debian-mips@lists.debian.org, gcl-devel@gnu.org,
        Andreas Barth <aba@not.so.argh.org>,
        linux-mips <linux-mips@linux-mips.org>
Subject: Re: mips and ADDR_NO_RANDOMIZE
References: <E1OwbkA-0006gv-Bi@localhost.m.enhanced.com>
        <8762y49k1k.fsf@maguirefamily.org>
        <4C93D86D.5090201@caviumnetworks.com>
        <87fwx4dwu5.fsf@maguirefamily.org>
        <4C97D9A1.7050102@caviumnetworks.com>
        <87lj6te9t1.fsf@maguirefamily.org>
        <4C9A8BC9.1020605@caviumnetworks.com>
        <4C9A9699.6080908@caviumnetworks.com>
        <87pqvbs7oa.fsf@maguirefamily.org>
        <4CB88D2C.8020900@caviumnetworks.com>
        <87r5fksxby.fsf_-_@maguirefamily.org>
        <4CBF1B1E.6050804@caviumnetworks.com>
        <8762wwlfen.fsf@maguirefamily.org>
        <4CC06826.2070508@caviumnetworks.com>
        <4CC0787C.2040902@caviumnetworks.com>
        <878w1m3qmn.fsf_-_@maguirefamily.org>
        <4CC5FA72.6080005@caviumnetworks.com>
        <alpine.LFD.2.00.1010261323080.15889@eddie.linux-mips.org>
        <4CC70DA9.6000906@caviumnetworks.com>
        <87bp69811z.fsf_-_@maguirefamily.org>
        <4CCF0197.2030407@caviumnetworks.com>
From:   Camm Maguire <camm@maguirefamily.org>
Date:   Mon, 01 Nov 2010 14:24:51 -0400
In-Reply-To: <4CCF0197.2030407@caviumnetworks.com> (David Daney's message of "Mon\, 01 Nov 2010 11\:06\:15 -0700")
Message-ID: <87bp68x5os.fsf@maguirefamily.org>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <camm@maguirefamily.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28287
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: camm@maguirefamily.org
Precedence: bulk
X-list: linux-mips

Greetings!

David Daney <ddaney@caviumnetworks.com> writes:

> On 11/01/2010 09:24 AM, Camm Maguire wrote:
>> Greetings! Executing personality() with the ADDR_NO_RANDOMIZE bit set,
>> and re-executing via execve, should yield a process with traditional
>> contiguous brk() addresses appended to the .data segment, independent
>> of the setting of sysctl kernel.randomize_va_space, right?  At least
>> this is the way the linux kernel has been working on x86 for many
>> years.
>>
>> The latest Debian mips kernel is not honoring this setting.  I'd like
>> to know if this is a kernel bug.
>>
>
> For things like this, we need to know what kind of kernel it is.  Is
> it a 64-bit kernel running a 32-bit application?
>

The kernel is Debian 2.6.36-rc6-loongson-2f.  Does this suffice?

> I am going to guess that it is.
>
> The 32-bit sys_personality wrapper in the kernel looks incorrect.  But
> It should probably still work, to set ADDR_NO_RANDOMIZE, so I don't
> really know where it is going off track yet.
>
> Having implemented the randomization, I would like to see it work
> correctly, so I guess I will look at it.
>

Thanks so much!

> You seem to have a certain knack for uncovering obscure bugs.
>

:-)

Take care,

> David Daney
>
>> =============================================================================
>> h/unrandomize.h
>> =============================================================================
>> #include<sys/personality.h>
>> #include<syscall.h>
>> #include<unistd.h>
>> #include<alloca.h>
>> #include<errno.h>
>>
>>
>> {
>>    errno=0;
>>
>>    {
>>
>>      long pers = personality(0xffffffffUL);
>>      if (pers==-1) {printf("personality failure %d\n",errno);exit(-1);}
>>      if (!(pers&  ADDR_NO_RANDOMIZE)&&  !getenv("GCL_UNRANDOMIZE")) {
>>        errno=0;
>>        if (personality(pers | ADDR_NO_RANDOMIZE) != -1&&  personality(0xffffffffUL)&  ADDR_NO_RANDOMIZE) {
>> 	int i;
>> 	char **n;
>> 	for (i=0;envp[i];i++);
>> 	n=alloca((i+2)*sizeof(*n));
>> 	n[i+1]=0;
>> 	n[i--]="GCL_UNRANDOMIZE=t";
>> 	for (;i>=0;i--)
>> 	  n[i]=envp[i];
>> #ifdef GCL_GPROF
>> 	gprof_cleanup();
>> #endif
>> 	errno=0;
>> 	execve(*argv,argv,n);
>> 	printf("execve failure %d\n",errno);
>> 	exit(-1);
>>        } else {
>> 	printf("personality change failure %d\n",errno);
>> 	exit(-1);
>>        }
>>      }
>>    }
>> }
>> =============================================================================
>> f.c
>> =============================================================================
>> #include<stdio.h>
>>                      void gprof_cleanup() {};
>> 		    int main(int argc,char * argv[],char * envp[]) {
>> 			FILE *f;
>>
>> 			#include "h/unrandomize.h"
>>
>> 			if (!(f=fopen("conftest1","w"))) return -1;
>> 			fprintf(f,"%u",sbrk(0));
>> 			return 0;}
>> =============================================================================
>> ./f&&  cat conftest1&&  echo&&  ./f&&  cat conftest1
>> 10043392
>> 10584064
>> =============================================================================
>> strace -f ./f
>> =============================================================================
>> execve("./f", ["./f"], [/* 16 vars */]) = 0
>> brk(0)                                  = 0x7a4000
>> old_mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2b938000
>> uname({sys="Linux", node="phrixos", ...}) = 0
>> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
>> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
>> open("/etc/ld.so.cache", O_RDONLY)      = 3
>> fstat64(3, {st_mode=S_IFREG|0644, st_size=16547, ...}) = 0
>> old_mmap(NULL, 16547, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2b93c000
>> close(3)                                = 0
>> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
>> open("/lib/libc.so.6", O_RDONLY)        = 3
>> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\24s\1\0004\0\0\0"..., 512) = 512
>> lseek(3, 760, SEEK_SET)                 = 760
>> read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0\22\0\0\0", 32) = 32
>> fstat64(3, {st_mode=S_IFREG|0755, st_size=1594664, ...}) = 0
>> old_mmap(NULL, 1576560, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2b948000
>> mprotect(0x2baac000, 49152, PROT_NONE)  = 0
>> old_mmap(0x2bab8000, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x160000) = 0x2bab8000
>> old_mmap(0x2bac8000, 3696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2bac8000
>> close(3)                                = 0
>> set_thread_area(0x2b940ad0)             = 0
>> mprotect(0x2bab8000, 49152, PROT_READ)  = 0
>> munmap(0x2b93c000, 16547)               = 0
>> personality(0xffffffff /* PER_??? */)   = 0
>> personality(0x40000 /* PER_??? */)      = 0
>> personality(0xffffffff /* PER_??? */)   = 262144
>> execve("./f", ["./f"], [/* 17 vars */]) = 0
>> brk(0)                                  = 0x670000
>> old_mmap(NULL, 16384, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2ba70000
>> uname({sys="Linux", node="phrixos", ...}) = 0
>> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
>> access("/etc/ld.so.preload", R_OK)      = -1 ENOENT (No such file or directory)
>> open("/etc/ld.so.cache", O_RDONLY)      = 3
>> fstat64(3, {st_mode=S_IFREG|0644, st_size=16547, ...}) = 0
>> old_mmap(NULL, 16547, PROT_READ, MAP_PRIVATE, 3, 0) = 0x2ba74000
>> close(3)                                = 0
>> access("/etc/ld.so.nohwcap", F_OK)      = -1 ENOENT (No such file or directory)
>> open("/lib/libc.so.6", O_RDONLY)        = 3
>> read(3, "\177ELF\1\1\1\0\0\0\0\0\0\0\0\0\3\0\10\0\1\0\0\0\24s\1\0004\0\0\0"..., 512) = 512
>> lseek(3, 760, SEEK_SET)                 = 760
>> read(3, "\4\0\0\0\20\0\0\0\1\0\0\0GNU\0\0\0\0\0\2\0\0\0\6\0\0\0\22\0\0\0", 32) = 32
>> fstat64(3, {st_mode=S_IFREG|0755, st_size=1594664, ...}) = 0
>> old_mmap(NULL, 1576560, PROT_READ|PROT_EXEC, MAP_PRIVATE|MAP_DENYWRITE, 3, 0) = 0x2ba80000
>> mprotect(0x2bbe4000, 49152, PROT_NONE)  = 0
>> old_mmap(0x2bbf0000, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_DENYWRITE, 3, 0x160000) = 0x2bbf0000
>> old_mmap(0x2bc00000, 3696, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_FIXED|MAP_ANONYMOUS, -1, 0) = 0x2bc00000
>> close(3)                                = 0
>> set_thread_area(0x2ba78ad0)             = 0
>> mprotect(0x2bbf0000, 49152, PROT_READ)  = 0
>> munmap(0x2ba74000, 16547)               = 0
>> personality(0xffffffff /* PER_??? */)   = 0
>> brk(0)                                  = 0x670000
>> brk(0x694000)                           = 0x694000
>> open("conftest1", O_WRONLY|O_CREAT|O_TRUNC, 0666) = 3
>> fstat64(3, {st_mode=S_IFREG|0644, st_size=0, ...}) = 0
>> old_mmap(NULL, 65536, PROT_READ|PROT_WRITE, MAP_PRIVATE|MAP_ANONYMOUS, -1, 0) = 0x2bc04000
>> write(3, "6897664", 7)                  = 7
>> exit_group(0)                           = ?
>> =============================================================================
>> uname -a
>> =============================================================================
>> Linux phrixos 2.6.36-rc6-loongson-2f #1 Mon Oct 4 20:36:22 UTC 2010
>> 			mips64 GNU/Linux
>> =============================================================================
>> /proc/cpuinfo
>> =============================================================================
>> system type		: lemote-fuloong-2f-box
>> processor		: 0
>> cpu model		: ICT Loongson-2 V0.3  FPU V0.1
>> BogoMIPS		: 528.38
>> wait instruction	: yes
>> microsecond timers	: yes
>> tlb_entries		: 64
>> extra interrupt vector	: no
>> hardware watchpoint	: yes, count: 0, address/irw mask: []
>> ASEs implemented	:
>> shadow register sets	: 1
>> core			: 0
>> VCED exceptions		: not available
>> VCEI exceptions		: not available
>> =============================================================================
>>
>> Take care,
>
>
>
>
>

-- 
Camm Maguire			     		    camm@maguirefamily.org
==========================================================================
"The earth is but one country, and mankind its citizens."  --  Baha'u'llah
