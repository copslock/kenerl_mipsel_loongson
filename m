Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 Sep 2013 17:52:25 +0200 (CEST)
Received: from mail-la0-f42.google.com ([209.85.215.42]:33109 "EHLO
        mail-la0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816285Ab3I1PwXtTM19 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 Sep 2013 17:52:23 +0200
Received: by mail-la0-f42.google.com with SMTP id ep20so3129736lab.15
        for <multiple recipients>; Sat, 28 Sep 2013 08:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=/d2Vs3oQBsBUgjEcPa4zTH6WoPzIva5hKF1G2UtSGkM=;
        b=i+nUZsaqQLj2KGFGImjDIN0QLw9CEHnRqxqYHTyiMlppwVTUnGWxLazz8gx2UwOr/j
         7WBWY4XBMwzgx1qYD3LN4U0vFcvlHboi3HlS451MJE/teNIgx7I5s36bMEo/3OTaGr0A
         hDAtGe7yAxCREpp6IfVCUA1vKpXH4nyohD6KzjALYAgfblRp4Jxg2ajnyPzZ2HajqOC3
         MzB61ghkW4V10PuMNQAoeKe9cmu8dKa7ZIIWBfkoRQoQTWzC0aXLd+XQnkPPSBQsbz2W
         TnO5Sx7eizOCwC4fTVfpD6NZy/mOSrFJYB6oq2KIyPEB3/tHSKnkSIeIaTS2szxvTzMI
         THpg==
X-Received: by 10.152.2.74 with SMTP id 10mr450682las.36.1380383538243;
        Sat, 28 Sep 2013 08:52:18 -0700 (PDT)
Received: from localhost.localdomain (ppp37-190-57-6.pppoe.spdop.ru. [37.190.57.6])
        by mx.google.com with ESMTPSA id ur6sm9603707lbc.5.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 28 Sep 2013 08:52:17 -0700 (PDT)
From:   Antony Pavlov <antonynpavlov@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Antony Pavlov <antonynpavlov@gmail.com>
Subject: [PATCH] MIPS: JZ4740: reuse UART0 address macro for vmlinuz debug port
Date:   Sat, 28 Sep 2013 19:49:34 +0400
Message-Id: <1380383374-28406-1-git-send-email-antonynpavlov@gmail.com>
X-Mailer: git-send-email 1.8.4.rc3
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
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

Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
---
 arch/mips/boot/compressed/uart-16550.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
index c01d343..869172d 100644
--- a/arch/mips/boot/compressed/uart-16550.c
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -19,8 +19,8 @@
 #endif
 
 #ifdef CONFIG_MACH_JZ4740
-#define UART0_BASE  0xB0030000
-#define PORT(offset) (UART0_BASE + (4 * offset))
+#include <asm/mach-jz4740/base.h>
+#define PORT(offset) (CKSEG1ADDR(JZ4740_UART0_BASE_ADDR) + (4 * offset))
 #endif
 
 #ifdef CONFIG_CPU_XLR
-- 
1.8.4.rc3
