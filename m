Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:30:48 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:13755 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24162857AbYLUI0c (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:32 +0000
Received: (qmail 3984 invoked from network); 21 Dec 2008 09:25:00 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:25:00 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 13/14] Alchemy: dbdma suspend/resume support.
Date:	Sun, 21 Dec 2008 09:26:26 +0100
Message-Id: <502995eadd40552a890abdf15ee194807b190096.1229846415.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <b7b8752b8d9421eb381c93f945d6c0f53b2f74cd.1229846415.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
 <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
 <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
 <45ced0b4c4d707995c92fc9c56bb71e2d383b3f2.1229846414.git.mano@roarinelk.homelinux.net>
 <cc0520393daa157516ae4f2cc6a69bc7b60a2a39.1229846414.git.mano@roarinelk.homelinux.net>
 <a64458ed8315e19b979f72236e0b73ed5ab2891d.1229846414.git.mano@roarinelk.homelinux.net>
 <b7b8752b8d9421eb381c93f945d6c0f53b2f74cd.1229846415.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21647
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Implement suspend/resume for DBDMA controller and its channels.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/dbdma.c                 |   65 ++++++++++++++++++++++
 arch/mips/alchemy/common/power.c                 |   11 ++++
 arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h |    5 ++
 3 files changed, 81 insertions(+), 0 deletions(-)

diff --git a/arch/mips/alchemy/common/dbdma.c b/arch/mips/alchemy/common/dbdma.c
index 601ee91..3ab6d80 100644
--- a/arch/mips/alchemy/common/dbdma.c
+++ b/arch/mips/alchemy/common/dbdma.c
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
diff --git a/arch/mips/alchemy/common/power.c b/arch/mips/alchemy/common/power.c
index f08312b..f58e151 100644
--- a/arch/mips/alchemy/common/power.c
+++ b/arch/mips/alchemy/common/power.c
@@ -36,6 +36,9 @@
 
 #include <asm/uaccess.h>
 #include <asm/mach-au1x00/au1000.h>
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#endif
 
 #ifdef CONFIG_PM
 
@@ -156,6 +159,10 @@ static void save_core_regs(void)
 	sleep_static_memctlr[3][0] = au_readl(MEM_STCFG3);
 	sleep_static_memctlr[3][1] = au_readl(MEM_STTIME3);
 	sleep_static_memctlr[3][2] = au_readl(MEM_STADDR3);
+
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	au1xxx_dbdma_suspend();
+#endif
 }
 
 static void restore_core_regs(void)
@@ -221,6 +228,10 @@ static void restore_core_regs(void)
 	}
 
 	restore_au1xxx_intctl();
+
+#if defined(CONFIG_SOC_AU1550) || defined(CONFIG_SOC_AU1200)
+	au1xxx_dbdma_resume();
+#endif
 }
 
 unsigned long suspend_mode;
diff --git a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
index 44a67bf..06f68f4 100644
--- a/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
+++ b/arch/mips/include/asm/mach-au1x00/au1xxx_dbdma.h
@@ -357,6 +357,11 @@ u32 au1xxx_dbdma_put_dscr(u32 chanid, au1x_ddma_desc_t *dscr);
 u32 au1xxx_ddma_add_device(dbdev_tab_t *dev);
 extern void au1xxx_ddma_del_device(u32 devid);
 void *au1xxx_ddma_get_nextptr_virt(au1x_ddma_desc_t *dp);
+#ifdef CONFIG_PM
+void au1xxx_dbdma_suspend(void);
+void au1xxx_dbdma_resume(void);
+#endif
+
 
 /*
  * Some compatibilty macros -- needed to make changes to API
-- 
1.6.0.4
