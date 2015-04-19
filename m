Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Apr 2015 14:30:33 +0200 (CEST)
Received: from smtp1-g21.free.fr ([212.27.42.1]:55389 "EHLO smtp1-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011778AbbDSMa0UaY7T (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Apr 2015 14:30:26 +0200
Received: from localhost.localdomain (unknown [85.177.79.58])
        (Authenticated sender: albeu)
        by smtp1-g21.free.fr (Postfix) with ESMTPA id AE3B794001E;
        Sun, 19 Apr 2015 14:28:04 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        Gabor Juhos <juhosg@openwrt.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/5] MIPS: ath79: Enable ZBOOT support
Date:   Sun, 19 Apr 2015 14:30:00 +0200
Message-Id: <1429446604-15403-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429446604-15403-1-git-send-email-albeu@free.fr>
References: <1429446604-15403-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46919
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

ZBOOT is working fine, so allow using it.

Signed-off-by: Alban Bedel <albeu@free.fr>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f501665..9075147 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -131,6 +131,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_ZBOOT
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
 
-- 
2.0.0
