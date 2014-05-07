Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 May 2014 13:22:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:22644 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6839028AbaEGLVkQagbZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 7 May 2014 13:21:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 42951F6C9ABEC
        for <linux-mips@linux-mips.org>; Wed,  7 May 2014 12:21:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 7 May 2014 12:21:33 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 7 May 2014 12:21:32 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 4/5] MIPS: Malta: hang on halt
Date:   Wed, 7 May 2014 12:20:59 +0100
Message-ID: <1399461660-17623-5-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 40043
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

When the system is halted it makes little sense to reset it. Instead,
hang by executing an infinite loop.

Suggested-by: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/mti-malta/malta-reset.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index d627d4b..4471dea 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -24,17 +24,20 @@ static void mips_machine_restart(char *command)
 
 static void mips_machine_halt(void)
 {
-	unsigned int __iomem *softres_reg =
-		ioremap(SOFTRES_REG, sizeof(unsigned int));
+	pr_info("Halting\n");
+	while (true);
+}
 
-	__raw_writel(GORESET, softres_reg);
+static void mips_machine_power_off(void)
+{
+	mips_machine_restart(NULL);
 }
 
 static int __init mips_reboot_setup(void)
 {
 	_machine_restart = mips_machine_restart;
 	_machine_halt = mips_machine_halt;
-	pm_power_off = mips_machine_halt;
+	pm_power_off = mips_machine_power_off;
 
 	return 0;
 }
-- 
1.8.5.3
