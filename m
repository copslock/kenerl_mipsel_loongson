Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Sep 2016 23:26:53 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9274 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993040AbcISVY5nADfO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Sep 2016 23:24:57 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B96B525E25A24;
        Mon, 19 Sep 2016 22:24:37 +0100 (IST)
Received: from localhost (10.100.200.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Mon, 19 Sep
 2016 22:24:41 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 12/14] MIPS: Malta: Remove custom halt implementation
Date:   Mon, 19 Sep 2016 22:21:29 +0100
Message-ID: <20160919212132.28893-13-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160919212132.28893-1-paul.burton@imgtec.com>
References: <20160919212132.28893-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.100.200.110]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55185
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

The arch code will hang the machine with an infinite loop if the board
doesn't provide an impelementation of halt - let it, rather than
duplicating it.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---

Changes in v2: None

 arch/mips/mti-malta/malta-reset.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 04d6b9c..dd6f62a 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -13,11 +13,6 @@
 #include <asm/reboot.h>
 #include <asm/mach-malta/malta-pm.h>
 
-static void mips_machine_halt(void)
-{
-	while (true);
-}
-
 static void mips_machine_power_off(void)
 {
 	mips_pm_suspend(PIIX4_FUNC3IO_PMCNTRL_SUS_TYP_SOFF);
@@ -28,7 +23,6 @@ static void mips_machine_power_off(void)
 
 static int __init mips_reboot_setup(void)
 {
-	_machine_halt = mips_machine_halt;
 	pm_power_off = mips_machine_power_off;
 
 	return 0;
-- 
2.9.3
