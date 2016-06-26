Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jun 2016 00:03:20 +0200 (CEST)
Received: from down.free-electrons.com ([37.187.137.238]:47119 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27025518AbcFZWDTQQhUf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Jun 2016 00:03:19 +0200
Received: by mail.free-electrons.com (Postfix, from userid 110)
        id 6A88417D0; Mon, 27 Jun 2016 00:03:13 +0200 (CEST)
Received: from localhost (unknown [88.191.26.124])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 1301238B;
        Mon, 27 Jun 2016 00:03:13 +0200 (CEST)
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     rtc-linux@googlegroups.com
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        linux-kernel@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 2/5] rtc: ds1286: move header to linux/rtc
Date:   Mon, 27 Jun 2016 00:03:00 +0200
Message-Id: <1466978583-13310-2-git-send-email-alexandre.belloni@free-electrons.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
References: <1466978583-13310-1-git-send-email-alexandre.belloni@free-electrons.com>
Return-Path: <alexandre.belloni@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54171
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Move ds1286.h to rtc specific folder.

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
---
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
 arch/mips/sgi-ip22/ip22-reset.c  | 2 +-
 drivers/rtc/rtc-ds1286.c         | 2 +-
 include/linux/{ => rtc}/ds1286.h | 0
 3 files changed, 2 insertions(+), 2 deletions(-)
 rename include/linux/{ => rtc}/ds1286.h (100%)

diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-reset.c
index 063c2dd31e72..2f45b0357021 100644
--- a/arch/mips/sgi-ip22/ip22-reset.c
+++ b/arch/mips/sgi-ip22/ip22-reset.c
@@ -7,7 +7,7 @@
  */
 #include <linux/linkage.h>
 #include <linux/init.h>
-#include <linux/ds1286.h>
+#include <linux/rtc/ds1286.h>
 #include <linux/module.h>
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
diff --git a/drivers/rtc/rtc-ds1286.c b/drivers/rtc/rtc-ds1286.c
index 756e509f6ed2..ef75c349dff9 100644
--- a/drivers/rtc/rtc-ds1286.c
+++ b/drivers/rtc/rtc-ds1286.c
@@ -16,7 +16,7 @@
 #include <linux/rtc.h>
 #include <linux/platform_device.h>
 #include <linux/bcd.h>
-#include <linux/ds1286.h>
+#include <linux/rtc/ds1286.h>
 #include <linux/io.h>
 #include <linux/slab.h>
 
diff --git a/include/linux/ds1286.h b/include/linux/rtc/ds1286.h
similarity index 100%
rename from include/linux/ds1286.h
rename to include/linux/rtc/ds1286.h
-- 
2.8.1
