Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA2Edjm09420
	for linux-mips-outgoing; Fri, 2 Nov 2001 06:39:45 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA2Ede009417
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 06:39:40 -0800
Received: from mail.ivivity.com (user-vc8ftn3.biz.mindspring.com [216.135.246.227]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA08819
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 06:39:39 -0800 (PST)
	mail_from (marc_karasek@ivivity.com)
Received: from [192.168.1.170] (192.168.1.170 [192.168.1.170]) by mail.ivivity.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2448.0)
	id QMJCNXX8; Fri, 2 Nov 2001 09:17:32 -0500
Subject: Re: BE Toolchain
From: Marc Karasek <marc_karasek@ivivity.com>
To: Dan Temple <dant@mips.com>
Cc: Linux MIPS <linux-mips@oss.sgi.com>
In-Reply-To: <3BE2A852.AFF0D905@mips.com>
References: <1004708261.31067.6.camel@localhost.localdomain> 
	<3BE2A852.AFF0D905@mips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.16.99+cvs.2001.10.18.15.19 (Preview Release)
Date: 02 Nov 2001 09:18:31 -0500
Message-Id: <1004710722.31067.20.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I should have been more specific,  I should have said cross-toolchain. 
x86 -> MIPS.  I will check out the packages you mentioned below, and
will investigate them as an option.  But as of right now, our build
enviroment is still x86 Linux (RH 7.1).  We will be targeting a MIPS
processor of our own, I cannot get into too many details.  We are using
the Malta board right now for some testing/eval work.  But will be
quickly moving to our own platform in the near future.  At that time the
Malta will prob be put aside.  

On Fri, 2001-11-02 at 09:06, Dan Temple wrote:
> Marc Karasek wrote:
> > 
> > Has anyone got the toolchain (binutils, gcc, glibc) to compile under
> > BE?  I followed the instructions at Bradley D. LaRonde has put together
> > and got the LE to work w/o a prolem.  I then proceeded to try the BE.
> > Binutils compiled ok, gcc says that mipseb-linux is not a valid target.
> > Looking in config.sub I saw a mips-linux, is this the BE option?
> 
> If you can wait a day, here's what we use - which is compilable both BE and LE:
> 
> We are going to release a complete RH7.1/MIPS installation image for the Atlas/Malta board on our FTP site, identical to what we use in MIPS engineering.All of our compiles for Linux/MIPS (except the kernel, which is probably irrelevant here) are done natively on Malta boards running Linux. We are using the compiler from the RedHat 7.1/MIPS Linux distribution. 
> 
> The toolchains on this distribution are (all commands run natively on
> the installation on a Malta board):
> 
> > uname -a
> Linux copmld07.mips.com 2.4.3-MIPS-01.02
> 
> > gcc -v
> Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux/2.96/specs
> gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)
> 
> > rpm -qf /usr/bin/ld
> binutils-2.11.92.0.10-1
> 
> > rpm -qa | grep glibc
> glibc-2.2.4-19.4
> glibc-common-2.2.4-19.4
> glibc-devel-2.2.4-19.4
> glibc-profile-2.2.4-19.4
>  
>   Dan Temple
>   MIPS Denmark
-- 
/*************************
Marc Karasek
Sr. Firmware Engineer
iVivity Inc.
marc_karasek@ivivity.com
(770) 986-8925
(770) 986-8926 Fax
*************************/
