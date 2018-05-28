Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 May 2018 02:25:45 +0200 (CEST)
Received: from mail1.bemta8.messagelabs.com ([216.82.243.206]:41897 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeE1AZfmmW2l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 28 May 2018 02:25:35 +0200
Received: from [216.82.242.36] (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256 bits))
        by server-14.bemta-8.messagelabs.com id 12/44-07697-E7C4B0B5; Mon, 28 May 2018 00:25:34 +0000
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrNLMWRWlGSWpSXmKPExsUyLfyHiG6dD3e
  0wfoHuhYTpk5id2D0OLpyLVMAYxRrZl5SfkUCa0b7ouesBf9EKy7/CWlgXCjUxcjFISQwl1Gi
  bdtJJgjnF6PEvsn97F2MnBxsAqYS018tZASxRQSUJR782skIUsQscIZR4lHTbhaQhLBAssSdz
  VvBbBYBVYmdvR1gNq+Ag8SCT+fZQGwJAXmJw2+aWEFsTgFHiUVfroEtEAKqWTd7E5StKfG85z
  sjRH2wxKy21SwTGHkXMDKsYtQoTi0qSy3SNTTVSyrKTM8oyU3MzNE1NLDQy00tLk5MT81JTCr
  WS87P3cQIDIh6BgbGHYwHnrsfYpTkYFIS5bWYyBEtxJeUn1KZkVicEV9UmpNafIhRhoNDSYL3
  jRd3tJBgUWp6akVaZg4wNGHSEhw8SiK8v0HSvMUFibnFmekQqVOMuhx32np6mIVY8vLzUqXEe
  T+BFAmAFGWU5sGNgMXJJUZZKWFeRgYGBiGegtSi3MwSVPlXjOIcjErCvHu8gabwZOaVwG16BX
  QEE9AR61azgxxRkoiQkmpgXLrQyTLn8oT8iNurwlO3aBUtndMhrHpdz3l7m9HrO6Er2xsni+t
  2uHAFNjH0THybvvZHl33EyQtntJNdlwZfNjpStFL+6IF+yf2/ow3lLtY2RUy4d06irGp3xEnF
  n4qfTkx9mr7v66ld5ieDb3y7atJln7a6VM83+XzJevGyzp7EvsmXX6eqKLEUZyQaajEXFScCA
  FvdOMmOAgAA
X-Env-Sender: ikegami@allied-telesis.co.jp
X-Msg-Ref: server-10.tower-94.messagelabs.com!1527467133!179692171!1
X-Originating-IP: [150.87.248.20]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
Received: (qmail 141787 invoked from network); 28 May 2018 00:25:34 -0000
Received: from abricot-inet.allied-telesis.co.jp (HELO TKY-DS01.at.lc) (150.87.248.20)
  by server-10.tower-94.messagelabs.com with SMTP; 28 May 2018 00:25:34 -0000
Received: from swim-manx.rd.allied-telesis.co.jp ([150.87.21.50]) by TKY-DS01.at.lc with Microsoft SMTPSVC(8.0.9200.16384);
         Mon, 28 May 2018 09:25:33 +0900
Received: from ikegami-pc.rd.allied-telesis.co.jp by swim-manx.rd.allied-telesis.co.jp
 (AlliedTelesis SMTPRS 1.3 pl 1 ++E6B86F8C687C6288D9B5559052954DC9) with ESMTP id <B0004118815@swim-manx.rd.allied-telesis.co.jp>;
 Mon, 28 May 2018 09:25:32 +0900
From:   Tokunori Ikegami <ikegami@allied-telesis.co.jp>
To:     James Hogan <jhogan@kernel.org>
Cc:     Tokunori Ikegami <ikegami@allied-telesis.co.jp>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Rafa~B Mi~Becki <zajec5@gmail.com>, linux-mips@linux-mips.org
Subject: [PATCH v2 1/1] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX PCIe erratum
Date:   Mon, 28 May 2018 09:24:51 +0900
Message-Id: <20180528002451.2622-2-ikegami@allied-telesis.co.jp>
X-Mailer: git-send-email 2.16.1
In-Reply-To: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
References: <20180528002451.2622-1-ikegami@allied-telesis.co.jp>
X-OriginalArrivalTime: 28 May 2018 00:25:33.0457 (UTC) FILETIME=[6433B810:01D3F61A]
Return-Path: <ikegami@allied-telesis.co.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64078
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
Cc: Rafa~B Mi~Becki <zajec5@gmail.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h |  3 +++
 arch/mips/kernel/cpu-probe.c     | 12 +++++++++++-
 2 files changed, 14 insertions(+), 1 deletion(-)

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
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index cf3fd549e16d..75039e89694f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -427,8 +427,18 @@ static inline void check_errata(void)
 		 * making use of VPE1 will be responsable for that VPE.
 		 */
 		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
-			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
+			set_c0_config7(MIPS_CONF7_RPS);
 		break;
+#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
+	case CPU_74K:
+		/*
+		 * BCM47XX Erratum "R10: PCIe Transactions Periodically Fail"
+		 * Enable ExternalSync for sync instruction to take effect
+		 */
+		pr_info("ExternalSync has been enabled\n");
+		set_c0_config7(MIPS_CONF7_ES);
+		break;
+#endif
 	default:
 		break;
 	}
-- 
2.16.1
