Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2006 17:59:27 +0200 (CEST)
Received: from mba.ocn.ne.jp ([210.190.142.172]:54472 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S8133490AbWEaP7O (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2006 17:59:14 +0200
Received: from localhost (p5040-ipad30funabasi.chiba.ocn.ne.jp [221.184.80.40])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 34877B7D6; Thu,  1 Jun 2006 00:59:09 +0900 (JST)
Date:	Thu, 01 Jun 2006 01:00:03 +0900 (JST)
Message-Id: <20060601.010003.39154219.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] fix some compiler warnings (field width, unused variable)
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
X-archive-position: 11623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Fix following warnings:
linux/arch/mips/kernel/setup.c:432: warning: field width is not type int (arg 2)
linux/arch/mips/kernel/setup.c:432: warning: field width is not type int (arg 4)
linux/arch/mips/kernel/syscall.c:279: warning: unused variable `len'
linux/arch/mips/kernel/syscall.c:280: warning: unused variable `name'
linux/arch/mips/math-emu/dp_fint.c:32: warning: unused variable `xc'
linux/arch/mips/math-emu/dp_flong.c:32: warning: unused variable `xc'
linux/arch/mips/math-emu/sp_fint.c:32: warning: unused variable `xc'
linux/arch/mips/math-emu/sp_flong.c:32: warning: unused variable `xc'

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
index bcf1b10..132b65d 100644
--- a/arch/mips/kernel/setup.c
+++ b/arch/mips/kernel/setup.c
@@ -426,9 +426,9 @@ static inline void bootmem_init(void)
 		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
 			printk("initrd extends beyond end of memory "
 			       "(0x%0*Lx > 0x%0*Lx)\ndisabling initrd\n",
-			       sizeof(long) * 2,
+			       (int)(sizeof(long) * 2),
 			       (unsigned long long)CPHYSADDR(initrd_end),
-			       sizeof(long) * 2,
+			       (int)(sizeof(long) * 2),
 			       (unsigned long long)PFN_PHYS(max_low_pfn));
 			initrd_start = initrd_end = 0;
 			initrd_reserve_bootmem = 0;
diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
index 8f4fdd9..5e8a18a 100644
--- a/arch/mips/kernel/syscall.c
+++ b/arch/mips/kernel/syscall.c
@@ -276,8 +276,7 @@ void sys_set_thread_area(unsigned long a
 
 asmlinkage int _sys_sysmips(int cmd, long arg1, int arg2, int arg3)
 {
-	int	tmp, len;
-	char	__user *name;
+	int	tmp;
 
 	switch(cmd) {
 	case MIPS_ATOMIC_SET:
diff --git a/arch/mips/math-emu/dp_fint.c b/arch/mips/math-emu/dp_fint.c
index a1962eb..39a71de 100644
--- a/arch/mips/math-emu/dp_fint.c
+++ b/arch/mips/math-emu/dp_fint.c
@@ -29,7 +29,9 @@
 
 ieee754dp ieee754dp_fint(int x)
 {
-	COMPXDP;
+	u64 xm;
+	int xe;
+	int xs;
 
 	CLEARCX;
 
diff --git a/arch/mips/math-emu/dp_flong.c b/arch/mips/math-emu/dp_flong.c
index eae90a8..f08f223 100644
--- a/arch/mips/math-emu/dp_flong.c
+++ b/arch/mips/math-emu/dp_flong.c
@@ -29,7 +29,9 @@
 
 ieee754dp ieee754dp_flong(s64 x)
 {
-	COMPXDP;
+	u64 xm;
+	int xe;
+	int xs;
 
 	CLEARCX;
 
diff --git a/arch/mips/math-emu/sp_fint.c b/arch/mips/math-emu/sp_fint.c
index 7aac13a..e88e125 100644
--- a/arch/mips/math-emu/sp_fint.c
+++ b/arch/mips/math-emu/sp_fint.c
@@ -29,7 +29,9 @@
 
 ieee754sp ieee754sp_fint(int x)
 {
-	COMPXSP;
+	unsigned xm;
+	int xe;
+	int xs;
 
 	CLEARCX;
 
diff --git a/arch/mips/math-emu/sp_flong.c b/arch/mips/math-emu/sp_flong.c
index 3d6c1d1..26d6919 100644
--- a/arch/mips/math-emu/sp_flong.c
+++ b/arch/mips/math-emu/sp_flong.c
@@ -29,7 +29,9 @@
 
 ieee754sp ieee754sp_flong(s64 x)
 {
-	COMPXDP;		/* <--- need 64-bit mantissa temp */
+	u64 xm;		/* <--- need 64-bit mantissa temp */
+	int xe;
+	int xs;
 
 	CLEARCX;
 
