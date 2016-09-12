Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 00:17:28 +0200 (CEST)
Received: from mail.windriver.com ([147.11.1.11]:37620 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992213AbcILWRCQvtza (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 00:17:02 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail.windriver.com (8.15.2/8.15.1) with ESMTPS id u8CMGsmS026786
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Mon, 12 Sep 2016 15:16:54 -0700 (PDT)
Received: from yow-lpgnfs-02.wrs.com (128.224.149.8) by
 ALA-HCA.corp.ad.wrs.com (147.11.189.40) with Microsoft SMTP Server id
 14.3.294.0; Mon, 12 Sep 2016 15:16:54 -0700
From:   Paul Gortmaker <paul.gortmaker@windriver.com>
To:     <linux-kernel@vger.kernel.org>
CC:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        <linux-mips@linux-mips.org>, <linux-gpio@vger.kernel.org>
Subject: [PATCH 6/8] gpio: loongson1: fix implicit assumption module.h is present
Date:   Mon, 12 Sep 2016 18:16:29 -0400
Message-ID: <20160912221631.15812-7-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 2.8.4
In-Reply-To: <20160912221631.15812-1-paul.gortmaker@windriver.com>
References: <20160912221631.15812-1-paul.gortmaker@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: <Paul.Gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55120
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

The Kconfig for this file is:

drivers/gpio/Kconfig:config GPIO_LOONGSON1
drivers/gpio/Kconfig:   tristate "Loongson1 GPIO support"

...but however it does not include module.h -- it in turn gets it from
another header (gpio/driver.h) and we'd like to replace that with a
forward delcaration of "struct module;" but if we do, this file will
fail to compile.

So we fix this first to avoid putting build failures into the bisect
commit history.

Cc: Keguang Zhang <keguang.zhang@gmail.com>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Alexandre Courbot <gnurou@gmail.com>
Cc: linux-mips@linux-mips.org
Cc: linux-gpio@vger.kernel.org
Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 drivers/gpio/gpio-loongson1.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpio/gpio-loongson1.c b/drivers/gpio/gpio-loongson1.c
index 10c09bdd8514..ad0a5958fcd0 100644
--- a/drivers/gpio/gpio-loongson1.c
+++ b/drivers/gpio/gpio-loongson1.c
@@ -8,6 +8,7 @@
  * warranty of any kind, whether express or implied.
  */
 
+#include <linux/module.h>
 #include <linux/gpio/driver.h>
 #include <linux/platform_device.h>
 
-- 
2.8.4
