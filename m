Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Oct 2004 10:59:25 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:26833 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8225334AbUJHJ7V>; Fri, 8 Oct 2004 10:59:21 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i989t9GG025068
	for <linux-mips@linux-mips.org>; Fri, 8 Oct 2004 15:25:10 +0530
Message-ID: <416663B2.5010006@procsys.com>
Date: Fri, 08 Oct 2004 15:23:54 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - linker errors
References: <41665DEA.3090307@procsys.com>
In-Reply-To: <41665DEA.3090307@procsys.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5981
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

T. P. Saravanan wrote:

> glibc-2.3.3 build on linux-mips breaks down with following linker error:
>
> sara@eyeore: [over] ~/build/glibc/objdir6$ make
> make -r PARALLELMFLAGS="" CVSOPTS="" -C ../glibc-2.3.3 objdir=`pwd` all
> make[1]: Entering directory `/home/sara/build/glibc/glibc-2.3.3'
> make  -C csu subdir_lib
> .
> .
> .
> make[4]: Nothing to be done for `rtld-all'.
> make[4]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/time'
> make[3]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
> make[2]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3/elf'
> gcc -mabi=32   -nostdlib -nostartfiles -r -o 
> /home/sara/build/glibc/objdir6/libc_pic.os \
> -Wl,-d -Wl,--whole-archive /home/sara/build/glibc/objdir6/libc_pic.a
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x0): In 
> function `*__GI___strtold_internal':
> ../sysdeps/generic/strtold.c:25: multiple definition of 
> `__GI___strtold_internal'
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x0):../sysdeps/generic/strtold.c:25: 
> first defined here
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x0): In 
> function `*__GI___strtold_internal':
> ../sysdeps/generic/strtold.c:25: multiple definition of 
> `__strtold_internal'
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x0):../sysdeps/generic/strtold.c:25: 
> first defined here
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold_l.os)(.text+0x38): 
> In function `strtold':
> ../sysdeps/generic/strtold.c:32: multiple definition of `strtold'
> /home/sara/build/glibc/objdir6/libc_pic.a(strtold.os)(.text+0x38):../sysdeps/generic/strtold.c:32: 
> first defined here
> collect2: ld returned 1 exit status
> make[1]: *** [/home/sara/build/glibc/objdir6/libc_pic.os] Error 1
> make[1]: Leaving directory `/home/sara/build/glibc/glibc-2.3.3'
> make: *** [all] Error 2
>
ar -d lib_pic.a strtold.os

got me be beyond this point. 
(If somebody knows that this is not the way to do it - let me know.)

-Sa.
