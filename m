Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2006 17:13:38 +0100 (BST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:31206 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133586AbWDGQN3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2006 17:13:29 +0100
Received: from localhost (p8176-ipad03funabasi.chiba.ocn.ne.jp [219.160.88.176])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 997ED9A98; Sat,  8 Apr 2006 01:24:52 +0900 (JST)
Date:	Sat, 08 Apr 2006 01:25:11 +0900 (JST)
Message-Id: <20060408.012511.75185496.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] nullify __ide_flush_{prologue,epilogue} on UP
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
X-archive-position: 11059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/include/asm-mips/mach-generic/ide.h b/include/asm-mips/mach-generic/ide.h
index 44266e5..e331535 100644
--- a/include/asm-mips/mach-generic/ide.h
+++ b/include/asm-mips/mach-generic/ide.h
@@ -106,14 +106,18 @@ static __inline__ unsigned long ide_defa
 /* MIPS port and memory-mapped I/O string operations.  */
 static inline void __ide_flush_prologue(void)
 {
+#ifdef CONFIG_SMP
 	if (cpu_has_dc_aliases)
 		preempt_disable();
+#endif
 }
 
 static inline void __ide_flush_epilogue(void)
 {
+#ifdef CONFIG_SMP
 	if (cpu_has_dc_aliases)
 		preempt_enable();
+#endif
 }
 
 static inline void __ide_flush_dcache_range(unsigned long addr, unsigned long size)
