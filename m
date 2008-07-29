Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 07:47:30 +0100 (BST)
Received: from smtp5.pp.htv.fi ([213.243.153.39]:64648 "EHLO smtp5.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S20025645AbYG2GrW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 29 Jul 2008 07:47:22 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp5.pp.htv.fi (Postfix) with ESMTP id A8AF55BC043;
	Tue, 29 Jul 2008 09:47:18 +0300 (EEST)
Date:	Tue, 29 Jul 2008 09:46:34 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	Phil Sutter <n0-1@freewrt.org>,
	Florian Fainelli <florian.fainelli@telecomint.eu>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] mips/rb532/: flags are unsigned long
Message-ID: <20080729064634.GJ7713@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

A recent generic change now catches such bugs:

<--  snip  -->

...
  CC      arch/mips/rb532/time.o
cc1: warnings being treated as errors
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/rb532/time.c: In function 'plat_time_init':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/rb532/time.c:55: error: comparison of distinct pointer types lacks a cast
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/rb532/time.c:66: error: comparison of distinct pointer types lacks a cast
make[2]: *** [arch/mips/rb532/time.o] Error 1

<--  snip  -->

Reported-by: Adrian Bunk <bunk@kernel.org>
Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/mips/rb532/gpio.c |    5 +++--
 arch/mips/rb532/time.c |    4 ++--
 2 files changed, 5 insertions(+), 4 deletions(-)

dd1d075171d57dc5a69f6f7094045500c7129686 
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index b2fe82d..00a1c78 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -64,7 +64,8 @@ static struct resource rb532_dev3_ctl_res[] = {
 
 void set_434_reg(unsigned reg_offs, unsigned bit, unsigned len, unsigned val)
 {
-	unsigned flags, data;
+	unsigned long flags;
+	unsigned data;
 	unsigned i = 0;
 
 	spin_lock_irqsave(&dev3.lock, flags);
@@ -90,7 +91,7 @@ EXPORT_SYMBOL(get_434_reg);
 
 void set_latch_u5(unsigned char or_mask, unsigned char nand_mask)
 {
-	unsigned flags;
+	unsigned long flags;
 
 	spin_lock_irqsave(&dev3.lock, flags);
 
diff --git a/arch/mips/rb532/time.c b/arch/mips/rb532/time.c
index db74edf..8e7a468 100644
--- a/arch/mips/rb532/time.c
+++ b/arch/mips/rb532/time.c
@@ -49,8 +49,8 @@ static unsigned long __init cal_r4koff(void)
 
 void __init plat_time_init(void)
 {
-	unsigned int est_freq, flags;
-	unsigned long r4k_offset;
+	unsigned int est_freq;
+	unsigned long flags, r4k_offset;
 
 	local_irq_save(flags);
 
