Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Oct 2004 02:21:30 +0100 (BST)
Received: from topsns.toshiba-tops.co.jp ([IPv6:::ffff:202.230.225.5]:54552
	"HELO topsns.toshiba-tops.co.jp") by linux-mips.org with SMTP
	id <S8225211AbUJFBVQ>; Wed, 6 Oct 2004 02:21:16 +0100
Received: from newms.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 6 Oct 2004 01:21:14 UT
Received: from srd2sd.toshiba-tops.co.jp (gw-chiba7.toshiba-tops.co.jp [172.17.244.27])
	by newms.toshiba-tops.co.jp (Postfix) with ESMTP
	id 27BAA239E24; Wed,  6 Oct 2004 10:23:10 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id i961KO8G024182;
	Wed, 6 Oct 2004 10:20:24 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date: Wed, 06 Oct 2004 10:19:20 +0900 (JST)
Message-Id: <20041006.101920.126571873.nemoto@toshiba-tops.co.jp>
To: linux-mips@linux-mips.org
Cc: ralf@linux-mips.org
Subject: fpu_emulator can lose fpu on get_user/put_user
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 3.3 on Emacs 21.2 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

I found a potential problem in math emulation.  The math-emu uses
put_user/get_user to fetch the instruction or to emulate load/store
fp-regs.  The put_user/get_user can sleep then we can lose fpu
ownership on it.  It it happened, subsequent restore_fp will cause CpU
exception which not allowed in kernel.

Here is a quick fix.  Can be applied bath 2.4 and 2.6.  Could you apply?

--- linux-mips/arch/mips/kernel/traps.c	Sat Aug 14 19:55:20 2004
+++ linux/arch/mips/kernel/traps.c	Wed Oct  6 09:50:26 2004
@@ -509,6 +509,10 @@
 		/* Run the emulator */
 		sig = fpu_emulator_cop1Handler (0, regs,
 			&current->thread.fpu.soft);
+		if (!is_fpu_owner()) {
+			/* We might lose fpu in fpu_emulator. */
+			own_fpu();
+		}
 
 		/*
 		 * We can't allow the emulated instruction to leave any of


Also, there is another problem in the math-emu.  While math-emu is not
reentrant, it will not work properly if a process lose ownership in
the math-emu and another process uses the math-emu.  One possible fix
is to save/restore ieee754_csr on get_user/put_user.  I will post a
patch later.

---
Atsushi Nemoto
