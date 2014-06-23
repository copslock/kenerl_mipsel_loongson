Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Jun 2014 11:39:33 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52108 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6859940AbaFWJj1iWt7d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Jun 2014 11:39:27 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 4C1B21E10C5F3
        for <linux-mips@linux-mips.org>; Mon, 23 Jun 2014 10:39:19 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (192.168.5.97) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Mon, 23 Jun
 2014 10:39:20 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (192.168.5.97) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Mon, 23 Jun 2014 10:39:20 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.28) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 23 Jun 2014 10:39:20 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 01/17] MIPS: uasm: Add s3s1s2 instruction builder
Date:   Mon, 23 Jun 2014 10:38:44 +0100
Message-ID: <1403516340-22997-2-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.0.0
In-Reply-To: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
References: <1403516340-22997-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.28]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40656
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

It will be used later on by the slt instruction.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/uasm.h | 3 +++
 arch/mips/mm/uasm.c          | 7 +++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
index f8d63b3b40b4..43259b3fca6d 100644
--- a/arch/mips/include/asm/uasm.h
+++ b/arch/mips/include/asm/uasm.h
@@ -67,6 +67,9 @@ void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 #define Ip_u2s3u1(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, signed int b, unsigned int c)
 
+#define Ip_s3s1s2(op)							\
+void ISAOPC(op)(u32 **buf, int a, int b, int c)
+
 #define Ip_u2u1s3(op)							\
 void ISAOPC(op)(u32 **buf, unsigned int a, unsigned int b, signed int c)
 
diff --git a/arch/mips/mm/uasm.c b/arch/mips/mm/uasm.c
index 00515805fe41..1e3e10919423 100644
--- a/arch/mips/mm/uasm.c
+++ b/arch/mips/mm/uasm.c
@@ -139,6 +139,13 @@ Ip_u1u2u3(op)						\
 }							\
 UASM_EXPORT_SYMBOL(uasm_i##op);
 
+#define I_s3s1s2(op)					\
+Ip_s3s1s2(op)						\
+{							\
+	build_insn(buf, insn##op, b, c, a);		\
+}							\
+UASM_EXPORT_SYMBOL(uasm_i##op);
+
 #define I_u2u1u3(op)					\
 Ip_u2u1u3(op)						\
 {							\
-- 
2.0.0
