Received:  by oss.sgi.com id <S554171AbRBYJjS>;
	Sun, 25 Feb 2001 01:39:18 -0800
Received: from [194.90.113.98] ([194.90.113.98]:10244 "EHLO
        yes.home.krftech.com") by oss.sgi.com with ESMTP id <S554168AbRBYJjE>;
	Sun, 25 Feb 2001 01:39:04 -0800
Received: from jungo.com (michaels@kobie.home.krftech.com [199.204.71.69])
	by yes.home.krftech.com (8.8.7/8.8.7) with ESMTP id MAA13516;
	Sun, 25 Feb 2001 12:43:48 +0200
From:   michaels@jungo.com
Message-ID: <3A98D268.90A2D50B@jungo.com>
Date:   Sun, 25 Feb 2001 11:37:44 +0200
Organization: Jungo LTD
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.2.17-21mdk i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Wichert Akkerman <wichert@cistron.nl>
CC:     Ralf Baechle <ralf@oss.sgi.com>,
        "'linux-mips@oss.sgi.com'" <linux-mips@oss.sgi.com>,
        linux-mips <linux-mips@fnet.fr>
Subject: Re: strace package
References: <20010116134453.B12858@bacchus.dhis.org> <Pine.GSO.3.96.1010116171558.5546M-100000@delta.ds2.pg.gda.pl> <20010219133346.A17354@cistron.nl> <20010220213703.B2086@bacchus.dhis.org> <20010224134121.A4925@cistron.nl>
Content-Type: text/plain; charset=koi8-r
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Wichert Akkerman wrote:
> 
> Previously Ralf Baechle wrote:
> > Conincidentally I today built strace-cvs for MIPS before receiving your
> > message and found it to be working just fine.
> 
> Good!
> 

I wonder whether it is my sillines, or something is wrong with strace or
my mips tools. Checked out clean version from
cvs.strace.sourceforge.net:/cvsroot/strace, run configure "NATIVELY" on
mips32 system and got a whole bunch of errors on strace.c :

gcc -Wall -DHAVE_CONFIG_H   -I. -Ilinux/mips -I./linux/mips -Ilinux
-I./linux -D_GNU_SOURCE  -c syscall.c
syscall.c: In function `sys_sysmips':
syscall.c:103: parameter `sysent0' is initialized
syscall.c:106: parameter `nsyscalls0' is initialized
syscall.c:132: parameter `errnoent0' is initialized
In file included from syscall.c:133:
linux/mips/errnoent.h:1: warning: initialization from incompatible
pointer type linux/mips/errnoent.h:2: warning: excess elements in scalar
initializer after `errnoent0'
linux/mips/errnoent.h:3: warning: excess elements in scalar initializer
after `errnoent0'
linux/mips/errnoent.h:4: warning: excess elements in scalar initializer
after `errnoent0'
linux/mips/errnoent.h:5: warning: excess elements in scalar initializer
after `errnoent0'
linux/mips/errnoent.h:6: warning: excess elements in scalar initializer
after `errnoent0'
... < aroud 1000 errors like these >
syscall.c:135: parameter `nerrnos0' is initialized
syscall.c:158: warning: parameter names (without types) in function
declaration
syscall.c:158: parse error before `int'
syscall.c:158: declaration for parameter `set_personality' but no such
parameter
syscall.c:154: declaration for parameter `current_personality' but no
such parameter
syscall.c:152: declaration for parameter `nerrnos' but no such parameter
syscall.c:151: declaration for parameter `errnoent' but no such
parameter
syscall.c:135: declaration for parameter `nerrnos0' but no such
parameter
syscall.c:132: declaration for parameter `errnoent0' but no such
parameter
syscall.c:123: declaration for parameter `nsyscalls' but no such
parameter
syscall.c:122: declaration for parameter `sysent' but no such parameter
syscall.c:106: declaration for parameter `nsyscalls0' but no such
parameter
syscall.c:103: declaration for parameter `sysent0' but no such parameter
linux/syscall.h:183: declaration for parameter `sys_capset' but no such
parameter
linux/syscall.h:183: declaration for parameter `sys_capget' but no such
parameter
linux/syscall.h:182: declaration for parameter `sys_utimes' but no such
parameter
linux/syscall.h:182: declaration for parameter `sys_getdtablesize' but
no such parameter
linux/syscall.h:182: declaration for parameter `sys_gethostname' but no
such parameter
linux/syscall.h:182: declaration for parameter `sys_setpgrp' but no such
parameter
syscall.c:160: `personality' undeclared (first use this function)
syscall.c:160: (Each undeclared identifier is reported only once
syscall.c:160: for each function it appears in.)

Here's the info:
[michaels@verdi strace]$ gcc --version
egcs-2.90.27 980315 (egcs-1.0.2
release)                                        
[michaels@verdi strace]$ rpm -q glibc
glibc-2.0.6-4                                                                   
[michaels@verdi strace]$ uname -a
Linux verdi.home.krftech.com 2.2.12-MIPS-01.05 #1 Thu Sep 7 11:36:42
CEST 2000 mips unknown 
[michaels@verdi strace]$ cat /proc/cpuinfo
cpu                     : MIPS
cpu model               : MIPS 5Kc V0.1
system type             : unknown unknown
BogoMIPS                : 39.94
byteorder               : big endian
unaligned accesses      : 0
wait instruction        : no
microsecond timers      : no
extra interrupt vector  : yes
hardware watchpoint     : yes
VCED exceptions         : not available
VCEI exceptions         : not
available                                         

Exactly same code compiles on i386 silently and clean.
Audience, please, what seems to be my problem?

Sincerely yours,
Michael Shmulevich
______________________________________
Software Developer
Jungo - R&D 
email: michaels@jungo.com
web: http://www.jungo.com
Phone: 1-877-514-0537(USA)  +972-9-8859365(Worldwide) ext. 233
Fax:   1-877-514-0538(USA)  +972-9-8859366(Worldwide)
