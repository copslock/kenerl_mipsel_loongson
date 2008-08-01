Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Aug 2008 10:44:42 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:58066 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S28574332AbYHAJk3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 1 Aug 2008 10:40:29 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 4F1C2C8016;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id FVUiEkeYXZ1n; Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: from sd048.hel.movial.fi (sd048.hel.movial.fi [172.17.49.48])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 0FE37C806D;
	Fri,  1 Aug 2008 12:40:22 +0300 (EEST)
Received: by sd048.hel.movial.fi (Postfix, from userid 30120)
	id CA9D9108070; Fri,  1 Aug 2008 12:40:21 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	rpjday@crashcourse.ca
Subject: [PATCH 4/7] [MIPS] Remove unused config variable MIPS_BOARDS_GEN
Date:	Fri,  1 Aug 2008 12:40:18 +0300
Message-Id: <1217583621-4772-5-git-send-email-dmitri.vorobiev@movial.fi>
X-Mailer: git-send-email 1.5.6
In-Reply-To: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
References: <1217583621-4772-1-git-send-email-dmitri.vorobiev@movial.fi>
Return-Path: <dvorobye@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20070
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

The config variable MIPS_BOARDS_GEN is defined but never used,
and this patch removes the forgotten variable.

Reported-by: Robert P. J. Day <rpjday@crashcourse.ca>
Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
---
 arch/mips/Kconfig |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index f5e8720..a49863c 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -195,7 +195,6 @@ config MIPS_MALTA
 	select HW_HAS_PCI
 	select I8253
 	select I8259
-	select MIPS_BOARDS_GEN
 	select MIPS_BONITO64
 	select MIPS_CPU_SCACHE
 	select PCI_GT64XXX_PCI0
@@ -839,9 +838,6 @@ config IRQ_GT641XX
 config IRQ_GIC
 	bool
 
-config MIPS_BOARDS_GEN
-	bool
-
 config PCI_GT64XXX_PCI0
 	bool
 
-- 
1.5.6
