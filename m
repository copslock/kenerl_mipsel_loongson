Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Jul 2008 17:25:55 +0100 (BST)
Received: from smtp6.pp.htv.fi ([213.243.153.40]:31961 "EHLO smtp6.pp.htv.fi")
	by ftp.linux-mips.org with ESMTP id S28581163AbYGPQZx (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 16 Jul 2008 17:25:53 +0100
Received: from cs181140183.pp.htv.fi (cs181140183.pp.htv.fi [82.181.140.183])
	by smtp6.pp.htv.fi (Postfix) with ESMTP id 250205BC00C;
	Wed, 16 Jul 2008 19:25:50 +0300 (EEST)
Date:	Wed, 16 Jul 2008 19:25:40 +0300
From:	Adrian Bunk <bunk@kernel.org>
To:	"Robert P. J. Day" <rpjday@crashcourse.ca>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [2.6 patch] mips/sgi-ip22/ip28-berr.c: fix the build
Message-ID: <20080716162540.GB17329@cs181140183.pp.htv.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <bunk@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bunk@kernel.org
Precedence: bulk
X-list: linux-mips

Commit 52f4f6bbcff5510f662a002ec1219660ea25af62
([MIPS] Use kernel-supplied ARRAY_SIZE() macro.)
causes the following compile error:

<--  snip  -->

...
  CC      arch/mips/sgi-ip22/ip28-berr.o
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c: In function 'ip28_be_interrupt':
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: error: subscripted value is neither array nor pointer
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: error: subscripted value is neither array nor pointer
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:415: warning: type defaults to 'int' in declaration of 'type name'
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: error: subscripted value is neither array nor pointer
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: error: subscripted value is neither array nor pointer
/home/bunk/linux/kernel-2.6/git/linux-2.6/arch/mips/sgi-ip22/ip28-berr.c:424: warning: type defaults to 'int' in declaration of 'type name'
make[2]: *** [arch/mips/sgi-ip22/ip28-berr.o] Error 1

<--  snip  -->

Using ARRAY_SIZE in these places in arch/mips/sgi-ip22/ip28-berr.c was 
bogus, and therefore gets reverted by this patch.

Signed-off-by: Adrian Bunk <bunk@kernel.org>

---

 arch/mips/sgi-ip22/ip28-berr.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/mips/sgi-ip22/ip28-berr.c
+++ b/arch/mips/sgi-ip22/ip28-berr.c
@@ -412,7 +412,7 @@ static int ip28_be_interrupt(const struct pt_regs *regs)
 	 * Now we have an asynchronous bus error, speculatively or DMA caused.
 	 * Need to search all DMA descriptors for the error address.
 	 */
-	for (i = 0; i < ARRAY_SIZE(hpc3); ++i) {
+	for (i = 0; i < sizeof(hpc3)/sizeof(struct hpc3_stat); ++i) {
 		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
 		if ((cpu_err_stat & CPU_ERRMASK) &&
 		    (cpu_err_addr == hp->ndptr || cpu_err_addr == hp->cbp))
@@ -421,7 +421,7 @@ static int ip28_be_interrupt(const struct pt_regs *regs)
 		    (gio_err_addr == hp->ndptr || gio_err_addr == hp->cbp))
 			break;
 	}
-	if (i < ARRAY_SIZE(hpc3)) {
+	if (i < sizeof(hpc3)/sizeof(struct hpc3_stat)) {
 		struct hpc3_stat *hp = (struct hpc3_stat *)&hpc3 + i;
 		printk(KERN_ERR "at DMA addresses: HPC3 @ %08lx:"
 		       " ctl %08x, ndp %08x, cbp %08x\n",
