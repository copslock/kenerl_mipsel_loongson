Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 19:25:34 +0200 (CEST)
Received: from smtp3-g21.free.fr ([212.27.42.3]:36668 "EHLO smtp3-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012157AbbHCRZ1J4wJa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 19:25:27 +0200
Received: from localhost.localdomain (unknown [176.4.89.174])
        (Authenticated sender: albeu)
        by smtp3-g21.free.fr (Postfix) with ESMTPA id 4F568A622A;
        Mon,  3 Aug 2015 19:25:08 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 3/3] MIPS: ath79: Add the reset controller to the AR9132 dtsi
Date:   Mon,  3 Aug 2015 19:23:53 +0200
Message-Id: <1438622633-9407-4-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1438622633-9407-1-git-send-email-albeu@free.fr>
References: <1438622633-9407-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48556
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

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/boot/dts/qca/ar9132.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9132.dtsi b/arch/mips/boot/dts/qca/ar9132.dtsi
index 4759cff..fb7734e 100644
--- a/arch/mips/boot/dts/qca/ar9132.dtsi
+++ b/arch/mips/boot/dts/qca/ar9132.dtsi
@@ -115,6 +115,14 @@
 				interrupt-controller;
 				#interrupt-cells = <1>;
 			};
+
+			rst: reset-controller@1806001c {
+				compatible = "qca,ar9132-reset",
+						"qca,ar7100-reset";
+				reg = <0x1806001c 0x4>;
+
+				#reset-cells = <1>;
+			};
 		};
 
 		spi@1f000000 {
-- 
2.0.0
