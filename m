Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Feb 2006 16:18:31 +0000 (GMT)
Received: from mba.ocn.ne.jp ([210.190.142.172]:35803 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133390AbWBTQSW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 20 Feb 2006 16:18:22 +0000
Received: from localhost (p8134-ipad206funabasi.chiba.ocn.ne.jp [222.145.82.134])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 54BC8AB73; Tue, 21 Feb 2006 01:25:16 +0900 (JST)
Date:	Tue, 21 Feb 2006 01:25:06 +0900 (JST)
Message-Id: <20060221.012506.25910204.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] jiffies_to_compat_timeval fix
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
X-archive-position: 10572
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

The last argument of div_long_long_rem() must be long.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/binfmt_elfn32.c b/arch/mips/kernel/binfmt_elfn32.c
index d8e2674..4a9f1ec 100644
--- a/arch/mips/kernel/binfmt_elfn32.c
+++ b/arch/mips/kernel/binfmt_elfn32.c
@@ -103,8 +103,9 @@ jiffies_to_compat_timeval(unsigned long 
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC;
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
-	value->tv_usec /= NSEC_PER_USEC;
+	long rem;
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &rem);
+	value->tv_usec = rem / NSEC_PER_USEC;
 }
 
 #define ELF_CORE_EFLAGS EF_MIPS_ABI2
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index cec5f32..e318137 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -105,8 +105,9 @@ jiffies_to_compat_timeval(unsigned long 
 	 * one divide.
 	 */
 	u64 nsec = (u64)jiffies * TICK_NSEC;
-	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &value->tv_usec);
-	value->tv_usec /= NSEC_PER_USEC;
+	long rem;
+	value->tv_sec = div_long_long_rem(nsec, NSEC_PER_SEC, &rem);
+	value->tv_usec = rem / NSEC_PER_USEC;
 }
 
 #undef ELF_CORE_COPY_REGS
