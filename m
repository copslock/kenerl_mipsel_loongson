Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Feb 2003 15:31:37 +0000 (GMT)
Received: from web40804.mail.yahoo.com ([IPv6:::ffff:66.218.78.181]:23645 "HELO
	web40804.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225201AbTBKPbg>; Tue, 11 Feb 2003 15:31:36 +0000
Message-ID: <20030211153128.41512.qmail@web40804.mail.yahoo.com>
Received: from [64.157.117.135] by web40804.mail.yahoo.com via HTTP; Tue, 11 Feb 2003 07:31:28 PST
Date: Tue, 11 Feb 2003 07:31:28 -0800 (PST)
From: Jiahan Chen <jiahanchen@yahoo.com>
Subject: Mips Kernel Build
To: linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <jiahanchen@yahoo.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiahanchen@yahoo.com
Precedence: bulk
X-list: linux-mips

Hi,

I'm working on Linux embedded applications with
PC (Intel) workstation as Development Host, and
Mips as Target. Currently, I have the following
questions:

1. What is a easy way to create a new kernel for Mips?
 1) With install.tar.bz2 and baseline.tar.bz2 from Mips ftp site
   download, or
 2) With Red Hat source disk installation on /usr/src/redhat,
   using a command like
   rpm -bc --target MIPS kernel-2.4.18.spec
   (I tried the above command with kernel-2.4.18, 
    and got many complaints about patches => failed.
    For example, 
+ echo 'Patch #280 (linux-2.4.16-mips-20011220.patch):'
Patch #280 (linux-2.4.16-mips-20011220.patch):
+ patch -p1 -s
Reversed (or previously applied) patch detected!  Assume -R? [n] y
1 out of 8 hunks FAILED -- saving rejects to file arch/mips/Makefile.rej
Reversed (or previously applied) patch detected!  Assume -R? [n]
......
out of 8 hunks FAILED -- saving rejects to file arch/mips/Makefile.rej
......

    I'm wondering if Kernel's 2.4.18 source tree distribution
    from RedHat CD is working for Mips Kernel creation. 
    In addition, do we have to do some updates in Spec file 
    to setup cross stuff properly after patch problems fixed? 
   or
 3) Other approach?

2. Do you have a simple procedure (scripts) to setup for
cross-development environment on the PC Host? 

3. How to add an item of new device driver to xconfig? 
Right now, I use the following procedure to create a 
new kernel (local version as practice) with kernel source
linux-2.4.18.tar.gz installation:
 make xconfig
 make dep
 make bzImage

4. Is mipsel-linux-run an emulator on Intel PC for running Mips
executable?
After cross-compiling a few examples on Host to create
executable (a.out), I tried 
  mipsel-linux-run a.out
and got the same error with different a.out as follows:
"mips-core: 4 byte read to unmapped address 0x400ee0 at 0x400ee0
program stopped with signal 7."

Thanks a lot! (Your full or partial answers are welcome!)

Jiahan


__________________________________________________
Do you Yahoo!?
Yahoo! Shopping - Send Flowers for Valentine's Day
http://shopping.yahoo.com
