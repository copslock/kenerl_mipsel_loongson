Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Jan 2015 16:26:47 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:33788 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011524AbbAUP0qAY7v5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Jan 2015 16:26:46 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 2C7726D4DBEB0;
        Wed, 21 Jan 2015 15:26:36 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 21 Jan 2015 15:26:39 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 21 Jan 2015 15:26:38 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        <stable@vger.kernel.org>
Subject: [PATCH] MIPS: asm: asmmacro: Replace "add" instructions with "addu"
Date:   Wed, 21 Jan 2015 15:26:23 +0000
Message-ID: <1421853983-28858-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45411
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

The "add" instruction is actually a macro in binutils and depending on
the size of the immediate it can expand to an "addi" instruction.
However, the "addi" instruction traps on overflows which is not
something we want on address calculation.

Link: http://www.linux-mips.org/archives/linux-mips/2015-01/msg00121.html
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
Moving this out of the R6 patchset as requested by Maciej
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
