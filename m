Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 18:45:29 +0100 (BST)
Received: from static-72-72-73-123.bstnma.east.verizon.net ([72.72.73.123]:5897
	"EHLO mail.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20021784AbXGJRp1 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 18:45:27 +0100
Received: from localhost (localhost [127.0.0.1])
	by mail.sicortex.com (Postfix) with ESMTP id E2B5C2074C8;
	Tue, 10 Jul 2007 13:44:51 -0400 (EDT)
X-Virus-Scanned: amavisd-new at sicortex.com
Received: from mail.sicortex.com ([127.0.0.1])
	by localhost (mail.sicortex.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hVL1IkBqvxYG; Tue, 10 Jul 2007 13:44:51 -0400 (EDT)
Received: from localhost.localdomain (gsrv020.sicortex.com [10.2.2.20])
	by mail.sicortex.com (Postfix) with ESMTP id 354352074C4;
	Tue, 10 Jul 2007 13:44:51 -0400 (EDT)
From:	pwatkins@sicortex.com
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Peter Watkins <pwatkins@sicortex.com>
Subject: [PATCH] [MIPS] Fix resume for 64k page size (#2).
Date:	Tue, 10 Jul 2007 13:44:51 -0400
Message-Id: <11840894911139-git-send-email-pwatkins@sicortex.com>
X-Mailer: git-send-email 1.4.2.4
Return-Path: <pwatkins@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pwatkins@sicortex.com
Precedence: bulk
X-list: linux-mips

From: Peter Watkins <pwatkins@sicortex.com>

Fixup according to Thiemo and Maciej's comments.

Signed-off-by: Peter Watkins <pwatkins@sicortex.com>
---
 arch/mips/kernel/r4k_switch.S |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/kernel/r4k_switch.S b/arch/mips/kernel/r4k_switch.S
index 65f0f91..ca7f71a 100644
--- a/arch/mips/kernel/r4k_switch.S
+++ b/arch/mips/kernel/r4k_switch.S
@@ -85,7 +85,7 @@ #endif
 	move	$28, a2
 	cpu_restore_nonscratch a1
 
-#if (_THREAD_SIZE) < 0x10000
+#if (_THREAD_SIZE - 32) < 0x8000
 	PTR_ADDIU	t0, $28, _THREAD_SIZE - 32
 #else
 	PTR_LI		t0, _THREAD_SIZE - 32
-- 
1.4.2.4
