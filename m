Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 22:53:46 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:4306 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492858Ab0HCUxi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 22:53:38 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c5881ea0000>; Tue, 03 Aug 2010 13:54:02 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 13:53:33 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 13:53:33 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73KrU1W002627;
        Tue, 3 Aug 2010 13:53:30 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73KrRTX002626;
        Tue, 3 Aug 2010 13:53:27 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Define regs_return_value()
Date:   Tue,  3 Aug 2010 13:53:24 -0700
Message-Id: <1280868804-2595-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <20100803202607.GA25233@linux-mips.org>
References: <20100803202607.GA25233@linux-mips.org>
X-OriginalArrivalTime: 03 Aug 2010 20:53:33.0512 (UTC) FILETIME=[EF93A480:01CB334D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27555
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---

Use this version instead of the original 1/5

 arch/mips/include/asm/ptrace.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/mips/include/asm/ptrace.h b/arch/mips/include/asm/ptrace.h
index cdc6a46..9f1b8db 100644
--- a/arch/mips/include/asm/ptrace.h
+++ b/arch/mips/include/asm/ptrace.h
@@ -137,6 +137,7 @@ extern int ptrace_set_watch_regs(struct task_struct *child,
  */
 #define user_mode(regs) (((regs)->cp0_status & KU_MASK) == KU_USER)
 
+#define regs_return_value(_regs) ((_regs)->regs[2])
 #define instruction_pointer(regs) ((regs)->cp0_epc)
 #define profile_pc(regs) instruction_pointer(regs)
 
-- 
1.7.1.1
