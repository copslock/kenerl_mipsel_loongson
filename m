Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Oct 2014 07:41:49 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52027 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010704AbaJGFb6WZ0jI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Oct 2014 07:31:58 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From; bh=r1JERAHyRBPP2V/wXru289tjdBV8FdeBQJF4B3ptb94=;
        b=RX0NVgqWKchWiv1LIdCefRdQZkIiGo4GyoUUkUXnq6ozQ6dXWsBZBimXY2wHUzXsxSL2AoiWkXNcPdAqMUMuOrPrexdlIJnhIHKbzUjIU9Vcuu90bxkRhhvsCcXbrctsXRF7jNCFoKIoH5oBERpfx2kM8lQz4nmYXCGuszrB/UA=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNNF-002nrT-El
        for linux-mips@linux-mips.org; Tue, 07 Oct 2014 05:31:49 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:32940 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1XbNLv-002fMC-Kq; Tue, 07 Oct 2014 05:30:28 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     linux-kernel@vger.kernel.org
Cc:     adi-buildroot-devel@lists.sourceforge.net,
        devel@driverdev.osuosl.org, devicetree@vger.kernel.org,
        lguest@lists.ozlabs.org, linux-acpi@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-am33-list@redhat.com,
        linux-cris-kernel@axis.com, linux-efi@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-m32r-ja@ml.linux-m32r.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        linux-tegra@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        openipmi-developer@lists.sourceforge.net,
        user-mode-linux-devel@lists.sourceforge.net,
        linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-sh@vger.kernel.org, xen-devel@lists.xenproject.org,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 37/44] sh: Register with kernel poweroff handler
Date:   Mon,  6 Oct 2014 22:28:39 -0700
Message-Id: <1412659726-29957-38-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
References: <1412659726-29957-1-git-send-email-linux@roeck-us.net>
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=2.8
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.54337AC5.00BF,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.000
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: 
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 1317
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 170
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Register with kernel poweroff handler instead of setting pm_power_off
directly.

Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/sh/boards/board-sh7785lcr.c       | 2 +-
 arch/sh/boards/board-urquell.c         | 2 +-
 arch/sh/boards/mach-highlander/setup.c | 2 +-
 arch/sh/boards/mach-landisk/setup.c    | 2 +-
 arch/sh/boards/mach-r2d/setup.c        | 2 +-
 arch/sh/boards/mach-sdk7786/setup.c    | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/sh/boards/board-sh7785lcr.c b/arch/sh/boards/board-sh7785lcr.c
index 2c4771e..c092402 100644
--- a/arch/sh/boards/board-sh7785lcr.c
+++ b/arch/sh/boards/board-sh7785lcr.c
@@ -332,7 +332,7 @@ static void __init sh7785lcr_setup(char **cmdline_p)
 
 	printk(KERN_INFO "Renesas Technology Corp. R0P7785LC0011RL support.\n");
 
-	pm_power_off = sh7785lcr_power_off;
+	register_poweroff_handler_simple(sh7785lcr_power_off, 128);
 
 	/* sm501 DRAM configuration */
 	sm501_reg = ioremap_nocache(SM107_REG_ADDR, SM501_DRAM_CONTROL);
diff --git a/arch/sh/boards/board-urquell.c b/arch/sh/boards/board-urquell.c
index b52abcc..b3fa56f 100644
--- a/arch/sh/boards/board-urquell.c
+++ b/arch/sh/boards/board-urquell.c
@@ -204,7 +204,7 @@ static void __init urquell_setup(char **cmdline_p)
 {
 	printk(KERN_INFO "Renesas Technology Corp. Urquell support.\n");
 
-	pm_power_off = urquell_power_off;
+	register_poweroff_handler_simple(urquell_power_off, 128);
 
 	register_smp_ops(&shx3_smp_ops);
 }
diff --git a/arch/sh/boards/mach-highlander/setup.c b/arch/sh/boards/mach-highlander/setup.c
index 4a52590..998f1a5 100644
--- a/arch/sh/boards/mach-highlander/setup.c
+++ b/arch/sh/boards/mach-highlander/setup.c
@@ -385,7 +385,7 @@ static void __init highlander_setup(char **cmdline_p)
 
 	__raw_writew(__raw_readw(PA_IVDRCTL) | 0x01, PA_IVDRCTL);	/* Si13112 */
 
-	pm_power_off = r7780rp_power_off;
+	register_poweroff_handler_simple(r7780rp_power_off, 128);
 }
 
 static unsigned char irl2irq[HL_NR_IRL];
diff --git a/arch/sh/boards/mach-landisk/setup.c b/arch/sh/boards/mach-landisk/setup.c
index f1147ca..c817d80 100644
--- a/arch/sh/boards/mach-landisk/setup.c
+++ b/arch/sh/boards/mach-landisk/setup.c
@@ -89,7 +89,7 @@ static void __init landisk_setup(char **cmdline_p)
 	__raw_writeb(__raw_readb(PA_LED) | 0x03, PA_LED);
 
 	printk(KERN_INFO "I-O DATA DEVICE, INC. \"LANDISK Series\" support.\n");
-	pm_power_off = landisk_power_off;
+	register_poweroff_handler_simple(landisk_power_off, 128);
 }
 
 /*
diff --git a/arch/sh/boards/mach-r2d/setup.c b/arch/sh/boards/mach-r2d/setup.c
index 4b98a52..a759d39 100644
--- a/arch/sh/boards/mach-r2d/setup.c
+++ b/arch/sh/boards/mach-r2d/setup.c
@@ -279,7 +279,7 @@ static void __init rts7751r2d_setup(char **cmdline_p)
 					(ver >> 4) & 0xf, ver & 0xf);
 
 	__raw_writew(0x0000, PA_OUTPORT);
-	pm_power_off = rts7751r2d_power_off;
+	register_poweroff_handler_simple(rts7751r2d_power_off, 128);
 
 	/* sm501 dram configuration:
 	 * ColSizeX = 11 - External Memory Column Size: 256 words.
diff --git a/arch/sh/boards/mach-sdk7786/setup.c b/arch/sh/boards/mach-sdk7786/setup.c
index c29268b..cb26336 100644
--- a/arch/sh/boards/mach-sdk7786/setup.c
+++ b/arch/sh/boards/mach-sdk7786/setup.c
@@ -252,7 +252,7 @@ static void __init sdk7786_setup(char **cmdline_p)
 	pr_info("\tPCB revision:\t%d\n", fpga_read_reg(PCBRR) & 0xf);
 
 	machine_ops.restart = sdk7786_restart;
-	pm_power_off = sdk7786_power_off;
+	register_poweroff_handler_simple(sdk7786_power_off, 128);
 
 	register_smp_ops(&shx3_smp_ops);
 }
-- 
1.9.1
