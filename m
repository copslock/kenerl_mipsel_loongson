Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Apr 2015 22:30:10 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55146 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010470AbbDHUaJgjXs8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Apr 2015 22:30:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=644Q3SduD2exKF/sur4t71shEU/EnMAn2b5Qv6ou26Q=;
        b=w/jC7a+3ua6CGpWkENO8lM2K6F5jlDoMpLpFndoBtgJ8keHUsXHUrRhV7cqSDfU0zUyOQ2O3WeY2pHtt73mJdYmQuY392pu9s3MmgXO94fr4roWX9YrxPOn6gKdB7p68+dFQF+hR+u5dZK3lbiUeNnNbwh/SMflpob1AVGf96IQ=;
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yfwbq-004FJ6-Oi
        for linux-mips@linux-mips.org; Wed, 08 Apr 2015 20:30:04 +0000
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57160 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.82)
        (envelope-from <linux@roeck-us.net>)
        id 1Yfwbi-004F8X-IW; Wed, 08 Apr 2015 20:29:55 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Lutomirski <luto@amacapital.net>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] mips: Fix build if PERF_EVENTS is configured
Date:   Wed,  8 Apr 2015 13:29:52 -0700
Message-Id: <1428524992-5979-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.0
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-CTCH-PVer: 0000001
X-CTCH-Spam: Unknown
X-CTCH-VOD: Unknown
X-CTCH-Flags: 0
X-CTCH-RefID: str=0001.0A020202.55258FCC.0204,ss=1,re=0.001,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X-CTCH-Score: 0.001
X-CTCH-ScoreCust: 0.000
X-CTCH-Rules: C_4847,
X-CTCH-SenderID: linux@roeck-us.net
X-CTCH-SenderID-Flags: 0
X-CTCH-SenderID-TotalMessages: 2
X-CTCH-SenderID-TotalSpam: 0
X-CTCH-SenderID-TotalSuspected: 0
X-CTCH-SenderID-TotalConfirmed: 0
X-CTCH-SenderID-TotalBulk: 0
X-CTCH-SenderID-TotalVirus: 0
X-CTCH-SenderID-TotalRecipients: 0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: mailgid no entry from get_relayhosts_entry
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46838
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

mips builds fail in -next as follows if PERF_EVENTS is configured.

kernel/built-in.o: In function `perf_sample_regs_user':
kernel/events/core.c:4828: undefined reference to `perf_get_regs_user'

The problem is caused by commit 3478e32c1545 ("MIPS: Add user stack and
registers to perf.") in combination with commit 88a7c26af8da ("perf:
Move task_pt_regs sampling into arch code"), which introduces
perf_get_regs_user().

Cc: Andy Lutomirski <luto@amacapital.net>
Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Compile tested only.

 arch/mips/kernel/perf_regs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/mips/kernel/perf_regs.c b/arch/mips/kernel/perf_regs.c
index 0451c4b..5b04454 100644
--- a/arch/mips/kernel/perf_regs.c
+++ b/arch/mips/kernel/perf_regs.c
@@ -58,3 +58,11 @@ u64 perf_reg_value(struct pt_regs *regs, int idx)
 
 	return (s64)v; /* Sign extend if 32-bit. */
 }
+
+void perf_get_regs_user(struct perf_regs *regs_user,
+			struct pt_regs *regs,
+			struct pt_regs *regs_user_copy)
+{
+	regs_user->regs = task_pt_regs(current);
+	regs_user->abi = perf_reg_abi(current);
+}
-- 
2.1.0
