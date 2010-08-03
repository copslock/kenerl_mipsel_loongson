Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 20:24:04 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19479 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493175Ab0HCSWu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 20:22:50 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c585e940001>; Tue, 03 Aug 2010 11:23:16 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:47 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:47 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73IMZBm026414;
        Tue, 3 Aug 2010 11:22:35 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73IMYBT026413;
        Tue, 3 Aug 2010 11:22:34 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 1/5] MIPS: Define regs_return_value()
Date:   Tue,  3 Aug 2010 11:22:18 -0700
Message-Id: <1280859742-26364-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 03 Aug 2010 18:22:47.0079 (UTC) FILETIME=[DF7B8370:01CB3338]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27547
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index cdc6a46..593b097 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -137,6 +137,7 @@ extern int ptrace_set_watch_regs(struct task_struct *child,
  */
 #define user_mode(regs) (((regs)->cp0_status & KU_MASK) == KU_USER)
 
+#define regs_return_value(regs) ((regs)->regs[2])
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-- 
1.7.1.1
