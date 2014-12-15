Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Dec 2014 20:31:32 +0100 (CET)
Received: from youngberry.canonical.com ([91.189.89.112]:52502 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008616AbaLOTb2eJd14 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Dec 2014 20:31:28 +0100
Received: from c-76-102-4-12.hsd1.ca.comcast.net ([76.102.4.12] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.71)
        (envelope-from <kamal@canonical.com>)
        id 1Y0bIU-0005Je-GS; Mon, 15 Dec 2014 19:27:10 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1Y0bIS-0006js-MA; Mon, 15 Dec 2014 11:27:08 -0800
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>, linux-mips@linux-mips.org,
        Huacai Chen <chenhc@lemote.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.13.y-ckt 59/96] MIPS: Loongson: Make platform serial setup always built-in.
Date:   Mon, 15 Dec 2014 11:26:19 -0800
Message-Id: <1418671616-25482-60-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1418671616-25482-1-git-send-email-kamal@canonical.com>
References: <1418671616-25482-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.13
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44698
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.13.11-ckt13 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaro Koskinen <aaro.koskinen@iki.fi>

commit 26927f76499849e095714452b8a4e09350f6a3b9 upstream.

If SERIAL_8250 is compiled as a module, the platform specific setup
for Loongson will be a module too, and it will not work very well.
At least on Loongson 3 it will trigger a build failure,
since loongson_sysconf is not exported to modules.

Fix by making the platform specific serial code always built-in.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reported-by: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: Huacai Chen <chenhc@lemote.com>
Cc: Markos Chandras <Markos.Chandras@imgtec.com>
Patchwork: https://patchwork.linux-mips.org/patch/8533/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/loongson/common/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/loongson/common/Makefile b/arch/mips/loongson/common/Makefile
index 9e4484c..9005a8d6 100644
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
1.9.1
