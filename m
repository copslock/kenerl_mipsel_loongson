Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Oct 2017 15:28:57 +0200 (CEST)
Received: from 20pmail.ess.barracuda.com ([64.235.150.246]:59413 "EHLO
        20pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990858AbdJQN2rTq1b3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Oct 2017 15:28:47 +0200
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx4.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Tue, 17 Oct 2017 13:28:33 +0000
Received: from mredfearn-linux.mipstec.com (10.150.130.83) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Tue, 17 Oct 2017 06:28:11 -0700
From:   Matt Redfearn <matt.redfearn@mips.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        Matt Redfearn <matt.redfearn@mips.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH] MIPS: Boston: Fix earlycon baud rate selection
Date:   Tue, 17 Oct 2017 14:27:59 +0100
Message-ID: <1508246879-20580-1-git-send-email-matt.redfearn@mips.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1508246913-298555-12576-184359-1
X-BESS-VER: 2017.12-r1710102214
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186054
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
X-archive-position: 60427
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

During set up of the early console, the earlycon driver will attempt to
configure a baud rate, if one is set in the earlycon structure.
Previously, of_setup_earlycon left this field as 0, ignoring any baud
rate selected by the DT. Commit 31cb9a8575ca ("earlycon: initialise baud
field of earlycon device structure") changed this behaviour such that
any selected baud rate is now set. The earlycon driver must deduce the
divisor from the configured uartclk, which of_setup_earlycon sets to
BASE_BAUD. MIPS generic kernels do not set BASE_BAUD (there is no
practical way to set this generically for all supported platforms), so
when the early console is configured an incorrect divisor is calculated
for the selected baud rate, and garbage is printed to the console during
boot.

Fix this by removing the configured baud rate from the device tree.
This causes the early console to inherit the baud rate settings from the
bootloader. By the time the real console is probed, the clock drivers
necessary to calculate the divisor are enabled and the kernel can
correctly configure the baud rate.

Fixes: 31cb9a8575ca ("earlycon: initialise baud field of earlycon device structure")
Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

---

 arch/mips/boot/dts/img/boston.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/img/boston.dts b/arch/mips/boot/dts/img/boston.dts
index 53bfa29a7093..179691aae7d7 100644
--- a/arch/mips/boot/dts/img/boston.dts
+++ b/arch/mips/boot/dts/img/boston.dts
@@ -11,7 +11,7 @@
 	compatible = "img,boston";
 
 	chosen {
-		stdout-path = "uart0:115200";
+		stdout-path = "uart0";
 	};
 
 	aliases {
-- 
2.7.4
