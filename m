Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Nov 2017 00:56:42 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:34361 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990593AbdKFXybz6dtf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Nov 2017 00:54:31 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDV-0008Tv-Kb; Mon, 06 Nov 2017 23:54:09 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1eBrDT-00013t-Sg; Mon, 06 Nov 2017 23:54:07 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linus Walleij" <linus.walleij@linaro.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Alban Bedel" <albeu@free.fr>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Lars-Peter Clausen" <lars@metafoo.de>,
        "Arnd Bergmann" <arnd@arndb.de>,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Brian Norris" <computersforpeace@gmail.com>,
        linux-mips@linux-mips.org
Date:   Mon, 06 Nov 2017 23:03:02 +0000
Message-ID: <lsq.1510009382.195997073@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 282/294] MIPS: Fix the build on jz4740 after removing
 the custom gpio.h
In-Reply-To: <lsq.1510009377.526284287@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.50-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Alban Bedel <albeu@free.fr>

commit 5b235dc2647e4977b17b5c41d959d0f455831c3f upstream.

Somehow the wrong version of the patch to remove the use of custom
gpio.h on mips has been merged. This patch add the missing fixes for a
build error on jz4740 because linux/gpio.h doesn't provide any machine
specfics definitions anymore.

Signed-off-by: Alban Bedel <albeu@free.fr>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/11089/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/jz4740/board-qi_lb60.c | 1 +
 arch/mips/jz4740/gpio.c          | 1 +
 2 files changed, 2 insertions(+)

--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -25,6 +25,7 @@
 #include <linux/power/jz4740-battery.h>
 #include <linux/power/gpio-charger.h>
 
+#include <asm/mach-jz4740/gpio.h>
 #include <asm/mach-jz4740/jz4740_fb.h>
 #include <asm/mach-jz4740/jz4740_mmc.h>
 #include <asm/mach-jz4740/jz4740_nand.h>
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -27,6 +27,7 @@
 #include <linux/seq_file.h>
 
 #include <asm/mach-jz4740/base.h>
+#include <asm/mach-jz4740/gpio.h>
 
 #include "irq.h"
 
