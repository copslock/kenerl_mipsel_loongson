Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jan 2015 11:54:39 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60734 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010531AbbAPKwFS3KFP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 16 Jan 2015 11:52:05 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 95BAFD52492D1;
        Fri, 16 Jan 2015 10:51:57 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 16 Jan 2015 10:51:59 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Fri, 16 Jan 2015 10:51:59 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: [PATCH RFC v2 12/70] MIPS: asm: asmmacro: Replace add instructions with "addui"
Date:   Fri, 16 Jan 2015 10:48:51 +0000
Message-ID: <1421405389-15512-13-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
In-Reply-To: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
References: <1421405389-15512-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45156
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

The use of "add" instruction for immediate operations can result to
build failures for MIPS R6. This is because, the 'add' is a macro in
binutils and depending on the size of the immediate it can expand to
an 'addi' instruction which has been removed from MIPS R6.
Thus, we will be using the 'addu' macro instead, which also
accepts immediate operands.

Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00121.html
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index fe08084f5adb..42b90c9fd756 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -304,7 +304,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	add	$1, \base, \off
+	addu	$1, \base, \off
 	.word	LDD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
@@ -313,7 +313,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	add	$1, \base, \off
+	addu	$1, \base, \off
 	.word	STD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
-- 
2.2.1
