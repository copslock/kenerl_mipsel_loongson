Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Jun 2009 19:03:47 +0200 (CEST)
Received: from gw03.mail.saunalahti.fi ([195.197.172.111]:48517 "EHLO
	gw03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493387AbZFZRDj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 26 Jun 2009 19:03:39 +0200
Received: from localhost.localdomain (a88-114-254-251.elisa-laajakaista.fi [88.114.254.251])
	by gw03.mail.saunalahti.fi (Postfix) with ESMTP id 1AAE521691A;
	Fri, 26 Jun 2009 19:59:33 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH] [MIPS] Malta: Remove unneeded function protos from malta-reset.c
Date:	Fri, 26 Jun 2009 19:59:25 +0300
Message-Id: <1246035565-24015-1-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.6.0.4
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23510
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

Two prototypes of statically defined functions aren't needed
in arch/mips/mti-malta/malta-reset.c, so remove them.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/mti-malta/malta-reset.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/malta-reset.c
index 42dee4d..f48d60e 100644
--- a/arch/mips/mti-malta/malta-reset.c
+++ b/arch/mips/mti-malta/malta-reset.c
@@ -28,9 +28,6 @@
 #include <asm/reboot.h>
 #include <asm/mips-boards/generic.h>
 
-static void mips_machine_restart(char *command);
-static void mips_machine_halt(void);
-
 static void mips_machine_restart(char *command)
 {
 	unsigned int __iomem *softres_reg =
-- 
1.6.0.4
