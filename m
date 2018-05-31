Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jun 2018 00:19:46 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.196]:17425 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994689AbeEaWTjepibJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Jun 2018 00:19:39 +0200
Received: from [216.82.242.46] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-4.bemta-8.messagelabs.com id BA/C2-13997-AF4701B5; Thu, 31 May 2018 22:19:38 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrAIsWRWlGSWpSXmKPExsUyLfyHiO6vEoF
  og9O7BS0mTJ3E7sDocXTlWqYAxijWzLyk/IoE1oz1K2cxF+wXq+iatoS9gfGyUBcjJ4eQwBxG
  iX3/iroYuYDsn4wSj15NZQdJsAmYSkx/tZARxBYRUJZ48GsnI0gRs8AjRol5jT/AioQFkiW2r
  f7IDGKzCKhKXNh8BszmFXCQmHq1F6xGQkBe4vCbJlYQm1PAUaJ913UWiM0OEqtOP2CCqBeUOD
  nzCVCcA2iBusT6eWDHMQO1Nm+dzQxRrinxvOc7I8TIYIldT+cxTmAUmIWkexZC9ywk3QsYmVc
  xqhenFpWlFuma6SUVZaZnlOQmZuboGhpY6OWmFhcnpqfmJCYV6yXn525iBIYmAxDsYPzU73yI
  UZKDSUmUd7KcQLQQX1J+SmVGYnFGfFFpTmrxIUYZDg4lCd69xUA5waLU9NSKtMwcYJTApCU4e
  JREeGVB0rzFBYm5xZnpEKlTjLocd9p6epiFWPLy81KlxHnPgRQJgBRllObBjYBF7CVGWSlhXk
  ago4R4ClKLcjNLUOVfMYpzMCoJ82aCTOHJzCuB2/QK6AgmoCNey4IdUZKIkJJqYEz/rjY3/Vd
  GRahW3/ypNgqLVj+ojnZ46hCjHHbJpj/iQW/vtx5Bk5MLg8unbTQR6pVfs/CEdPETDjfmipXz
  21IPhqzN38vbtipA95TS0b2/3vZO23cssDth+23lKra41T8qr3uuXSzRZcnOXJERr3sp4Kzz1
  SnhU6+fDU86JBZvOrGsUUlOSomlOCPRUIu5qDgRAI/JHK/TAgAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-7.tower-96.messagelabs.com!1527805177!89065171!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 28789 invoked from network); 31 May 2018 22:19:38 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-7.tower-96.messagelabs.com with SMTP; 31 May 2018 22:19:38 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Fri, 1 Jun 2018 07:19:37 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004126747@swim-manx.rd.allied-telesis.co.jp>;
 Fri, 1 Jun 2018 07:19:36 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org
Subject: [PATCH v4 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe erratum
Date:   Fri,  1 Jun 2018 07:19:11 +0900
Message-Id: <20180531221911.6210-2-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180531221911.6210-1-ikegami@allied-telesis.co.jp>
References: <20180531221911.6210-1-ikegami@allied-telesis.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 May 2018 22:19:37.0047 (UTC) FILETIME=[75E20E70:01D3F92D]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64141
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc: Hauke Mehrtens <hauke@hauke-m.de>
Cc: Rafał Miłecki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
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
