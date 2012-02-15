Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Feb 2012 20:20:08 +0100 (CET)
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:49130 "EHLO
        wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903658Ab2BOTT7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 15 Feb 2012 20:19:59 +0100
Received: from nat.nue.novell.com ([195.135.221.2] helo=g231.suse.de); authenticated
        by wp188.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        id 1RxkOO-0001nD-3Y; Wed, 15 Feb 2012 20:19:52 +0100
From:   Danny Kukawka <danny.kukawka@bisect.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Danny Kukawka <dkukawka@suse.de>,
        Kevin Cernekee <cernekee@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] arch/mips/kernel/smp-bmips.c included linux/init.h twice
Date:   Wed, 15 Feb 2012 20:19:49 +0100
Message-Id: <1329333589-31828-1-git-send-email-danny.kukawka@bisect.de>
X-Mailer: git-send-email 1.7.8.3
X-bounce-key: webpack.hosteurope.de;danny.kukawka@bisect.de;1329333599;1877811c;
X-archive-position: 32433
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: danny.kukawka@bisect.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

arch/mips/kernel/smp-bmips.c included 'linux/init.h' twice,
remove the duplicate.

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 arch/mips/kernel/smp-bmips.c |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/smp-bmips.c b/arch/mips/kernel/smp-bmips.c
index 58fe71a..64978e9 100644
--- a/arch/mips/kernel/smp-bmips.c
+++ b/arch/mips/kernel/smp-bmips.c
@@ -16,7 +16,6 @@
 #include <linux/smp.h>
 #include <linux/interrupt.h>
 #include <linux/spinlock.h>
-#include <linux/init.h>
 #include <linux/cpu.h>
 #include <linux/cpumask.h>
 #include <linux/reboot.h>
-- 
1.7.8.3
