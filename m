Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Nov 2012 13:53:13 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:64857 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6826611Ab2KKMurqh7oi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Nov 2012 13:50:47 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so2053456bkw.36
        for <multiple recipients>; Sun, 11 Nov 2012 04:50:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=vElk2CVfRJafpdgq1DUO6K/JH/dRamo6vs7ndPUb4xI=;
        b=Xd4Kx/rt+uAeCKJHbZ+I3OuXFdK6VrXIMVPWGsZ5VMqd366O0VSNomrayOxV9dbJok
         jg9bPXY2uNduXldbYEZb8EruZJ6F5WK2TM4KZUj/alxBqprkUIvRJSv1s1EewxIEYMlD
         yp54C8fRe76sDAmdh3ryjDN1NYZThKhxo1jSzaoQSVNcDujUbnMtnW6ojcD6UBl2zD2N
         8bCKv2lS7RHCKqCFw73gzBxvQUg7gc9NluUxvHngPvkJFPDrlNO5yFljLe0cTPGsZjIQ
         Lp3MjVC2akzc+8a2DH0ON9HzcaaW5wXBOMa4BSNEB+tlxpkz2Y65ypiK8gDb8S/01YSe
         60Bw==
Received: by 10.204.147.78 with SMTP id k14mr3621042bkv.7.1352638247559;
        Sun, 11 Nov 2012 04:50:47 -0800 (PST)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id z22sm1436133bkw.2.2012.11.11.04.50.45
        (version=SSLv3 cipher=OTHER);
        Sun, 11 Nov 2012 04:50:46 -0800 (PST)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [RFC] serial: bcm63xx_uart: remove unnecessary include
Date:   Sun, 11 Nov 2012 13:50:42 +0100
Message-Id: <1352638249-29298-9-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
References: <1352638249-29298-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34939
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

bcm63xx_clk.h does not need to be included anymore as clk.h already
provides all required prototypes.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/tty/serial/bcm63xx_uart.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/drivers/tty/serial/bcm63xx_uart.c b/drivers/tty/serial/bcm63xx_uart.c
index c0b68b9..0187aff 100644
--- a/drivers/tty/serial/bcm63xx_uart.c
+++ b/drivers/tty/serial/bcm63xx_uart.c
@@ -30,7 +30,6 @@
 #include <linux/serial.h>
 #include <linux/serial_core.h>
 
-#include <bcm63xx_clk.h>
 #include <bcm63xx_irq.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
-- 
1.7.2.5
