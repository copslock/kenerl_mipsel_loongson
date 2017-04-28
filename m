Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Apr 2017 10:36:02 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:57640 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991672AbdD1IfslUe9l (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 28 Apr 2017 10:35:48 +0200
Received: from localhost (unknown [195.77.54.9])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D79CD9C;
        Fri, 28 Apr 2017 08:35:40 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Alban Bedel <albeu@free.fr>,
        Paul Burton <paul.burton@imgtec.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Brian Norris <computersforpeace@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 3.18 20/47] MIPS: Fix the build on jz4740 after removing the custom gpio.h
Date:   Fri, 28 Apr 2017 10:32:33 +0200
Message-Id: <20170428083039.189477537@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170428083038.327543269@linuxfoundation.org>
References: <20170428083038.327543269@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57808
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.18-stable review patch.  If anyone has any objections, please let me know.

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
Cc: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/jz4740/board-qi_lb60.c |    1 +
 arch/mips/jz4740/gpio.c          |    1 +
 2 files changed, 2 insertions(+)

--- a/arch/mips/jz4740/board-qi_lb60.c
+++ b/arch/mips/jz4740/board-qi_lb60.c
@@ -26,6 +26,7 @@
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
 
