Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Nov 2005 07:47:06 +0000 (GMT)
Received: from topsns.toshiba-tops.co.jp ([202.230.225.5]:45828 "HELO
	topsns.toshiba-tops.co.jp") by ftp.linux-mips.org with SMTP
	id S8133452AbVKXHqr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 24 Nov 2005 07:46:47 +0000
Received: from inside-ms1.toshiba-tops.co.jp by topsns.toshiba-tops.co.jp
          via smtpd (for mail.linux-mips.org [62.254.210.162]) with SMTP; 24 Nov 2005 07:50:46 UT
Received: from topsms.toshiba-tops.co.jp (localhost.localdomain [127.0.0.1])
	by localhost.toshiba-tops.co.jp (Postfix) with ESMTP id 4A36020088;
	Thu, 24 Nov 2005 16:50:44 +0900 (JST)
Received: from srd2sd.toshiba-tops.co.jp (srd2sd.toshiba-tops.co.jp [172.17.28.2])
	by topsms.toshiba-tops.co.jp (Postfix) with ESMTP id 37D272007A;
	Thu, 24 Nov 2005 16:50:44 +0900 (JST)
Received: from localhost (fragile [172.17.28.65])
	by srd2sd.toshiba-tops.co.jp (8.12.10/8.12.10) with ESMTP id jAO7oh4D081338;
	Thu, 24 Nov 2005 16:50:44 +0900 (JST)
	(envelope-from anemo@mba.ocn.ne.jp)
Date:	Thu, 24 Nov 2005 16:50:43 +0900 (JST)
Message-Id: <20051124.165043.112050815.nemoto@toshiba-tops.co.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix gdb-stub for kernel compiled with higher ISA level
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
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
X-archive-position: 9552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The modern gdb seems to require 64bit values in remote packet for
32bit kernel which is compiled with -march=mips3, etc.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/gdb-stub.c b/arch/mips/kernel/gdb-stub.c
index 96d18c4..9fedfa4 100644
--- a/arch/mips/kernel/gdb-stub.c
+++ b/arch/mips/kernel/gdb-stub.c
@@ -670,6 +670,13 @@ static void kgdb_wait(void *arg)
 }
 
 
+#if defined(CONFIG_32BIT) && \
+	(_MIPS_ISA == _MIPS_ISA_MIPS3 || \
+	 _MIPS_ISA == _MIPS_ISA_MIPS4 || \
+	 _MIPS_ISA == _MIPS_ISA_MIPS5 || \
+	 _MIPS_ISA == _MIPS_ISA_MIPS64)
+#define GDB_EXPECT_64BIT_REG
+#endif
 /*
  * This function does all command processing for interfacing to gdb.  It
  * returns 1 if you should skip the instruction at the trap address, 0
@@ -685,6 +692,9 @@ void handle_exception (struct gdb_regs *
 	unsigned long *stack;
 	int i;
 	int bflag = 0;
+#ifdef GDB_EXPECT_64BIT_REG
+	u64 tmp64;
+#endif
 
 	kgdb_started = 1;
 
@@ -762,7 +772,12 @@ void handle_exception (struct gdb_regs *
 	*ptr++ = hexchars[REG_EPC >> 4];
 	*ptr++ = hexchars[REG_EPC & 0xf];
 	*ptr++ = ':';
+#ifdef GDB_EXPECT_64BIT_REG
+	tmp64 = regs->cp0_epc;
+	ptr = mem2hex((char *)&tmp64, ptr, sizeof(u64), 0);
+#else
 	ptr = mem2hex((char *)&regs->cp0_epc, ptr, sizeof(long), 0);
+#endif
 	*ptr++ = ';';
 
 	/*
@@ -771,7 +786,12 @@ void handle_exception (struct gdb_regs *
 	*ptr++ = hexchars[REG_FP >> 4];
 	*ptr++ = hexchars[REG_FP & 0xf];
 	*ptr++ = ':';
+#ifdef GDB_EXPECT_64BIT_REG
+	tmp64 = regs->reg30;
+	ptr = mem2hex((char *)&tmp64, ptr, sizeof(u64), 0);
+#else
 	ptr = mem2hex((char *)&regs->reg30, ptr, sizeof(long), 0);
+#endif
 	*ptr++ = ';';
 
 	/*
@@ -780,7 +800,12 @@ void handle_exception (struct gdb_regs *
 	*ptr++ = hexchars[REG_SP >> 4];
 	*ptr++ = hexchars[REG_SP & 0xf];
 	*ptr++ = ':';
+#ifdef GDB_EXPECT_64BIT_REG
+	tmp64 = regs->reg29;
+	ptr = mem2hex((char *)&tmp64, ptr, sizeof(u64), 0);
+#else
 	ptr = mem2hex((char *)&regs->reg29, ptr, sizeof(long), 0);
+#endif
 	*ptr++ = ';';
 
 	*ptr++ = 0;
@@ -819,12 +844,19 @@ void handle_exception (struct gdb_regs *
 		 */
 		case 'g':
 			ptr = output_buffer;
+#ifdef GDB_EXPECT_64BIT_REG
+			for (i = 0; i < 32 + 6 + 32 + 2 + 2 + 16; i++) {
+				tmp64 = *(&regs->reg0 + i);
+				ptr = mem2hex((char *)&tmp64, ptr, sizeof(u64), 0);
+			}
+#else
 			ptr = mem2hex((char *)&regs->reg0, ptr, 32*sizeof(long), 0); /* r0...r31 */
 			ptr = mem2hex((char *)&regs->cp0_status, ptr, 6*sizeof(long), 0); /* cp0 */
 			ptr = mem2hex((char *)&regs->fpr0, ptr, 32*sizeof(long), 0); /* f0...31 */
 			ptr = mem2hex((char *)&regs->cp1_fsr, ptr, 2*sizeof(long), 0); /* cp1 */
 			ptr = mem2hex((char *)&regs->frame_ptr, ptr, 2*sizeof(long), 0); /* frp */
 			ptr = mem2hex((char *)&regs->cp0_index, ptr, 16*sizeof(long), 0); /* cp0 */
+#endif
 			break;
 
 		/*
@@ -833,6 +865,13 @@ void handle_exception (struct gdb_regs *
 		case 'G':
 		{
 			ptr = &input_buffer[1];
+#ifdef GDB_EXPECT_64BIT_REG
+			for (i = 0; i < 32 + 6 + 32 + 2 + 2 + 16; i++) {
+				hex2mem(ptr, (char *)&tmp64, sizeof(u64), 0, 0);
+				*(&regs->reg0 + i) = (long)tmp64;
+				ptr += 2*sizeof(u64);
+			}
+#else
 			hex2mem(ptr, (char *)&regs->reg0, 32*sizeof(long), 0, 0);
 			ptr += 32*(2*sizeof(long));
 			hex2mem(ptr, (char *)&regs->cp0_status, 6*sizeof(long), 0, 0);
@@ -844,6 +883,7 @@ void handle_exception (struct gdb_regs *
 			hex2mem(ptr, (char *)&regs->frame_ptr, 2*sizeof(long), 0, 0);
 			ptr += 2*(2*sizeof(long));
 			hex2mem(ptr, (char *)&regs->cp0_index, 16*sizeof(long), 0, 0);
+#endif
 			strcpy(output_buffer,"OK");
 		 }
 		break;
