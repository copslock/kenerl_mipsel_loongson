Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 13:23:15 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:19292 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6839029AbaEGLWYIwRYh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 13:22:24 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9F7075850566E
        for <linux-mips@linux-mips.org>; Wed,  7 May 2014 12:22:14 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Wed, 7 May
 2014 12:22:16 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 12:22:16 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 7 May 2014 12:22:16 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 5/5] MIPS: Malta: support powering down
Date:   Wed, 7 May 2014 12:22:12 +0100
Message-ID: <1399461732-17685-1-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
References: <1399461660-17623-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40044
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

This patch powers down the Malta in response to a power off command (eg.
poweroff or shutdown -P). It may then be powered back up by pressing the
"ON/NMI" button (S4) on the board. In cases where the power off state
cannot be entered (eg. because the required PCI support is disabled) the
current reset behaviour will be used as a fallback.

Tested-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop previous patches in this series which abstract the
    PIIX4 suspend functionality, making this patch trivial and avoiding
    build issues when CONFIG_PCI is disabled.
---
 arch/mips/mti-malta/malta-reset.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 4471dea..773aca9 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -10,6 +10,7 @@
 #include <linux/pm.h>
 
 #include <asm/reboot.h>
+#include <asm/mach-malta/malta-pm.h>
 
 #define SOFTRES_REG	0x1f000500
 #define GORESET		0x42
@@ -30,6 +31,9 @@ static void mips_machine_halt(void)
 
 static void mips_machine_power_off(void)
 {
+	mips_pm_suspend(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF);
+
+	pr_info("Failed to power down, resetting\n");
 	mips_machine_restart(NULL);
 }
 
-- 
1.8.5.3
