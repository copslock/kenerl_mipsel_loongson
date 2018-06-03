Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Jun 2018 16:02:52 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:47438 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992851AbeFCOCabLBzM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Jun 2018 16:02:30 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta-8.messagelabs.com id 06/C7-28268-5F4F31B5; Sun, 03 Jun 2018 14:02:29 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrEIsWRWlGSWpSXmKPExsUyLfyHiO7XL8L
  RBr3HJSwmTJ3E7sDocXTlWqYAxijWzLyk/IoE1owjL/YxFXSKV/xoPMzcwDhBuIuRi0NIYA6j
  xJQX31khnJ+MEguvb2HrYuTkYBMwlZj+aiEjiC0ioCzx4NdORpAiZoF9jBJfW1eygiSEBZIlv
  h6+A2azCKhKTH3fzAxi8wo4SnRfO84OYksIyEscftMEVsMp4CTR2TwXbKgQUM2mlqNsEPWCEi
  dnPmHpYuQAWqAusX6eEEiYGai1eetsZohyTYnnPd8ZIUYGSxxtO8A6gVFgFpLuWQjds5B0L2B
  kXsWoUZxaVJZapGtsqpdUlJmeUZKbmJmja2hgoZebWlycmJ6ak5hUrJecn7uJERie9QwMjDsY
  3y6LPsQoycGkJMr7qkI4WogvKT+lMiOxOCO+qDQntfgQowwHh5IE78fPQDnBotT01Iq0zBxgp
  MCkJTh4lER4uYHRIsRbXJCYW5yZDpE6xajLcaetp4dZiCUvPy9VSpxXAqRIAKQoozQPbgQsai
  8xykoJ8zIyMDAI8RSkFuVmlqDKv2IU52BUEubVAJnCk5lXArfpFdARTEBHPKsAO6IkESEl1cC
  4qGt12joNCzW+GafPvfcOV9dyWDFr+v+G2rub2BxPvxH7olsj977Ht832lvG3qbqtfpu7rkte
  2tMcs/1/q2fPA6FVdtypf+e2+sZead4QvSfIJWzvqYdb3YxmlE5ats/n8rXa2VP3PF11b/8T/
  Yg4SavvZS9ZGKaZ5Vrw+wi+mhons3zGzgA2JZbijERDLeai4kQAE8vsPdUCAAA=
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-8.tower-94.messagelabs.com!1528034548!189748387!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 13093 invoked from network); 3 Jun 2018 14:02:29 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-8.tower-94.messagelabs.com with SMTP; 3 Jun 2018 14:02:29 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Sun, 3 Jun 2018 23:02:28 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004128336@swim-manx.rd.allied-telesis.co.jp>;
 Sun, 3 Jun 2018 23:02:27 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v5 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe erratum
Date:   Sun,  3 Jun 2018 23:02:01 +0900
Message-Id: <20180603140201.10593-2-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180603140201.10593-1-ikegami@allied-telesis.co.jp>
References: <20180603140201.10593-1-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 03 Jun 2018 14:02:28.0250 (UTC) FILETIME=[81C617A0:01D3FB43]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64164
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ikegami@allied-telesis.co.jp
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

The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as below.

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
Also the dummy PCIe configuration read is already implemented in the Linux
BCMA driver.
Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
too so that the sync instruction is externalised.

Signed-off-by: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
Reviewed-by: Paul Burton <paul.burton@mips.com>
Acked-by: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
Changes since v4:
- Change Cc: Hauke Mehrtens tag as Acked-by tag.

Changes since v3:
- Add Reviewed-by: Paul Burton tag.
- Remove pr_info().

Changes since v2:
- Move the change into platform-specific code bcm47xx_cpu_fixes() function from in generic code.

Changes since v1 resent:
- None.

Changes since v1 original:
- Change to use set_c0_config7 instead of write_c0_config7.

 arch/mips/bcm47xx/setup.c        | 6 ++++++
 arch/mips/include/asm/mipsregs.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 6054d49e608e..8c9cbf13d32a 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -212,6 +212,12 @@ static int __init bcm47xx_cpu_fixes(void)
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
diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 858752dac337..0f94acf60144 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -680,6 +680,8 @@
 #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
 
 #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
+/* ExternalSync */
+#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)
 
 #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
 #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
@@ -2759,6 +2761,7 @@ __BUILD_SET_C0(status)
 __BUILD_SET_C0(cause)
 __BUILD_SET_C0(config)
 __BUILD_SET_C0(config5)
+__BUILD_SET_C0(config7)
 __BUILD_SET_C0(intcontrol)
 __BUILD_SET_C0(intctl)
 __BUILD_SET_C0(srsmap)
-- 
2.16.1
