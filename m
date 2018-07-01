Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 01 Jul 2018 18:34:39 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:54342 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993890AbeGAQeZ1GLlh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 1 Jul 2018 18:34:25 +0200
Received: from localhost (LFbn-1-12247-202.w90-92.abo.wanadoo.fr [90.92.61.202])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D864592B;
        Sun,  1 Jul 2018 16:34:18 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Paul Burton <paul.burton@mips.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, James Hogan <jhogan@kernel.org>
Subject: [PATCH 4.14 077/157] MIPS: BCM47XX: Enable 74K Core ExternalSync for PCIe erratum
Date:   Sun,  1 Jul 2018 18:22:29 +0200
Message-Id: <20180701160856.452978800@linuxfoundation.org>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20180701160852.287307684@linuxfoundation.org>
References: <20180701160852.287307684@linuxfoundation.org>
User-Agent: quilt/0.65
X-stable: review
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64531
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>

commit 2a027b47dba6b77ab8c8e47b589ae9bbc5ac6175 upstream.

The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as
below.

  R10: PCIe Transactions Periodically Fail

    Description: The BCM5300X PCIe does not maintain transaction ordering.
                 This may cause PCIe transaction failure.
    Fix Comment: Add a dummy PCIe configuration read after a PCIe
                 configuration write to ensure PCIe configuration access
                 ordering. Set ES bit of CP0 configu7 register to enable
                 sync function so that the sync instruction is functional.
    Resolution:  hndpci.c: extpci_write_config()
                 hndmips.c: si_mips_init()
                 mipsinc.h CONF7_ES

This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
Also the dummy PCIe configuration read is already implemented in the
Linux BCMA driver.

Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
too so that the sync instruction is externalised.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: stable@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/19461/
Signed-off-by: James Hogan <jhogan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/bcm47xx/setup.c        |    6 ++++++
 arch/mips/include/asm/mipsregs.h |    3 +++
 2 files changed, 9 insertions(+)

--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -212,6 +212,12 @@ static int __init bcm47xx_cpu_fixes(void
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
+
+		/*
+		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
+		 * Enable ExternalSync for sync instruction to take effect
+		 */
+		set_c0_config7(MIPS_CONF7_ES);
 		break;
 #endif
 	}
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -680,6 +680,8 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+/* ExternalSync */
+#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2745,6 +2747,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
