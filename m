Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Jan 2005 15:39:03 +0000 (GMT)
Received: from mba.ocn.ne.jp ([IPv6:::ffff:210.190.142.172]:15306 "HELO
	smtp.mba.ocn.ne.jp") by linux-mips.org with SMTP
	id <S8225227AbVAFPi6>; Thu, 6 Jan 2005 15:38:58 +0000
Received: from localhost (p4111-ipad29funabasi.chiba.ocn.ne.jp [221.184.71.111])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id ABB5E167A; Fri,  7 Jan 2005 00:38:54 +0900 (JST)
Date: Fri, 07 Jan 2005 00:45:21 +0900 (JST)
Message-Id: <20050107.004521.74752947.anemo@mba.ocn.ne.jp>
To: macro@mips.com
Cc: ralf@linux-mips.org, linux-mips@linux-mips.org,
	macro@linux-mips.org
Subject: Re: [PATCH] I/O helpers rework
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
References: <Pine.LNX.4.61.0412151936460.14855@perivale.mips.com>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.3 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6814
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

>>>>> On Wed, 15 Dec 2004 21:13:37 +0000 (GMT), "Maciej W. Rozycki" <macro@mips.com> said:

macro>  As the whole file seemed a bit messy to me I decided to
macro> rewrite these functions/macros completely.  To ease long-term
macro> maintenance I created common templates for all classes of
macro> accesses which expand to appropriate code for different
macro> transfer unit width.  I made all operations to be expressed as
macro> inline functions to catch dangerous/incorrect uses.  The result
macro> are the following function classes:

Thanks for your good job.  I have a few comments/requests.

1. How about adding 'volatile' and '__iomem' to *read*()/*write*() ?
   While some archs use 'volatile void __iomem *' and some are not, I
   think *read*()/*write*()/ioremap()/iounmap() should use same type.
   This will remove some compiler warnings.

2. How about using 'const void *' for outs*()?  This will remove some
   compiler warnings too.

3. In *in*()/*out*(), it would be better to call __swizzle_addr*()
   AFTER adding mips_io_port_base.  This unifies the meaning of the
   argument of __swizzle_addr*() (always virtual address).  Then,
   mach-specific __swizzle_addr*() can to every evil thing based on
   the argument.

4. How about enclosing all *ioswab*() by '#ifndef' ?  Also how about
   passing virtual address to *ioswab*() ?  I mean something like:

# ifndef ioswabw
#  define ioswabw(a,x)		le16_to_cpu(x)
# endif
# ifndef __raw_ioswabw
#  define __raw_ioswabw(a,x)	(x)
# endif
...
	__val = pfx##ioswab##bwlq(__mem, val);				\

  Then we can provide mach-specific *ioswab*() in mach-*/mangle-port.h
  and can do every evil thing based on its argument.  It is usefull on
  machines which have regions with defirrent endian conversion scheme.
  Also, this can clean up CONFIG_SGI_IP22 from io.h
  (mach-ip22/mangle-port.h can provide its own *ioswabw*()).


---
Atsushi Nemoto
