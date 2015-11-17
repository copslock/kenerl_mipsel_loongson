Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Nov 2015 19:22:02 +0100 (CET)
Received: from smtpfb2-g21.free.fr ([212.27.42.10]:42896 "EHLO
        smtpfb2-g21.free.fr" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008884AbbKRSWAjH-YA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Nov 2015 19:22:00 +0100
Received: from smtp3-g21.free.fr (smtp3-g21.free.fr [212.27.42.3])
        by smtpfb2-g21.free.fr (Postfix) with ESMTP id 7CE28DAC954;
        Tue, 17 Nov 2015 20:35:32 +0100 (CET)
Received: from localhost.localdomain (unknown [80.171.215.189])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id DBEFAA626A;
        Tue, 17 Nov 2015 20:35:14 +0100 (CET)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Alexander Couzens <lynxis@fe80.eu>,
        Joel Porquet <joel@porquet.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        linux-kernel@vger.kernel.org, Alban Bedel <albeu@free.fr>
Subject: [PATCH 1/6] MIPS: ath79: Fix the size of the MISC INTC registers in ar9132.dtsi
Date:   Tue, 17 Nov 2015 20:34:51 +0100
Message-Id: <1447788896-15553-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1447788896-15553-1-git-send-email-albeu@free.fr>
References: <1447788896-15553-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49982
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: albeu@free.fr
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

There is 2 registers that is 8 bytes long, not 4.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/boot/dts/qca/ar9132.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 857ca48..3ad4ba9 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -107,7 +107,7 @@
 			miscintc: interrupt-controller@18060010 {
 				compatible = "qca,ar9132-misc-intc",
 					   "qca,ar7100-misc-intc";
-				reg = <0x18060010 0x4>;
+				reg = <0x18060010 0x8>;
 
 				interrupt-parent = <&cpuintc>;
 				interrupts = <6>;
-- 
2.0.0
