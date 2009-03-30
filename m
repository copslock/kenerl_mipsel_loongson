Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Mar 2009 20:54:38 +0100 (BST)
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:39575 "EHLO
	gw02.mail.saunalahti.fi") by ftp.linux-mips.org with ESMTP
	id S20025333AbZC3Txs (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 30 Mar 2009 20:53:48 +0100
Received: from localhost.localdomain (a88-114-245-69.elisa-laajakaista.fi [88.114.245.69])
	by gw02.mail.saunalahti.fi (Postfix) with ESMTP id 946861399EB;
	Mon, 30 Mar 2009 22:53:44 +0300 (EEST)
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Dmitri Vorobiev <dmitri.vorobiev@movial.com>
Subject: [PATCH 2/4] [MIPS] ip32: ip32_be_handler symbol is needlessly defined global
Date:	Mon, 30 Mar 2009 22:53:24 +0300
Message-Id: <1238442806-11013-3-git-send-email-dmitri.vorobiev@movial.com>
X-Mailer: git-send-email 1.5.6.3
In-Reply-To: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
References: <1238442806-11013-1-git-send-email-dmitri.vorobiev@movial.com>
Return-Path: <dmitri.vorobiev@movial.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.com
Precedence: bulk
X-list: linux-mips

The file arch/mips/sgi-ip32/ip32-berr.c needlessly defines the function
ip32_be_handler() as global, and this patch makes it static.

Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.com>
---
 arch/mips/sgi-ip32/ip32-berr.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/sgi-ip32/ip32-berr.c b/arch/mips/sgi-ip32/ip32-berr.c
index a278e91..afc1cad 100644
--- a/arch/mips/sgi-ip32/ip32-berr.c
+++ b/arch/mips/sgi-ip32/ip32-berr.c
@@ -16,7 +16,7 @@
 #include <asm/ptrace.h>
 #include <asm/tlbdebug.h>
 
-int ip32_be_handler(struct pt_regs *regs, int is_fixup)
+static int ip32_be_handler(struct pt_regs *regs, int is_fixup)
 {
 	int data = regs->cp0_cause & 4;
 
-- 
1.5.6.3
