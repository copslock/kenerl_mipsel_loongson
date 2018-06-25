Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Jun 2018 19:17:08 +0200 (CEST)
Received: from nbd.name ([IPv6:2a01:4f8:221:3d45::2]:57956 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992936AbeFYRQBWVN9w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Jun 2018 19:16:01 +0200
From:   John Crispin <john@phrozen.org>
To:     James Hogan <jhogan@kernel.org>, Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <john@phrozen.org>
Subject: [PATCH 03/25] MIPS: ath79: select the PINCTRL subsystem
Date:   Mon, 25 Jun 2018 19:15:27 +0200
Message-Id: <20180625171549.4618-4-john@phrozen.org>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20180625171549.4618-1-john@phrozen.org>
References: <20180625171549.4618-1-john@phrozen.org>
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64431
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

The pinmux on QCA SoCs is controlled by a single register. The
"pinctrl-single" driver can be used but requires the target
to select PINCTRL.

Signed-off-by: John Crispin <john@phrozen.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 79a864cfc595..03909f2ada9f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -193,6 +193,7 @@ config ATH79
 	select CSRC_R4K
 	select DMA_NONCOHERENT
 	select GPIOLIB
+	select PINCTRL
 	select HAVE_CLK
 	select COMMON_CLK
 	select CLKDEV_LOOKUP
-- 
2.11.0
