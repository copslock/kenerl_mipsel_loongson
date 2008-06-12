Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 17:25:50 +0100 (BST)
Received: from vigor.karmaclothing.net ([217.169.26.28]:50819 "EHLO
	vigor.karmaclothing.net") by ftp.linux-mips.org with ESMTP
	id S28579736AbYFLQZs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 12 Jun 2008 17:25:48 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by vigor.karmaclothing.net (8.14.1/8.14.1) with ESMTP id m5CGOXhl018287;
	Thu, 12 Jun 2008 17:24:39 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m5CGNoMk018002;
	Thu, 12 Jun 2008 17:23:50 +0100
Date:	Thu, 12 Jun 2008 17:23:50 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	bunk@kernel.org, linux-mips@linux-mips.org, mb@bu3sch.de,
	aurelien@aurel32.net, daniel.j.laird@nxp.com
Subject: Re: pending mips build fixes
Message-ID: <20080612162350.GA19234@linux-mips.org>
References: <20080612134539.GA20487@cs181133002.pp.htv.fi> <20080612135835.GB20015@linux-mips.org> <20080613.000350.93206311.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080613.000350.93206311.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19518
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jun 13, 2008 at 12:03:50AM +0900, Atsushi Nemoto wrote:

> This patch fix a breakage by commit
> 351336929ccf222ae38ff0cb7a8dd5fd5c6236a0 > ([MIPS] Allow setting of
> the cache attribute at run time.)
> 
> This patch introduce an weak __coherency_setup() to support PNX8550
> which needs special handling on cache coherency updating.
> 
> Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>

Never been a fan of weak functions though depending circumstances they
certainly can be less evil than some of the alternatives.  Also what is
hidden deep in the PNX board code really is specific to the PNX CPU core,
so I moved it to c-r4k.c.  The resulting patch is below.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index 643c8bc..c41ea22 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -1226,6 +1226,28 @@ void au1x00_fixup_config_od(void)
 	}
 }
 
+/* CP0 hazard avoidance. */
+#define NXP_BARRIER()							\
+	 __asm__ __volatile__(						\
+	".set noreorder\n\t"						\
+	"nop; nop; nop; nop; nop; nop;\n\t"				\
+	".set reorder\n\t")
+
+static void nxp_pr4450_fixup_config(void)
+{
+	unsigned long config0;
+
+	config0 = read_c0_config();
+
+	/* clear all three cache coherency fields */
+	config0 &= ~(0x7 | (7 << 25) | (7 << 28));
+	config0 |= (((_page_cachable_default >> _CACHE_SHIFT) <<  0) |
+		    ((_page_cachable_default >> _CACHE_SHIFT) << 25) |
+		    ((_page_cachable_default >> _CACHE_SHIFT) << 28));
+	write_c0_config(config0);
+	NXP_BARRIER();
+}
+
 static int __cpuinitdata cca = -1;
 
 static int __init cca_setup(char *str)
@@ -1271,6 +1293,10 @@ static void __cpuinit coherency_setup(void)
 	case CPU_AU1500: /* rev. AB */
 		au1x00_fixup_config_od();
 		break;
+
+	case PRID_IMP_PR4450:
+		nxp_pr4450_fixup_config();
+		break;
 	}
 }
 
diff --git a/arch/mips/nxp/pnx8550/jbs/board_setup.c b/arch/mips/nxp/pnx8550/jbs/board_setup.c
index f92826e..57dd903 100644
--- a/arch/mips/nxp/pnx8550/jbs/board_setup.c
+++ b/arch/mips/nxp/pnx8550/jbs/board_setup.c
@@ -47,16 +47,7 @@
 
 void __init board_setup(void)
 {
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
-
-	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
-	write_c0_config(config0);
-	BARRIER;
+	unsigned long configpr;
 
 	configpr = read_c0_config7();
 	configpr |= (1<<19); /* enable tlb */
diff --git a/arch/mips/nxp/pnx8550/stb810/board_setup.c b/arch/mips/nxp/pnx8550/stb810/board_setup.c
index 1282c27..af2a55e 100644
--- a/arch/mips/nxp/pnx8550/stb810/board_setup.c
+++ b/arch/mips/nxp/pnx8550/stb810/board_setup.c
@@ -33,15 +33,7 @@
 
 void __init board_setup(void)
 {
-	unsigned long config0, configpr;
-
-	config0 = read_c0_config();
-
-	/* clear all three cache coherency fields */
-	config0 &= ~(0x7 | (7<<25) | (7<<28));
-	config0 |= (CONF_CM_DEFAULT | (CONF_CM_DEFAULT<<25) |
-			(CONF_CM_DEFAULT<<28));
-	write_c0_config(config0);
+	unsigned long configpr;
 
 	configpr = read_c0_config7();
 	configpr |= (1<<19); /* enable tlb */
