Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA2E6d008614
	for linux-mips-outgoing; Fri, 2 Nov 2001 06:06:39 -0800
Received: from mx.mips.com (mx.mips.com [206.31.31.226])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA2E6Z008610
	for <linux-mips@oss.sgi.com>; Fri, 2 Nov 2001 06:06:35 -0800
Received: from newman.mips.com (ns-dmz [206.31.31.225])
	by mx.mips.com (8.9.3/8.9.0) with ESMTP id GAA06704;
	Fri, 2 Nov 2001 06:06:15 -0800 (PST)
Received: from copfs01.mips.com (copfs01 [192.168.205.101])
	by newman.mips.com (8.9.3/8.9.0) with ESMTP id GAA02594;
	Fri, 2 Nov 2001 06:06:13 -0800 (PST)
Received: from mips.com (copsun14 [192.168.205.24])
	by copfs01.mips.com (8.11.4/8.9.0) with ESMTP id fA2E6Ba13695;
	Fri, 2 Nov 2001 15:06:11 +0100 (MET)
Message-ID: <3BE2A852.AFF0D905@mips.com>
Date: Fri, 02 Nov 2001 15:06:10 +0100
From: Dan Temple <dant@mips.com>
X-Mailer: Mozilla 4.75 [en] (X11; U; SunOS 5.7 sun4u)
X-Accept-Language: en
MIME-Version: 1.0
To: Marc Karasek <marc_karasek@ivivity.com>
CC: Linux MIPS <linux-mips@oss.sgi.com>
Subject: Re: BE Toolchain
References: <1004708261.31067.6.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Marc Karasek wrote:
> 
> Has anyone got the toolchain (binutils, gcc, glibc) to compile under
> BE?  I followed the instructions at Bradley D. LaRonde has put together
> and got the LE to work w/o a prolem.  I then proceeded to try the BE.
> Binutils compiled ok, gcc says that mipseb-linux is not a valid target.
> Looking in config.sub I saw a mips-linux, is this the BE option?

If you can wait a day, here's what we use - which is compilable both BE and LE:

We are going to release a complete RH7.1/MIPS installation image for the Atlas/Malta board on our FTP site, identical to what we use in MIPS engineering.All of our compiles for Linux/MIPS (except the kernel, which is probably irrelevant here) are done natively on Malta boards running Linux. We are using the compiler from the RedHat 7.1/MIPS Linux distribution. 

The toolchains on this distribution are (all commands run natively on
the installation on a Malta board):

> uname -a
Linux copmld07.mips.com 2.4.3-MIPS-01.02

> gcc -v
Reading specs from /usr/lib/gcc-lib/mipsel-redhat-linux/2.96/specs
gcc version 2.96 20000731 (Red Hat Linux 7.1 2.96-99.1)

> rpm -qf /usr/bin/ld
binutils-2.11.92.0.10-1

> rpm -qa | grep glibc
glibc-2.2.4-19.4
glibc-common-2.2.4-19.4
glibc-devel-2.2.4-19.4
glibc-profile-2.2.4-19.4
 
  Dan Temple
  MIPS Denmark
