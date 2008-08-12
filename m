Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Aug 2008 18:46:16 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:31617 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S28591436AbYHLRm4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 12 Aug 2008 18:42:56 +0100
Received: (qmail 9129 invoked from network); 12 Aug 2008 19:42:53 +0200
Received: from flagship.roarinelk.net (HELO localhost.localdomain) (192.168.0.197)
  by 192.168.0.1 with SMTP; 12 Aug 2008 19:42:53 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	Kevin Hickey <khickey@rmicorp.com>,
	Linux-MIPS <linux-mips@linux-mips.org>,
	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 09/10] Alchemy: dbdma suspend/resume support.
Date:	Tue, 12 Aug 2008 19:42:50 +0200
Message-Id: <46ed1e347f8a291f4d48762f12e19f6ac96b7963.1218561746.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <cover.1218561745.git.mano@roarinelk.homelinux.net>
References: <cover.1218561745.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1218561745.git.mano@roarinelk.homelinux.net>
References: <cover.1218561745.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Implement suspend/resume for DBDMA controller and its channels.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/au1000/common/dbdma.c |   65 +++++++++++++++++++++++++++++++++++++++
 arch/mips/au1000/common/power.c |   12 +++++++
 2 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/arch/mips/au1000/common/dbdma.c b/arch/mips/au1000/common/dbdma.c
index 601ee91..3ab6d80 100644
--- a/arch/mips/au1000/common/dbdma.c
+++ b/arch/mips/au1000/common/dbdma.c
@@ -174,6 +174,11 @@ static dbdev_tab_t dbdev_tab[] = {
 
 #define DBDEV_TAB_SIZE	ARRAY_SIZE(dbdev_tab)
 
+#ifdef CONFIG_PM
+static u32 au1xxx_dbdma_pm_regs[NUM_DBDMA_CHANS + 1][8];
+#endif
+
+
 static chan_tab_t *chan_tab_ptr[NUM_DBDMA_CHANS];
 
 static dbdev_tab_t *find_dbdev_id(u32 id)
@@ -975,4 +980,64 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr)
 	return nbytes;
 }
 
+#ifdef CONFIG_PM
+void au1xxx_dbdma_suspend(void)
+{
+	int i;
+	u32 addr;
+
+	addr = DDMA_GLOBAL_BASE;
+	au1xxx_dbdma_pm_regs[0][0] = au_readl(addr + 0x00);
+	au1xxx_dbdma_pm_regs[0][1] = au_readl(addr + 0x04);
+	au1xxx_dbdma_pm_regs[0][2] = au_readl(addr + 0x08);
+	au1xxx_dbdma_pm_regs[0][3] = au_readl(addr + 0x0c);
+
+	/* save channel configurations */
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+		au1xxx_dbdma_pm_regs[i][0] = au_readl(addr + 0x00);
+		au1xxx_dbdma_pm_regs[i][1] = au_readl(addr + 0x04);
+		au1xxx_dbdma_pm_regs[i][2] = au_readl(addr + 0x08);
+		au1xxx_dbdma_pm_regs[i][3] = au_readl(addr + 0x0c);
+		au1xxx_dbdma_pm_regs[i][4] = au_readl(addr + 0x10);
+		au1xxx_dbdma_pm_regs[i][5] = au_readl(addr + 0x14);
+		au1xxx_dbdma_pm_regs[i][6] = au_readl(addr + 0x18);
+
+		/* halt channel */
+		au_writel(au1xxx_dbdma_pm_regs[i][0] & ~1, addr + 0x00);
+		au_sync();
+		while (!(au_readl(addr + 0x14) & 1))
+			au_sync();
+
+		addr += 0x100;	/* next channel base */
+	}
+	/* disable channel interrupts */
+	au_writel(0, DDMA_GLOBAL_BASE + 0x0c);
+	au_sync();
+}
+
+void au1xxx_dbdma_resume(void)
+{
+	int i;
+	u32 addr;
+
+	addr = DDMA_GLOBAL_BASE;
+	au_writel(au1xxx_dbdma_pm_regs[0][0], addr + 0x00);
+	au_writel(au1xxx_dbdma_pm_regs[0][1], addr + 0x04);
+	au_writel(au1xxx_dbdma_pm_regs[0][2], addr + 0x08);
+	au_writel(au1xxx_dbdma_pm_regs[0][3], addr + 0x0c);
+
+	/* restore channel configurations */
+	for (i = 1, addr = DDMA_CHANNEL_BASE; i < NUM_DBDMA_CHANS; i++) {
+		au_writel(au1xxx_dbdma_pm_regs[i][0], addr + 0x00);
+		au_writel(au1xxx_dbdma_pm_regs[i][1], addr + 0x04);
+		au_writel(au1xxx_dbdma_pm_regs[i][2], addr + 0x08);
+		au_writel(au1xxx_dbdma_pm_regs[i][3], addr + 0x0c);
+		au_writel(au1xxx_dbdma_pm_regs[i][4], addr + 0x10);
+		au_writel(au1xxx_dbdma_pm_regs[i][5], addr + 0x14);
+		au_writel(au1xxx_dbdma_pm_regs[i][6], addr + 0x18);
+		au_sync();
+		addr += 0x100;	/* next channel base */
+	}
+}
+#endif	/* CONFIG_PM */
 #endif /* defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200) */
diff --git a/arch/mips/au1000/common/power.c b/arch/mips/au1000/common/power.c
index ba4c946..1057a73 100644
--- a/arch/mips/au1000/common/power.c
+++ b/arch/mips/au1000/common/power.c
@@ -33,6 +33,10 @@
 extern void save_and_sleep(void);
 extern void save_au1xxx_intctl(void);
 extern void restore_au1xxx_intctl(void);
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+extern void au1xxx_dbdma_suspend(void);
+extern void au1xxx_dbdma_resume(void);
+#endif
 
 /*
  * We need to save/restore a bunch of core registers that are
@@ -120,6 +124,10 @@ static void save_core_regs(void)
 	sleep_static_memctlr[3][0] = au_readl(MEM_STCFG3);
 	sleep_static_memctlr[3][1] = au_readl(MEM_STTIME3);
 	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
+
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	au1xxx_dbdma_suspend();
+#endif
 }
 
 static void restore_core_regs(void)
@@ -185,6 +193,10 @@ static void restore_core_regs(void)
 	}
 
 	restore_au1xxx_intctl();
+
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	au1xxx_dbdma_resume();
+#endif
 }
 
 void au_sleep(void)
-- 
1.5.6.4
