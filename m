Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Dec 2004 15:23:45 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:714 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8224947AbULUPXk>; Tue, 21 Dec 2004 15:23:40 +0000
Received: from localhost (p7164-ipad25funabasi.chiba.ocn.ne.jp [220.104.85.164])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 7A537321D; Wed, 22 Dec 2004 00:23:27 +0900 (JST)
Date: Wed, 22 Dec 2004 00:28:53 +0900 (JST)
Message-Id: <20041222.002853.55515442.anemo@mba.ocn.ne.jp>
To: ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: fix FIXADDR_TOP for TX39/TX49
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20030517.214555.74756802.anemo@mba.ocn.ne.jp>
References: <20030517.214555.74756802.anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 20.7 / Mule 4.0 (HANANOEN)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6726
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Sat, 17 May 2003 21:45:55 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:

anemo> On TX39/TX49, high 16MB in virtual address space
anemo> (0xff000000-0xffffffff) are reserved and can not be used as
anemo> normal mapped/cached segment.

anemo> This patch fixes FIXADDR_TOP for TX39/TX49.  FIXADDR_TOP is
anemo> used not only if CONFIG_HIGHMEM is enabled.  It is also used
anemo> for high limit address for vmalloc.

anemo> This patch can be applied to both 2.4 and 2.5.  I'm not sure
anemo> whether subtracting 0x2000 is necessary or not but doing it is
anemo> a safe bet.  Please apply.

This patch can still be applied to 2.6.  Could you apply?

--- linux-mips/include/asm-mips/fixmap.h	Sat Nov 27 00:39:25 2004
+++ linux/include/asm-mips/fixmap.h	Sat Dec 18 21:21:01 2004
@@ -70,7 +70,11 @@
  * the start of the fixmap, and leave one page empty
  * at the top of mem..
  */
+#if defined(CONFIG_CPU_TX39XX) || defined(CONFIG_CPU_TX49XX)
+#define FIXADDR_TOP	(0xff000000UL - 0x2000)
+#else
 #define FIXADDR_TOP	(0xffffe000UL)
+#endif
 #define FIXADDR_SIZE	(__end_of_fixed_addresses << PAGE_SHIFT)
 #define FIXADDR_START	(FIXADDR_TOP - FIXADDR_SIZE)
 
---
Atsushi Nemoto
