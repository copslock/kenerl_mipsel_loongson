Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jul 2014 17:47:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:25950 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6860076AbaGKPqOhfKxd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Jul 2014 17:46:14 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B6BFBCC78F8F1
        for <linux-mips@linux-mips.org>; Fri, 11 Jul 2014 16:46:04 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:08 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 11 Jul 2014 16:46:07 +0100
Received: from pburton-laptop.home (192.168.79.172) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 11 Jul
 2014 16:46:06 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 06/13] MIPS: fix MSA context for tasks which don't use FP first
Date:   Fri, 11 Jul 2014 16:44:32 +0100
Message-ID: <1405093479-5123-7-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.1
In-Reply-To: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
References: <1405093479-5123-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.79.172]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41141
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

If a task does not execute scalar FP instructions prior to using MSA
then the flags indicating that the task has live MSA context were not
being set. The upper 64b of each vector register would then be lost
upon the tasks first context switch after using MSA.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/kernel/traps.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 9359907..58a067f 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1096,6 +1096,8 @@ static int enable_restore_fp_context(int msa)
 		if (msa && !err) {
 			enable_msa();
 			_clear_msa_upper();
+			set_thread_flag(TIF_USEDMSA);
+			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
 		if (!err)
 			set_used_math();
-- 
2.0.1
