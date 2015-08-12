Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Aug 2015 11:14:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:61862 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010957AbbHLJOs2ixvA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Aug 2015 11:14:48 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 3DF28DE7BF8C2
        for <linux-mips@linux-mips.org>; Wed, 12 Aug 2015 10:14:40 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 12 Aug 2015 10:14:41 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 12 Aug 2015 10:14:40 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH] MIPS: math-emu: dsemul: Remove unused handle_dsemul function declaration
Date:   Wed, 12 Aug 2015 10:14:35 +0100
Message-ID: <1439370875-8660-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48810
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

handle_dsemul does not exist and it's not being used in the code at all
so remove its declaration. The deliberate DS emulation exception is
handled by the do_dsemulret C code.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/math-emu/dsemul.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/math-emu/dsemul.c b/arch/mips/math-emu/dsemul.c
index e0b5cc27d78b..cbb36c14b155 100644
--- a/arch/mips/math-emu/dsemul.c
+++ b/arch/mips/math-emu/dsemul.c
@@ -33,7 +33,6 @@ struct emuframe {
 
 int mips_dsemul(struct pt_regs *regs, mips_instruction ir, unsigned long cpc)
 {
-	extern asmlinkage void handle_dsemulret(void);
 	struct emuframe __user *fr;
 	int err;
 
-- 
2.5.0
