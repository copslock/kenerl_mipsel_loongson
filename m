Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 Apr 2014 13:47:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.89.28.114]:34266 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821191AbaDHLrWYG936 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 Apr 2014 13:47:22 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A33A192FECFFA
        for <linux-mips@linux-mips.org>; Tue,  8 Apr 2014 12:47:10 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 8 Apr 2014 12:47:12 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.89) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Tue, 8 Apr 2014 12:47:12 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 01/14] MIPS: uasm: Add u3u2u1 instruction builders
Date:   Tue, 8 Apr 2014 12:47:02 +0100
Message-ID: <1396957635-27071-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
References: <1396957635-27071-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.89]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39708
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

It will be used later on by the sllv and srlv instructions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uasm.h | 3 +++
 arch/mips/mm/uasm.c          | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index c33a956..c2f1f0b 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -55,6 +55,9 @@ void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 #define Ip_u2u1u3(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
+#define Ip_u3u2u1(op)							\
+void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
+
 #define Ip_u3u1u2(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, unsigned int c)
 
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index b9d14b6..6210a0f 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -144,6 +144,13 @@ Ip_u2u1u3(op)						\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_u3u2u1(op)					\
+Ip_u3u2u1(op)						\
+{							\
+	build_insn(buf, insn##op, c, b, a);		\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u3u1u2(op)					\
 Ip_u3u1u2(op)						\
 {							\
-- 
1.9.1
