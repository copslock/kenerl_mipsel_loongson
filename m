Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Jun 2017 21:34:00 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:35750 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993975AbdFBTdLtL2Yn (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Jun 2017 21:33:11 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 8C52E3DCD7650;
        Fri,  2 Jun 2017 20:33:01 +0100 (IST)
Received: from localhost (10.20.1.33) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 2 Jun 2017 20:33:05
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>,
        stable <stable@vger.kernel.org>
Subject: [PATCH 9/9] MIPS: SEAD-3: Fix GIC interrupt specifiers
Date:   Fri, 2 Jun 2017 12:29:59 -0700
Message-ID: <20170602192959.25435-10-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.13.0
In-Reply-To: <20170602192959.25435-1-paul.burton@imgtec.com>
References: <20170602192959.25435-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.33]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58152
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

The various interrupt specifiers in the device tree are not in a valid
format for the MIPS GIC interrupt controller binding. Where each
interrupt should provide 3 values - GIC_LOCAL or GIC_SHARED, the
pin number & the type of interrupt - the device tree was only providing
the pin number. This causes interrupts for those devices to not be used
when a GIC is present. SEAD-3 systems without a GIC are unaffected since
the DT fixup code generates interrupt specifiers that are valid for the
CPU interrupt controller.

Fix this by adding the GIC_SHARED & IRQ_TYPE_LEVEL_HIGH values to each
interrupt specifier.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: c11e3b48dbc3 ("MIPS: SEAD3: Probe UARTs using DT")
Fixes: a34e93882de4 ("MIPS: SEAD3: Probe ethernet controller using DT")
Fixes: 7afd2a5aec2e ("MIPS: SEAD3: Probe EHCI controller using DT")
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: stable <stable@vger.kernel.org> # v4.9+

---

 arch/mips/boot/dts/mti/sead3.dts | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/boot/dts/mti/sead3.dts b/arch/mips/boot/dts/mti/sead3.dts
index cabe256f9a68..4f8bc83c2960 100644
--- a/arch/mips/boot/dts/mti/sead3.dts
+++ b/arch/mips/boot/dts/mti/sead3.dts
@@ -60,7 +60,7 @@
 		reg = <0x1b200000 0x1000>;
 
 		interrupt-parent = <&gic>;
-		interrupts = <0>; /* GIC 0 or CPU 6 */
+		interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>; /* GIC 0 or CPU 6 */
 
 		has-transaction-translator;
 	};
@@ -223,7 +223,7 @@
 		clock-frequency = <14745600>;
 
 		interrupt-parent = <&gic>;
-		interrupts = <3>; /* GIC 3 or CPU 4 */
+		interrupts = <GIC_SHARED 3 IRQ_TYPE_LEVEL_HIGH>; /* GIC 3 or CPU 4 */
 
 		no-loopback-test;
 	};
@@ -238,7 +238,7 @@
 		clock-frequency = <14745600>;
 
 		interrupt-parent = <&gic>;
-		interrupts = <2>; /* GIC 2 or CPU 4 */
+		interrupts = <GIC_SHARED 2 IRQ_TYPE_LEVEL_HIGH>; /* GIC 2 or CPU 4 */
 
 		no-loopback-test;
 	};
@@ -249,7 +249,7 @@
 		reg-io-width = <4>;
 
 		interrupt-parent = <&gic>;
-		interrupts = <0>; /* GIC 0 or CPU 6 */
+		interrupts = <GIC_SHARED 0 IRQ_TYPE_LEVEL_HIGH>; /* GIC 0 or CPU 6 */
 
 		phy-mode = "mii";
 		smsc,irq-push-pull;
-- 
2.13.0
