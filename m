Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Mar 2016 21:08:57 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:44276 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013485AbcCIUI4D5FUq (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Mar 2016 21:08:56 +0100
Received: from localhost.localdomain (85-76-14-12-nat.elisa-mobile.fi [85.76.14.12])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 866C4188779;
        Wed,  9 Mar 2016 22:08:55 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ralf Baechle <ralf@linux-mips.org>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Helge Deller <deller@gmx.de>, linux-mips@linux-mips.org,
        linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH 1/2] MIPS: panic immediately when panic_on_oops
Date:   Wed,  9 Mar 2016 22:08:42 +0200
Message-Id: <1457554123-18491-2-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 2.4.0
In-Reply-To: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
References: <1457554123-18491-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52564
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

MIPS wants to sleep 5 seconds before panicking when panic_on_oops is set,
with no apparent reason. Remove this feature, since some users may want
their systems to fail as quickly as possible.

Users who want to delay reboot after panic can use PANIC_TIMEOUT.

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/traps.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index bf14da9..5756740 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -398,11 +398,8 @@ void __noreturn die(const char *str, struct pt_regs *regs)
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
 
-	if (panic_on_oops) {
-		printk(KERN_EMERG "Fatal exception: panic in 5 seconds");
-		ssleep(5);
+	if (panic_on_oops)
 		panic("Fatal exception");
-	}
 
 	if (regs && kexec_should_crash(current))
 		crash_kexec(regs);
-- 
2.4.0
