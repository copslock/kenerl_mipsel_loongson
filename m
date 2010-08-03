Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Aug 2010 20:23:08 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:19456 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493163Ab0HCSWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Aug 2010 20:22:47 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4c585e910000>; Tue, 03 Aug 2010 11:23:13 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:44 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Tue, 3 Aug 2010 11:22:44 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dd1.caveonetworks.com (8.14.4/8.14.3) with ESMTP id o73IMcmT026418;
        Tue, 3 Aug 2010 11:22:38 -0700
Received: (from ddaney@localhost)
        by dd1.caveonetworks.com (8.14.4/8.14.4/Submit) id o73IMcPj026417;
        Tue, 3 Aug 2010 11:22:38 -0700
From:   David Daney <ddaney@caviumnetworks.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org, ananth@in.ibm.com,
        anil.s.keshavamurthy@intel.com, davem@davemloft.net,
        masami.hiramatsu.pt@hitachi.com
Cc:     linux-kernel@vger.kernel.org, hschauhan@nulltrace.org,
        David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/5] MIPS: Add instrunction format for BREAK and SYSCALL
Date:   Tue,  3 Aug 2010 11:22:19 -0700
Message-Id: <1280859742-26364-3-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.7.1.1
In-Reply-To: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
References: <1280859742-26364-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 03 Aug 2010 18:22:44.0688 (UTC) FILETIME=[DE0EAD00:01CB3338]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27545
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/include/asm/inst.h |   15 ++++++++++++++-
 1 files changed, 14 insertions(+), 1 deletions(-)

diff --git a/arch/mips/include/asm/inst.h b/arch/mips/include/asm/inst.h
index 6489f00..444ff71 100644
--- a/arch/mips/include/asm/inst.h
+++ b/arch/mips/include/asm/inst.h
@@ -247,6 +247,12 @@ struct ma_format {	/* FPU multipy and add format (MIPS IV) */
 	unsigned int fmt : 2;
 };
 
+struct b_format { /* BREAK and SYSCALL */
+	unsigned int opcode:6;
+	unsigned int code:20;
+	unsigned int func:6;
+};
+
 #elif defined(__MIPSEL__)
 
 struct j_format {	/* Jump format */
@@ -314,6 +320,12 @@ struct ma_format {	/* FPU multipy and add format (MIPS IV) */
 	unsigned int opcode : 6;
 };
 
+struct b_format { /* BREAK and SYSCALL */
+	unsigned int func:6;
+	unsigned int code:20;
+	unsigned int opcode:6;
+};
+
 #else /* !defined (__MIPSEB__) && !defined (__MIPSEL__) */
 #error "MIPS but neither __MIPSEL__ nor __MIPSEB__?"
 #endif
@@ -328,7 +340,8 @@ union mips_instruction {
 	struct c_format c_format;
 	struct r_format r_format;
 	struct f_format f_format;
-        struct ma_format ma_format;
+	struct ma_format ma_format;
+	struct b_format b_format;
 };
 
 /* HACHACHAHCAHC ...  */
-- 
1.7.1.1
