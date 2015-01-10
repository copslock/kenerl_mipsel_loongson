Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Jan 2015 19:27:28 +0100 (CET)
Received: from smtp-out-109.synserver.de ([212.40.185.109]:1035 "EHLO
        smtp-out-109.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010598AbbAJS11IyM4b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Jan 2015 19:27:27 +0100
Received: (qmail 6886 invoked by uid 0); 10 Jan 2015 18:27:26 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 6744
Received: from ppp-88-217-3-222.dynamic.mnet-online.de (HELO lars-laptop.fritz.box) [88.217.3.222]
  by 217.119.54.96 with SMTP; 10 Jan 2015 18:27:26 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@iguana.be>,
        Paul Burton <paul.burton@imgtec.com>,
        Paul Cercueil <paul@crapouillou.net>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/3] MIPS: Use do_kernel_restart() as the default restart handler
Date:   Sat, 10 Jan 2015 19:29:08 +0100
Message-Id: <1420914550-18335-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.10.4
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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

Use the recently introduced do_kernel_restart() function as the default restart
handler if the platform did not explicitly provide a restart handler. This
allows use restart handler that have been registered by device drivers to
restart the machine.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/kernel/reset.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
index 07fc524..36cd80c 100644
--- a/arch/mips/kernel/reset.c
+++ b/arch/mips/kernel/reset.c
@@ -19,7 +19,7 @@
  * So handle all using function pointers to machine specific
  * functions.
  */
-void (*_machine_restart)(char *command);
+void (*_machine_restart)(char *command) = do_kernel_restart;
 void (*_machine_halt)(void);
 void (*pm_power_off)(void);
 
-- 
1.7.10.4
