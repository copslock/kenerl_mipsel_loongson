Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Nov 2014 23:55:20 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:52121 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27014056AbaKSWzSfKE5V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Nov 2014 23:55:18 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 1C03019C197;
        Thu, 20 Nov 2014 00:55:18 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id vXU9mY0YNML1; Thu, 20 Nov 2014 00:55:11 +0200 (EET)
Received: from amd-fx-6350.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 7A7C75BC010;
        Thu, 20 Nov 2014 00:55:11 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Cc:     Huacai@filtteri2.pp.htv.fi, "Chen <chenhc"@lemote.com,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Aaro Koskinen <aaro.koskinen@iki.fi>, stable@vger.kernel.org
Subject: [PATCH] MIPS: loongson: make platform serial setup always built-in
Date:   Thu, 20 Nov 2014 00:55:06 +0200
Message-Id: <1416437706-28720-1-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.1.2
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44311
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

If SERIAL_8250 is compiled as a module, the platform specific setup
for Loongson will be a module too, and it will not work very well.
At least on Loongson 3 it will trigger a build failure,
since loongson_sysconf is not exported to modules.

Fix by making the platform specific serial code always built-in.

Cc: stable@vger.kernel.org
Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/loongson/common/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 0bb9cc9..d87e033 100644
--- a/arch/mips/loongson/common/Makefile
+++ b/arch/mips/loongson/common/Makefile
@@ -11,7 +11,8 @@ obj-$(CONFIG_PCI) += pci.o
 # Serial port support
 #
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
-obj-$(CONFIG_SERIAL_8250) += serial.o
+loongson-serial-$(CONFIG_SERIAL_8250) := serial.o
+obj-y += $(loongson-serial-m) $(loongson-serial-y)
 obj-$(CONFIG_LOONGSON_UART_BASE) += uart_base.o
 obj-$(CONFIG_LOONGSON_MC146818) += rtc.o
 
-- 
2.1.2
