Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Sep 2016 18:54:25 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:27730 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992310AbcIAQvwlzKb2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Sep 2016 18:51:52 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 84439C12D51BF;
        Thu,  1 Sep 2016 17:51:33 +0100 (IST)
Received: from zkakakhel-linux.le.imgtec.org (192.168.154.45) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 1 Sep 2016 17:51:36 +0100
From:   Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
To:     <monstr@monstr.eu>, <ralf@linux-mips.org>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <marc.zyngier@arm.com>
CC:     <soren.brinkmann@xilinx.com>, <Zubair.Kakakhel@imgtec.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <michal.simek@xilinx.com>, <netdev@vger.kernel.org>
Subject: [Patch v4 07/12] MIPS: xilfpga: Update DT node and specify uart irq
Date:   Thu, 1 Sep 2016 17:51:00 +0100
Message-ID: <1472748665-47774-8-git-send-email-Zubair.Kakakhel@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
References: <1472748665-47774-1-git-send-email-Zubair.Kakakhel@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.45]
Return-Path: <Zubair.Kakakhel@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54945
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Zubair.Kakakhel@imgtec.com
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

Update the DT node with the UART irq

Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>

---
V3 -> V4
No change

V2 -> V3
No change

V1 -> V2

No change
---
 arch/mips/boot/dts/xilfpga/nexys4ddr.dts | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
index 8db660b..d285c8d 100644
--- a/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
+++ b/arch/mips/boot/dts/xilfpga/nexys4ddr.dts
@@ -50,6 +50,9 @@
 		reg-offset = <0x1000>;
 
 		clocks	= <&ext>;
+
+		interrupt-parent = <&axi_intc>;
+		interrupts = <0>;
 	};
 };
 
-- 
1.9.1
