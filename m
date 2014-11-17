Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 10:32:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56746 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012958AbaKQJcvgJMVC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 10:32:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DA16D5A86215;
        Mon, 17 Nov 2014 09:32:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 17 Nov 2014 09:32:45 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.149) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 17 Nov 2014 09:32:45 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: lib: memcpy: Restore NOP on delay slot before returing to caller
Date:   Mon, 17 Nov 2014 09:32:38 +0000
Message-ID: <1416216758-24638-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.1.3
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.149]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44224
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

Commit cf62a8b8134dd3 ("MIPS: lib: memcpy: Use macro to build the
copy_user code") switched to a macro in order to build the memcpy
symbols in preparation for the EVA support. However, this commit
also removed the NOP instruction after the 'jr ra' when returning
back to the caller. This had no visible side-effects since the next
instruction was a load to the t0 register which was already in the
clobbered list, but it may have undesired effects in the future
if some other code is introduced in between the .Ldone and
the .Ll_exc_copy labels.

Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/lib/memcpy.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/lib/memcpy.S b/arch/mips/lib/memcpy.S
index c17ef80cf65a..5d3238af9b5c 100644
--- a/arch/mips/lib/memcpy.S
+++ b/arch/mips/lib/memcpy.S
@@ -503,6 +503,7 @@
 	STOREB(t0, NBYTES-2(dst), .Ls_exc_p1\@)
 .Ldone\@:
 	jr	ra
+	 nop
 	.if __memcpy == 1
 	END(memcpy)
 	.set __memcpy, 0
-- 
2.1.3
