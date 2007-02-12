Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2007 15:52:41 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:65521 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20038870AbXBLPwd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2007 15:52:33 +0000
Received: from localhost (p7240-ipad209funabasi.chiba.ocn.ne.jp [58.88.118.240])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP id 27EC6B420
	for <linux-mips@linux-mips.org>; Tue, 13 Feb 2007 00:51:14 +0900 (JST)
Date:	Tue, 13 Feb 2007 00:51:13 +0900 (JST)
Message-Id: <20070213.005113.89067116.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Subject: struct sigcontext for N32 userland
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 14049
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

If N32 userland refers asm-mips/sigcontext.h, struct sigcontext cause
some troubles.

#if _MIPS_SIM == _MIPS_SIM_ABI64 || _MIPS_SIM == _MIPS_SIM_NABI32

struct sigcontext {
	unsigned long	sc_regs[32];
...


The kernel use 64-bit for sc_regs[0], and both N32/N64 userland
expects it was 64-bit.  But size of 'long' on N32 is actually 32-bit.
So this definition make some confusion.

glibc has its own sigcontext.h and it uses 'unsigned long long' for
sc_regs, so no real problem with glibc.

Should we use 'unsigned long long' here as glibc does?

Or should we have separate definition just for N32 userland?  (kernel
does not use #if _MIPS_SIM == _MIPS_SIM_NABI32 block anyway since
kernel itself is compiled as n64)

Or should we make struct sigcontext private to kernel and do not
export for userland at all?

Or ... do nothing?

---
Atsushi Nemoto
