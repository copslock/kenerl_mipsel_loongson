Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 03:04:23 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.198]:24750 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994676AbeEaBEC6etet (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2018 03:04:02 +0200
Received: from [216.82.242.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-6.bemta-8.messagelabs.com id 70/72-28268-10A4F0B5; Thu, 31 May 2018 01:04:01 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsUyLfyHiC6jF3+
  0wYkudYsJUyexOzB6HF25limAMYo1My8pvyKBNWPZlhWsBV9FK+btfcfcwDhFqIuRk0NIYC6j
  xKnvfl2MXED2L0aJ/59XsYEk2ARMJaa/WsgIYosIKEs8+LWTEaSIWeARo8S8xh/sIAlhgWSJR
  0tuM4PYLAKqEn1TL7GA2LwCjhJvps0BGyQhIC9x+E0TK4jNKeAkMXPvP3aIzY4SrXf/MUPUC0
  qcnPkEqJcDaIG6xPp5YMcxA7U2b53NDFGuKfG85zsjSImEQLDEz9uhExgFZiFpnoXQPAtJ8wJ
  G5lWMGsWpRWWpRbpGhnpJRZnpGSW5iZk5uoYGFnq5qcXFiempOYlJxXrJ+bmbGIGhWc/AwLiD
  ced590OMkhxMSqK8l6v5ooX4kvJTKjMSizPii0pzUosPMcpwcChJ8P7z4I8WEixKTU+tSMvMA
  UYJTFqCg0dJhJfTEyjNW1yQmFucmQ6ROsWoy3GnraeHWYglLz8vVUqc9xDIDAGQoozSPLgRsI
  i9xCgrJczLyMDAIMRTkFqUm1mCKv+KUZyDUUmYlxdkFU9mXgncpldARzABHfFkIjfIESWJCCm
  pBkZuQcc/AqY7pcy77mt/vFKxc16EEkvq67eXWxrm87HN/vt5okdFvEHVrEtemz1qLj5zXD3T
  KWETv9nFF90yV38cmLc0b4njzQVrZgveVm/p1gitzvp+MWpZ6aWzcgLSUo6dra/XCW+9Wlc8s
  VgzO5ZVdYbXZa2l0Su3Hr81NyZFWnjlln8X2oSUWIozEg21mIuKEwHobRUG0wIAAA==
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-14.tower-96.messagelabs.com!1527728640!104873142!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 5845 invoked from network); 31 May 2018 01:04:01 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-14.tower-96.messagelabs.com with SMTP; 31 May 2018 01:04:01 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Thu, 31 May 2018 10:03:59 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004125306@swim-manx.rd.allied-telesis.co.jp>;
 Thu, 31 May 2018 10:03:59 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v3 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe erratum
Date:   Thu, 31 May 2018 10:02:40 +0900
Message-Id: <20180531010240.16991-2-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180531010240.16991-1-ikegami@allied-telesis.co.jp>
References: <20180531010240.16991-1-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2018 01:03:59.0946 (UTC) FILETIME=[423742A0:01D3F87B]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64131
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
Changes since v2:
- Move the change into platform-specific code bcm47xx_cpu_fixes() function from in generic code.

Changes since v1 resent:
- None.

Changes since v1 original:
- Change to use set_c0_config7 instead of write_c0_config7.

 arch/mips/bcm47xx/setup.c        | 7 +++++++
 arch/mips/include/asm/mipsregs.h | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
index 6054d49e608e..8fec219e1160 100644
--- a/arch/mips/bcm47xx/setup.c
+++ b/arch/mips/bcm47xx/setup.c
@@ -212,6 +212,13 @@ static int __init bcm47xx_cpu_fixes(void)
 		 */
 		if (bcm47xx_bus.bcma.bus.chipinfo.id == BCMA_CHIP_ID_BCM4706)
 			cpu_wait = NULL;
+
+		/*
+		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
+		 * Enable ExternalSync for sync instruction to take effect
+		 */
+		pr_info("ExternalSync has been enabled\n");
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
