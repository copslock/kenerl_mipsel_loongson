Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 15:03:27 +0100 (CET)
Received: from outils.crapouillou.net ([89.234.176.41]:52164 "EHLO
        crapouillou.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991258AbdL1N5EtbZX5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 14:57:04 +0100
From:   Paul Cercueil <paul@crapouillou.net>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-clk@vger.kernel.org,
        Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH v4 14/15] devicetree/bindings: Add GCW vendor prefix
Date:   Thu, 28 Dec 2017 14:56:33 +0100
Message-Id: <20171228135634.30000-15-paul@crapouillou.net>
In-Reply-To: <20171228135634.30000-1-paul@crapouillou.net>
References: <20170702163016.6714-2-paul@crapouillou.net>
 <20171228135634.30000-1-paul@crapouillou.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net; s=mail; t=1514469424; bh=ri4iFg9bG8q+bmnG5UpR6uopdXMpJv4V1pYWeDWtQRk=; h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=BXjVkji6Dn5kYVe26hTD8ZvVu/kkm42PDS9rDIP76M88+p7sfv5zwermGx7sczvIG7QtunwrEVv/wy8zDN3X8MAR3XHyak1zM96RCRHbnxJagMTQVrxfZlKBAowKLF3uikSTFTQrkLWAo25MskghHr+Ewgv65B5lkUVVVslHwS4=
Return-Path: <paul@crapouillou.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61660
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
 v3: No change
 v4: No change

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
index 0994bdd82cd3..f40f4da39937 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.txt
+++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
@@ -123,6 +123,7 @@ focaltech	FocalTech Systems Co.,Ltd
 friendlyarm	Guangzhou FriendlyARM Computer Tech Co., Ltd
 fsl	Freescale Semiconductor
 fujitsu	Fujitsu Ltd.
+gcw Game Consoles Worldwide
 ge	General Electric Company
 geekbuying	GeekBuying
 gef	GE Fanuc Intelligent Platforms Embedded Systems, Inc.
-- 
2.11.0
