Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2003 12:45:10 +0100 (BST)
Received: from p508B67B0.dip.t-dialin.net ([IPv6:::ffff:80.139.103.176]:6853
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225240AbTFLLpI>; Thu, 12 Jun 2003 12:45:08 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h5CBj0bY008833;
	Thu, 12 Jun 2003 04:45:01 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h5CBiv0v008832;
	Thu, 12 Jun 2003 13:44:57 +0200
Date: Thu, 12 Jun 2003 13:44:57 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Andrew Clausen <clausen@gnu.org>
Cc: Trevor Woerner <mips081@vtnet.ca>, linux-mips@linux-mips.org
Subject: Re: 64-bit sysinfo
Message-ID: <20030612114457.GB8390@linux-mips.org>
References: <200306120659.26501.mips081@vtnet.ca> <20030612213625.GF480@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030612213625.GF480@gnu.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Jun 12, 2003 at 09:36:25PM +0000, Andrew Clausen wrote:

> On Thu, Jun 12, 2003 at 06:59:26AM -0400, Trevor Woerner wrote:
> > I'm crossing my fingers and hoping that my solution is to build all 
> > user-space apps with some switch that will set the sizes of data types 
> > to be the same between user space and kernel space. Does some such 
> > option exist?
> 
> No, the kernel should provide 32 bit values.  This is a bug.
> 
> I *thought* I sent a patch for this a while ago... I'm not sure now.

You sent it and I applied your patch on February 21.  Old mail appended
below again for Trevor's reference.  It doesn't explain why he sees
64-bit values though.  Trevor, what kernel exactly are you running?

  Ralf

Date:	Thu, 20 Feb 2003 11:26:55 +1100
From:	Andrew Clausen <clausen@melbourne.sgi.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org, linux-ia64@linuxia64.org
Subject: [patch] sys32_sysinfo broken on mips64 and ia64
Message-ID: <20030220002655.GE915@pureza.melbourne.sgi.com>

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
