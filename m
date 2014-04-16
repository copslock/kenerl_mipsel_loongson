Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Apr 2014 15:05:08 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.115]:57354 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837168AbaDPNC2iWmMm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Apr 2014 15:02:28 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F250172FFB973
        for <linux-mips@linux-mips.org>; Wed, 16 Apr 2014 14:02:17 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 16 Apr 2014 14:02:20 +0100
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Wed, 16 Apr 2014 14:02:19 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 29/39] MIPS: smp-cps: use CPC core-other locking
Date:   Wed, 16 Apr 2014 13:53:20 +0100
Message-ID: <1397652810-4336-30-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
References: <1397652810-4336-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39836
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

The core which the CPC core-other region relates to is based upon the
core-local core-other addressing register. As its name suggests this
register is shared between all VPEs within a core, and if there is a
possibility that multiple VPEs within a core will attempt to access
another core simultaneously then locking is required. This wasn't
previously a problem with the only user being cpu0 during boot, but will
be an issue once hotplug is implemented & may race with other users such
as cpuidle.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/smp-cps.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/smp-cps.c b/arch/mips/kernel/smp-cps.c
index 6da42f0..fd946c7 100644
--- a/arch/mips/kernel/smp-cps.c
+++ b/arch/mips/kernel/smp-cps.c
@@ -161,11 +161,10 @@ static void boot_core(unsigned core)
 	write_gcr_access(access);
 
 	if (mips_cpc_present()) {
-		/* Select the appropriate core */
-		write_cpc_cl_other(core << CPC_Cx_OTHER_CORENUM_SHF);
-
 		/* Reset the core */
+		mips_cpc_lock_other(core);
 		write_cpc_co_cmd(CPC_Cx_CMD_RESET);
+		mips_cpc_unlock_other();
 	} else {
 		/* Take the core out of reset */
 		write_gcr_co_reset_release(0);
-- 
1.8.5.3
