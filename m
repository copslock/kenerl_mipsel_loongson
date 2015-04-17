Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Apr 2015 14:37:02 +0200 (CEST)
Received: from smtp4-g21.free.fr ([212.27.42.4]:55870 "EHLO smtp4-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010933AbbDQMgwUWG0I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Apr 2015 14:36:52 +0200
Received: from localhost.localdomain (unknown [78.54.181.212])
        (Authenticated sender: albeu)
        by smtp4-g21.free.fr (Postfix) with ESMTPA id 3AA324C80E7;
        Fri, 17 Apr 2015 14:34:31 +0200 (CEST)
From:   Alban Bedel <albeu@free.fr>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, Alban Bedel <albeu@free.fr>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Sergey Ryazanov <ryazanov.s.a@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] MIPS: ath79: Enable ZBOOT support
Date:   Fri, 17 Apr 2015 14:36:14 +0200
Message-Id: <1429274178-4337-2-git-send-email-albeu@free.fr>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1429274178-4337-1-git-send-email-albeu@free.fr>
References: <1429274178-4337-1-git-send-email-albeu@free.fr>
Return-Path: <albeu@free.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46880
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
index a326c4c..cc7f262 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -128,6 +128,7 @@ config ATH79
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_BIG_ENDIAN
 	select SYS_SUPPORTS_MIPS16
+	select SYS_SUPPORTS_ZBOOT
 	help
 	  Support for the Atheros AR71XX/AR724X/AR913X SoCs.
 
-- 
2.0.0
