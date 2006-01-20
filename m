Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jan 2006 21:48:20 +0000 (GMT)
Received: from fw-ca-1-hme0.vitesse.com ([64.215.88.90]:44483 "EHLO
	email.vitesse.com") by ftp.linux-mips.org with ESMTP
	id S3950893AbWATVry (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 20 Jan 2006 21:47:54 +0000
Received: from wilson.vitesse.com (wilson [192.9.212.7])
	by email.vitesse.com (8.11.0/8.11.0) with ESMTP id k0KLpjh22559
	for <linux-mips@linux-mips.org>; Fri, 20 Jan 2006 13:51:45 -0800 (PST)
Received: from MX-COS.vsc.vitesse.com (mx-cs1 [192.9.212.67])
	by wilson.vitesse.com (8.11.6/8.11.6) with ESMTP id k0KLpiX11470
	for <linux-mips@linux-mips.org>; Fri, 20 Jan 2006 14:51:44 -0700 (MST)
Received: MX-COS 192.9.212.98 from 192.9.211.152 192.9.211.152 via HTTP with MS-WebStorage 6.0.6249
Received: from lx-kurts.vitesse.com by MX-COS; 20 Jan 2006 14:51:06 -0700
Subject: Build errors
From:	Kurt Schwemmer <kurts@vitesse.com>
To:	linux-mips@linux-mips.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date:	Fri, 20 Jan 2006 14:51:05 -0700
Message-Id: <1137793865.15788.26.camel@lx-kurts>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Return-Path: <kurts@vitesse.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kurts@vitesse.com
Precedence: bulk
X-list: linux-mips

Disclaimer: This is my first attempt to recompile the linux-mips kernel
so these are probably just newbie problems.

I sync'd with git clone rsync://ftp.linux-mips.org/git/linux.git
linux.git 2 days ago. I downloaded and installed sde:
ftp://ftp.mips.com/pub/tools/software/sde-for-linux/6.02.03-1/mipsel-sdelinux-v6.02.03-1.i386.rpm

I'm building for a Malta eval board. I'm trying to compile in oprofile
support. I execute the following sequence:
1. Copy the default malta config file to .config
2. run make xconfig and add oprofile support
3. make clean
4. make vmlinux.srec

I get a few warnings:

kernel/pid.c: In function `pidhash_init':
kernel/pid.c:260: warning: comparison of distinct pointer types lacks a
cast
  CC      kernel/rcupdate.o
  CC      kernel/intermodule.o
kernel/intermodule.c:178: warning: `inter_module_register' is deprecated
(declared at kernel/intermodule.c:38)
kernel/intermodule.c:179: warning: `inter_module_unregister' is
deprecated (declared at kernel/intermodule.c:78)
kernel/intermodule.c:181: warning: `inter_module_put' is deprecated
(declared at kernel/intermodule.c:159)

...but the one that kills me is:
mm/msync.o: In function `msync_interval':
msync.c:(.text+0x10c): unmatched HI16 relocation
mipsel-linux-ld: final link failed: Bad value
make[1]: *** [mm/built-in.o] Error 1
make: *** [mm] Error 2

Would someone tell me what I'm doing wrong? I'm pretty sure people
wouldn't be checking in code that doesn't even build!

Thanks,
Kurt Schwemmer
