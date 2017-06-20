Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Jun 2017 17:24:21 +0200 (CEST)
Received: from outils.crapouillou.net ([89.234.176.41]:36744 "EHLO
        outils.crapouillou.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993870AbdFTPTWJrjVi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Jun 2017 17:19:22 +0200
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v2 16/17] devicetree/bindings: Add GCW vendor prefix
Date:   Tue, 20 Jun 2017 17:18:54 +0200
Message-Id: <20170620151855.19399-16-paul@crapouillou.net>
In-Reply-To: <20170620151855.19399-1-paul@crapouillou.net>
References: <20170607200439.24450-2-paul@crapouillou.net>
 <20170620151855.19399-1-paul@crapouillou.net>
Return-Path: <paul@outils.crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58704
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul@crapouillou.net
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

Game Consoles Worldwide, mostly known under the acronym GCW, is the
creator of the GCW Zero open-source video game system.

Signed-off-by: Paul Cercueil <paul@crapouillou.net>
Acked-by: Rob Herring <robh@kernel.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
 1 file changed, 1 insertion(+)

 v2: It's 'Game Consoles Worldwide', not 'Games Consoles Worldwide'

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index c03d20140366..5921aa1248fb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -114,6 +114,7 @@ focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
 fsl	Freescale Semiconductor
 fujitsu	Fujitsu Ltd.
+gcw Game Consoles Worldwide
 ge	General Electric Company
 geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.11.0
