Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 17 Feb 2007 15:14:26 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:7877 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20037562AbXBQPOU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 17 Feb 2007 15:14:20 +0000
Received: from localhost (p5247-ipad204funabasi.chiba.ocn.ne.jp [222.146.92.247])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 30CA9B64B; Sun, 18 Feb 2007 00:12:58 +0900 (JST)
Date:	Sun, 18 Feb 2007 00:12:57 +0900 (JST)
Message-Id: <20070218.001257.88702762.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	vagabon.xyz@gmail.com, linux-mips@linux-mips.org
Subject: Re: struct sigcontext for N32 userland
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20070213113826.GA4569@linux-mips.org>
References: <20070213.005113.89067116.anemo@mba.ocn.ne.jp>
	<cda58cb80702130027o1ebec149ib25090881f7ac6a1@mail.gmail.com>
	<20070213113826.GA4569@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Tue, 13 Feb 2007 11:38:26 +0000, Ralf Baechle <ralf@linux-mips.org> wrote:
> > >The kernel use 64-bit for sc_regs[0], and both N32/N64 userland
> > >expects it was 64-bit.  But size of 'long' on N32 is actually 32-bit.
> > >So this definition make some confusion.
> > >
> > >glibc has its own sigcontext.h and it uses 'unsigned long long' for
> > >sc_regs, so no real problem with glibc.
> 
> Looks like a case for __u32, __u64 then.

Then how about this?

Subject: export proper struct sigcontext to userland on N32

The kernel use 64-bit for sc_regs[0], and both N32/N64 userland
expects it was 64-bit.  But size of 'long' on N32 is actually 32-bit.
So this definition make some confusion.  Use __u32 and __u64 for
N32/N64 sigcontext to get rid of this confusion.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
diff --git a/include/asm-mips/sigcontext.h b/include/asm-mips/sigcontext.h
index 3c175a7..9729474 100644
--- a/include/asm-mips/sigcontext.h
+++ b/include/asm-mips/sigcontext.h
@@ -42,6 +42,7 @@ struct sigcontext {
 
 #if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32
 
+#include <linux/posix_types.h>
 /*
  * Keep this struct definition in sync with the sigcontext fragment
  * in arch/mips/tools/offset.c
@@ -53,27 +54,25 @@ struct sigcontext {
  * entries, add sc_dsp and sc_reserved for padding.  No prisoners.
  */
 struct sigcontext {
-	unsigned long	sc_regs[32];
-	unsigned long	sc_fpregs[32];
-	unsigned long	sc_mdhi;
-	unsigned long	sc_hi1;
-	unsigned long	sc_hi2;
-	unsigned long	sc_hi3;
-	unsigned long	sc_mdlo;
-	unsigned long	sc_lo1;
-	unsigned long	sc_lo2;
-	unsigned long	sc_lo3;
-	unsigned long	sc_pc;
-	unsigned int	sc_fpc_csr;
-	unsigned int	sc_used_math;
-	unsigned int	sc_dsp;
-	unsigned int	sc_reserved;
+	__u64	sc_regs[32];
+	__u64	sc_fpregs[32];
+	__u64	sc_mdhi;
+	__u64	sc_hi1;
+	__u64	sc_hi2;
+	__u64	sc_hi3;
+	__u64	sc_mdlo;
+	__u64	sc_lo1;
+	__u64	sc_lo2;
+	__u64	sc_lo3;
+	__u64	sc_pc;
+	__u32	sc_fpc_csr;
+	__u32	sc_used_math;
+	__u32	sc_dsp;
+	__u32	sc_reserved;
 };
 
 #ifdef __KERNEL__
 
-#include <linux/posix_types.h>
-
 struct sigcontext32 {
 	__u32		sc_regmask;	/* Unused */
 	__u32		sc_status;	/* Unused */
