Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2003 00:27:14 +0000 (GMT)
Received: from zok.SGI.COM ([IPv6:::ffff:204.94.215.101]:31155 "EHLO
	zok.sgi.com") by linux-mips.org with ESMTP id <S8225198AbTBTA1N>;
	Thu, 20 Feb 2003 00:27:13 +0000
Received: from larry.melbourne.sgi.com (larry.melbourne.sgi.com [134.14.52.130])
	by zok.sgi.com (8.12.2/8.12.2/linux-outbound_gateway-1.2) with SMTP id h1K0R4Kp006127;
	Wed, 19 Feb 2003 16:27:05 -0800
Received: from pureza.melbourne.sgi.com (pureza.melbourne.sgi.com [134.14.55.244]) by larry.melbourne.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id LAA26904; Thu, 20 Feb 2003 11:27:02 +1100
Received: from pureza.melbourne.sgi.com (localhost.localdomain [127.0.0.1])
	by pureza.melbourne.sgi.com (8.12.5/8.12.5) with ESMTP id h1K0QuuP017897;
	Thu, 20 Feb 2003 11:26:56 +1100
Received: (from clausen@localhost)
	by pureza.melbourne.sgi.com (8.12.5/8.12.5/Submit) id h1K0Qt5q017895;
	Thu, 20 Feb 2003 11:26:55 +1100
Date: Thu, 20 Feb 2003 11:26:55 +1100
From: Andrew Clausen <clausen@melbourne.sgi.com>
To: Linux-MIPS <linux-mips@linux-mips.org>
Cc: ralf@linux-mips.org, linux-ia64@linuxia64.org
Subject: [patch] sys32_sysinfo broken on mips64 and ia64
Message-ID: <20030220002655.GE915@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <clausen@pureza.melbourne.sgi.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1465
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: clausen@melbourne.sgi.com
Precedence: bulk
X-list: linux-mips

Hi all,

The sys32_sysinfo() calls are currently using an old version of
"struct sysinfo32", in both the mips64 and ia64 ports.

busybox's init can't cope with the bogus output on my Origin 200,
so this bug prevents the Debian installer from bootstrapping.

This is the mips64 version of the patch.  A very similar patch
could be constructed for ia64... it's very obvious what to do,
so I'll leave it to you ia64 people :)

Cheers,
Andrew


diff -u -r1.42.2.23 linux32.c
--- arch/mips64/kernel/linux32.c	23 Jan 2003 02:12:59 -0000	1.42.2.23
+++ arch/mips64/kernel/linux32.c	20 Feb 2003 00:05:41 -0000
@@ -672,8 +672,11 @@
         u32 bufferram;
         u32 totalswap;
         u32 freeswap;
-        unsigned short procs;
-        char _f[22];
+        u16 procs;
+	u32 totalhigh;
+	u32 freehigh;
+	u32 mem_unit;
+	char _f[8];
 };
 
 extern asmlinkage int sys_sysinfo(struct sysinfo *info);
@@ -698,6 +701,9 @@
 	err |= __put_user (s.totalswap, &info->totalswap);
 	err |= __put_user (s.freeswap, &info->freeswap);
 	err |= __put_user (s.procs, &info->procs);
+	err |= __put_user (s.totalhigh, &info->totalhigh);
+	err |= __put_user (s.freehigh, &info->freehigh);
+	err |= __put_user (s.mem_unit, &info->mem_unit);
 	if (err)
 		return -EFAULT;
 	return ret;
