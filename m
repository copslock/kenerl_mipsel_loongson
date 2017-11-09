Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2017 12:03:43 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.244]:36420 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKILD3os8sx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Nov 2017 12:03:29 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx28.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 09 Nov 2017 11:03:15 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Thu, 9 Nov 2017 03:03:15 -0800
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Marc Zyngier <marc.zyngier@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        Jason Cooper <jason@lakedaemon.net>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] irqchip: mips-gic: Print warning if inherited GIC base is used
Date:   Thu, 9 Nov 2017 11:02:45 +0000
Message-ID: <1510225365-2584-2-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1510225365-2584-1-git-send-email-matt.redfearn@mips.com>
References: <1510225365-2584-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1510225395-637138-27153-971504-1
X-BESS-VER: 2017.12-r1710252241
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186750
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60798
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

If the physical address of the GIC resource cannot be read from device
tree, then the code falls back to reading it from the gcr_gic_base
register. Hopefully this has been set to a sane value by the bootloader
or some platform code, but is defined by the hardware manual to have
"undefined" reset state. Using it as the address at which the GIC will
be mapped into physical memory space can therefore be risky if it has
not been initialised, since it may result in the GIC being mapped to an
effectively random address anywhere in physical memory, where it might
conflict with peripherals or RAM and lead to weird crashes.

Since a "sane value" is very platform specific because it is particular
to the platform's memory map, it is difficult to test for. At the very
least, a warning message should be printed in the case that we trust the
inherited value.

Reported-by: Amit Kama <amit.kama@satixfy.com>
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
Reviewed-by: Paul Burton <paul.burton@mips.com>

---

 drivers/irqchip/irq-mips-gic.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9b768899f07b..ef92a4d2038e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -701,6 +701,8 @@ static int __init gic_of_init(struct device_node *node,
 			gic_base = read_gcr_gic_base() &
 				~CM_GCR_GIC_BASE_GICEN;
 			gic_len = 0x20000;
+			pr_warn("Using inherited base address %pa\n",
+				&gic_base);
 		} else {
 			pr_err("Failed to get memory range\n");
 			return -ENODEV;
-- 
2.7.4
