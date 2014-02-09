Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Feb 2014 19:48:32 +0100 (CET)
Received: from mail.sigma-star.at ([95.130.255.111]:52756 "EHLO
        mail.sigma-star.at" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822672AbaBISsa0indY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Feb 2014 19:48:30 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.sigma-star.at (Postfix) with ESMTP id 49A8516B42A5;
        Sun,  9 Feb 2014 19:48:33 +0100 (CET)
X-Virus-Scanned: amavisd-new at mail.sigma-star.at
Received: from mail.sigma-star.at ([127.0.0.1])
        by localhost (mail.sigma-star.at [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id Npw9nKHqBP7x; Sun,  9 Feb 2014 19:48:32 +0100 (CET)
Received: from linux.site (richard.vpn.sigmapriv.at [10.3.0.5])
        by mail.sigma-star.at (Postfix) with ESMTPSA id 6490116B4010;
        Sun,  9 Feb 2014 19:48:32 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org (open list:MIPS),
        linux-kernel@vger.kernel.org (open list)
Cc:     Richard Weinberger <richard@nod.at>
Subject: [PATCH 08/28] Remove SYS_HAS_DMA_OPS
Date:   Sun,  9 Feb 2014 19:47:46 +0100
Message-Id: <1391971686-9517-9-git-send-email-richard@nod.at>
X-Mailer: git-send-email 1.8.4.2
In-Reply-To: <1391971686-9517-1-git-send-email-richard@nod.at>
References: <1391971686-9517-1-git-send-email-richard@nod.at>
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39255
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

The symbol is an orphan, get rid of it.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/mips/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index dcae3a7..792bd22 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1396,7 +1396,6 @@ config CPU_CAVIUM_OCTEON
 	select LIBFDT
 	select USE_OF
 	select USB_EHCI_BIG_ENDIAN_MMIO
-	select SYS_HAS_DMA_OPS
 	select MIPS_L1_CACHE_SHIFT_7
 	help
 	  The Cavium Octeon processor is a highly integrated chip containing
-- 
1.8.4.2
