Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 16:02:34 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:32209 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28578958AbYFLPCc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 16:02:32 +0100
Received: from localhost (p2130-ipad306funabasi.chiba.ocn.ne.jp [123.217.172.130])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 37F5CB6A1; Fri, 13 Jun 2008 00:02:23 +0900 (JST)
Date:	Fri, 13 Jun 2008 00:03:50 +0900 (JST)
Message-Id: <20080613.000350.93206311.anemo@mba.ocn.ne.jp>
To:	ralf@linux-mips.org
Cc:	bunk@kernel.org, linux-mips@linux-mips.org, mb@bu3sch.de,
	aurelien@aurel32.net, daniel.j.laird@nxp.com
Subject: Re: pending mips build fixes
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
In-Reply-To: <20080612135835.GB20015@linux-mips.org>
References: <20080612134539.GA20487@cs181133002.pp.htv.fi>
	<20080612135835.GB20015@linux-mips.org>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19517
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

On Thu, 12 Jun 2008 14:58:35 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
> >   MIPS: Fix CONF_CM_DEFAULT build error
> >   http://lkml.org/lkml/2008/6/1/125
> 
> That won't fly.  CONF_CM_DEFAULT is being dereferenced before
> _page_cachable_default has been initialized.

Yes, And here is an updated untested patch.  Daniel, could you review
or try this?

------------------------------------------------------
Subject: MIPS: Fix pnx8550 build breakage
From: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

This patch fix a breakage by commit
351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 > ([MIPS] Allow setting of
the cache attribute at run time.)

This patch introduce an weak __coherency_setup() to support PNX8550
which needs special handling on cache coherency updating.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/mm/c-r4k.c                       |   19 ++++++++++++-------
 arch/mips/nxp/pnx8550/jbs/board_setup.c    |   19 ++++++++++++-------
 arch/mips/nxp/pnx8550/stb810/board_setup.c |   19 ++++++++++++-------
 include/asm-mips/pgtable-bits.h            |    2 --
 4 files changed, 36 insertions(+), 23 deletions(-)

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 643c8bc..d596b74 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1237,14 +1237,9 @@ static int __init cca_setup(char *str)
 
 __setup("cca=", cca_setup);
 
-static void __cpuinit coherency_setup(void)
+void __cpuinit __weak __coherency_setup(int ccaval)
 {
-	if (cca < 0 || cca > 7)
-		cca = read_c0_config() & CONF_CM_CMASK;
-	_page_cachable_default = cca << _CACHE_SHIFT;
-
-	pr_debug("Using cache attribute %d\n", cca);
-	change_c0_config(CONF_CM_CMASK, cca);
+	change_c0_config(CONF_CM_CMASK, ccaval);
 
 	/*
 	 * c0_status.cu=0 specifies that updates by the sc instruction use
@@ -1274,6 +1269,16 @@ static void __cpuinit coherency_setup(void)
 	}
 }
 
+static void __cpuinit coherency_setup(void)
+{
+	if (cca < 0 || cca > 7)
+		cca = read_c0_config() & CONF_CM_CMASK;
+	_page_cachable_default = cca << _CACHE_SHIFT;
+
+	pr_debug("Using cache attribute %d\n", cca);
+	__coherency_setup(cca);
+}
+
 #if defined(CONFIG_DMA_NONCOHERENT)
 
 static int __cpuinitdata coherentio;
diff --git a/arch/mips/nxp/pnx8550/jbs/board_setup.c b/arch/mips/nxp/pnx8550/jbs/board_setup.c
index f92826e..d528395 100644
--- a/arch/mips/nxp/pnx8550/jbs/board_setup.c
+++ b/arch/mips/nxp/pnx8550/jbs/board_setup.c
@@ -45,18 +45,23 @@
 				     "nop; nop; nop; nop; nop; nop;\n\t" \
 				     ".set reorder\n\t")
 
-void __init board_setup(void)
+void __cpuinit __coherency_setup(int ccaval)
 {
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
+	unsigned long config0 = read_c0_config();
 
 	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
+	config0 &= ~(CONF_CM_CMASK | (CONF_CM_CMASK << 25) |
+			(CONF_CM_CMASK << 28));
+	config0 |= (ccaval | (ccaval << 25) | (ccaval << 28));
 	write_c0_config(config0);
 	BARRIER;
+}
+
+void __init board_setup(void)
+{
+	unsigned long configpr;
+
+	__coherency_setup(_CACHE_CACHABLE_NONCOHERENT >> _CACHE_SHIFT);
 
 	configpr = read_c0_config7();
 	configpr |= (1<<19); /* enable tlb */
diff --git a/arch/mips/nxp/pnx8550/stb810/board_setup.c b/arch/mips/nxp/pnx8550/stb810/board_setup.c
index 1282c27..7bd060f 100644
--- a/arch/mips/nxp/pnx8550/stb810/board_setup.c
+++ b/arch/mips/nxp/pnx8550/stb810/board_setup.c
@@ -31,17 +31,22 @@
 
 #include <glb.h>
 
-void __init board_setup(void)
+void __cpuinit __coherency_setup(int ccaval)
 {
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
+	unsigned long config0 = read_c0_config();
 
 	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
+	config0 &= ~(CONF_CM_CMASK | (CONF_CM_CMASK << 25) |
+			(CONF_CM_CMASK << 28));
+	config0 |= (ccaval | (ccaval << 25) | (ccaval << 28));
 	write_c0_config(config0);
+}
+
+void __init board_setup(void)
+{
+	unsigned long configpr;
+
+	__coherency_setup(_CACHE_CACHABLE_NONCOHERENT >> _CACHE_SHIFT);
 
 	configpr = read_c0_config7();
 	configpr |= (1<<19); /* enable tlb */
diff --git a/include/asm-mips/pgtable-bits.h b/include/asm-mips/pgtable-bits.h
index 60e2f93..51b34a4 100644
--- a/include/asm-mips/pgtable-bits.h
+++ b/include/asm-mips/pgtable-bits.h
@@ -134,6 +134,4 @@
 
 #define _PAGE_CHG_MASK  (PAGE_MASK | _PAGE_ACCESSED | _PAGE_MODIFIED | _CACHE_MASK)
 
-#define CONF_CM_DEFAULT		(PAGE_CACHABLE_DEFAULT>>_CACHE_SHIFT)
-
 #endif /* _ASM_PGTABLE_BITS_H */
