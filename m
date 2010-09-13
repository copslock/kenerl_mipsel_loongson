Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Sep 2010 21:48:33 +0200 (CEST)
Received: from mail.perches.com ([173.55.12.10]:1857 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490954Ab0IMTsa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 13 Sep 2010 21:48:30 +0200
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id 35B3A2436B;
        Mon, 13 Sep 2010 12:48:21 -0700 (PDT)
From:   Joe Perches <joe@perches.com>
To:     linux-kernel@vger.kernel.org
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [PATCH 01/25] arch/mips: Use static const char arrays
Date:   Mon, 13 Sep 2010 12:47:39 -0700
Message-Id: <8fcec0d2a48e806558e6bc39d5aa98518a97f8c7.1284406638.git.joe@perches.com>
X-Mailer: git-send-email 1.7.3.rc1
In-Reply-To: <cover.1284406638.git.joe@perches.com>
References: <cover.1284406638.git.joe@perches.com>
X-archive-position: 27750
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10273

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/mips/pnx8550/common/reset.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/pnx8550/common/reset.c b/arch/mips/pnx8550/common/reset.c
index fadd874..e0ac0b2 100644
--- a/arch/mips/pnx8550/common/reset.c
+++ b/arch/mips/pnx8550/common/reset.c
@@ -27,8 +27,8 @@
 
 void pnx8550_machine_restart(char *command)
 {
-	char head[] = "************* Machine restart *************";
-	char foot[] = "*******************************************";
+	static const char head[] = "************* Machine restart *************";
+	static const char foot[] = "*******************************************";
 
 	printk("\n\n");
 	printk("%s\n", head);
-- 
1.7.3.rc1
