Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Feb 2007 13:07:47 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:15778 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20038563AbXBHNHp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 8 Feb 2007 13:07:45 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.13.8/8.13.8) with ESMTP id l18D7kFb012255;
	Thu, 8 Feb 2007 13:07:46 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.13.8/8.13.8/Submit) id l18D7iRT012254;
	Thu, 8 Feb 2007 13:07:44 GMT
Date:	Thu, 8 Feb 2007 13:07:44 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	"Maciej W. Rozycki" <macro@linux-mips.org>
Cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix run_uncached warning about 32bit kernel
Message-ID: <20070208130744.GB10739@linux-mips.org>
References: <200702060159.l161xM59075711@mbox33.po.2iij.net> <20070206152817.GB5660@linux-mips.org> <Pine.LNX.4.64N.0702061818550.28283@blysk.ds.pg.gda.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64N.0702061818550.28283@blysk.ds.pg.gda.pl>
User-Agent: Mutt/1.4.2.2i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13983
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 06, 2007 at 06:20:39PM +0000, Maciej W. Rozycki wrote:

> > > arch/mips/lib/uncached.c: In function 'run_uncached':
> > > arch/mips/lib/uncached.c:47: warning: comparison is always true due to limited range of data type
> > > arch/mips/lib/uncached.c:48: warning: comparison is always false due to limited range of data type
> > > arch/mips/lib/uncached.c:57: warning: comparison is always true due to limited range of data type
> > > arch/mips/lib/uncached.c:58: warning: comparison is always false due to limited range of data type
> > 
> > Thanks, applied.
> 
>  "Fixing" bugs in the compiler, huh? ;-)  I suppose there should be a note 
> somewhere nearby then, so there is a remote chance to remove the clutter 
> in the future.

Well, some of the warnings are also simply due to broken code.  This is
the result of preprocessing the code without Yoichi's patch applied:

[...]
 if (sp >= (long)0x80000000 && sp < (long)0xc0000000)
  usp = ((((int)(int)(sp)) & 0x1fffffff) | 0xa0000000);
 else if ((long long)sp >= (long long)(0x8000000000000000LL | ((0LL)<<59) | (0)) &&
   (long long)sp < (long long)(0x8000000000000000LL | ((8LL)<<59) | (0)))
  usp = (0x8000000000000000LL | (((long long)2)<<59) | ((((long long)sp) & -1)));

else {
  do { __asm__ __volatile__("break %0" : : "i" (512)); } while (0);
  usp = sp;
 }
[...]

So (0x8000000000000000LL | ((0LL)<<59) | (0)) is 0x8000000000000000LL which
then is casted to _signed_ long long, so becomes -9223372036854775808, the
most negative representable number so the two "comparison is always true
due to limited range of data type" warnings are perfectly correct.

Treating addresses as signed is a dangerous thing and we reallly only
should do it where extending 32-bit addresses to 64-bit because that's
what the architecture does.  So I would suggest as part of cleaning u the
mess something like below totally untested patch.

Comments?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/include/asm-mips/addrspace.h b/include/asm-mips/addrspace.h
index c627508..ff2dd38 100644
--- a/include/asm-mips/addrspace.h
+++ b/include/asm-mips/addrspace.h
@@ -10,6 +10,7 @@
 #ifndef _ASM_ADDRSPACE_H
 #define _ASM_ADDRSPACE_H
 
+#include <linux/types.h>
 #include <spaces.h>
 
 /*
@@ -22,12 +23,12 @@
 #define _CONST64_(x)	x
 #else
 #define _ATYPE_		__PTRDIFF_TYPE__
-#define _ATYPE32_	int
-#define _ATYPE64_	__s64
+#define _ATYPE32_	unsigned int
+#define _ATYPE64_	__u64
 #ifdef CONFIG_64BIT
-#define _CONST64_(x)	x ## L
+#define _CONST64_(x)	x ## UL
 #else
-#define _CONST64_(x)	x ## LL
+#define _CONST64_(x)	x ## ULL
 #endif
 #endif
 
