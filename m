Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jun 2015 22:16:40 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:35531 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007106AbbFBUQiy8zGc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jun 2015 22:16:38 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.1/8.15.1) with ESMTPS id t52KGWlT024249
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Tue, 2 Jun 2015 13:16:32 -0700 (PDT)
Received: from yow-lpgnfs-02.corp.ad.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.224.2; Tue, 2 Jun 2015 13:16:32 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: [PATCH 3/4] mips: make loongsoon serial driver explicitly modular
Date:   Tue, 2 Jun 2015 16:16:07 -0400
Message-ID: <1433276168-21550-4-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
References: <1433276168-21550-1-git-send-email-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47805
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
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

The file looks as if it is non-modular, but it piggy-backs
off CONFIG_SERIAL_8250 which is tristate.  If set to "=m"
we will get this after the init/module header cleanup:

arch/mips/loongson/common/serial.c:76:1: error: data definition has no type or storage class [-Werror]
arch/mips/loongson/common/serial.c:76:1: error: type defaults to 'int' in declaration of 'device_initcall' [-Werror=implicit-int]
arch/mips/loongson/common/serial.c:76:1: error: parameter names (without types) in function declaration [-Werror]
arch/mips/loongson/common/serial.c:58:19: error: 'serial_init' defined but not used [-Werror=unused-function]
cc1: all warnings being treated as errors
make[3]: *** [arch/mips/loongson/common/serial.o] Error 1

Make it clearly modular, and add a module_exit function,
so that we avoid the above breakage.

Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 arch/mips/loongson/common/serial.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/mips/loongson/common/serial.c b/arch/mips/loongson/common/serial.c
index c23fa1373729..ffefc1cb2612 100644
--- a/arch/mips/loongson/common/serial.c
+++ b/arch/mips/loongson/common/serial.c
@@ -11,7 +11,7 @@
  */
 
 #include <linux/io.h>
-#include <linux/init.h>
+#include <linux/module.h>
 #include <linux/serial_8250.h>
 
 #include <asm/bootinfo.h>
@@ -108,5 +108,10 @@ static int __init serial_init(void)
 
 	return platform_device_register(&uart8250_device);
 }
+module_init(serial_init);
 
-device_initcall(serial_init);
+static void __init serial_exit(void)
+{
+	platform_device_unregister(&uart8250_device);
+}
+module_exit(serial_exit);
-- 
2.2.1
