Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Sep 2015 17:24:52 +0200 (CEST)
Received: from smtp2-g21.free.fr ([212.27.42.2]:38092 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007013AbbIAPYaizOY8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 1 Sep 2015 17:24:30 +0200
Received: from tock.adnet.avionic-design.de (unknown [78.54.126.133])
        (Authenticated sender: albeu)
        by smtp2-g21.free.fr (Postfix) with ESMTPA id 354794B0113;
        Tue,  1 Sep 2015 17:24:18 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alban Bedel <albeu@free.fr>
Subject: [PATCH 4/4] MIPS: ath79: Enable the USB port on the TL-WR1043ND
Date:   Tue,  1 Sep 2015 17:23:14 +0200
Message-Id: <1441120994-31476-5-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1441120994-31476-1-git-send-email-albeu@free.fr>
References: <1441120994-31476-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49078
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
 arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
index 003015a..cd51199 100644
--- a/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
+++ b/arch/mips/boot/dts/qca/ar9132_tl_wr1043nd_v1.dts
@@ -35,6 +35,10 @@
 			};
 		};
 
+		ehci@1b000100 {
+			status = "okay";
+		};
+
 		spi@1f000000 {
 			status = "okay";
 			num-cs = <1>;
-- 
2.0.0
