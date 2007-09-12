Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Sep 2007 17:22:22 +0100 (BST)
Received: from mail.gmx.net ([213.165.64.20]:52913 "HELO mail.gmx.net")
	by ftp.linux-mips.org with SMTP id S20023495AbXILQWO (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 12 Sep 2007 17:22:14 +0100
Received: (qmail invoked by alias); 12 Sep 2007 16:21:08 -0000
Received: from p548B0E3D.dip0.t-ipconnect.de (EHLO [192.168.120.22]) [84.139.14.61]
  by mail.gmx.net (mp028) with SMTP; 12 Sep 2007 18:21:08 +0200
X-Authenticated: #16080105
X-Provags-ID: V01U2FsdGVkX19sAgFQYwls+jnRJAYTqnPQi+8xT9TWJlXnW4ipk2
	aYeR5RC6yxvu3O
Message-ID: <46E8122C.4000505@gmx.de>
Date:	Wed, 12 Sep 2007 18:22:04 +0200
From:	Johannes Dickgreber <tanzy@gmx.de>
User-Agent: Thunderbird 1.5.0.12 (X11/20060911)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	ralf@linux-mips.org, kumba@gentoo.org
Subject: MIPS N32 tar could not change time on unpacked file
X-Enigmail-Version: 0.95.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Return-Path: <tanzy@gmx.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16477
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tanzy@gmx.de
Precedence: bulk
X-list: linux-mips


Hi

After I installed a new glibc-2.5 with linux-headers-2.6.21 on
my SGI Octane, tar could not change time on unpacked file.

For each file there was "utime invalid argument".

System Gentoo MIPS N32
Kernel 2.6.22 with mips-git20070902 plus modified skylark patches

I changed this

--- linux-2.6.22-mips20070902/arch/mips/kernel/scall64-n32.S	2007-07-09 01:32:17 +0200
+++ linux-octane-1/arch/mips/kernel/scall64-n32.S	2007-09-12 12:14:41 +0200
@@ -375,7 +375,7 @@ EXPORT(sysn32_call_table)
 	PTR	sys_mkdirat
 	PTR	sys_mknodat
 	PTR	sys_fchownat
-	PTR	sys_futimesat			/* 6255 */
+	PTR	compat_sys_futimesat		/* 6255 */
 	PTR	sys_newfstatat
 	PTR	sys_unlinkat
 	PTR	sys_renameat


Now tar was fully working.

Bye johannes
