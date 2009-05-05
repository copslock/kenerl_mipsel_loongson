Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 05 May 2009 20:51:30 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:29386 "EHLO
	mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023658AbZEETvY (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 5 May 2009 20:51:24 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4a00988e0008>; Tue, 05 May 2009 15:50:38 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 12:49:51 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 5 May 2009 12:49:51 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id n45Jnmve000688;
	Tue, 5 May 2009 12:49:49 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id n45JnlnU000686;
	Tue, 5 May 2009 12:49:47 -0700
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org, ralf@linux-mips.org, florian@openwrt.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH] MIPS: Use force_sig when handling address errors.
Date:	Tue,  5 May 2009 12:49:47 -0700
Message-Id: <1241552987-662-1-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.6.0.6
X-OriginalArrivalTime: 05 May 2009 19:49:51.0409 (UTC) FILETIME=[A778C210:01C9CDBA]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22626
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

When init is started it is SIGNAL_UNKILLABLE.  If it were to get an
address error, we would try to send it SIGBUS, but it would be ignored
and the faulting instruction restarted.  This results in an endless
loop.

We need to use force_sig() instead so it will actually die and give us
some useful information.

Reported-by: Florian Fainelli <florian@openwrt.org>

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/unaligned.c |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index bf4c4a9..67bd626 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -482,19 +482,19 @@ fault:
 		return;
 
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	send_sig(SIGSEGV, current, 1);
+	force_sig(SIGSEGV, current);
 
 	return;
 
 sigbus:
 	die_if_kernel("Unhandled kernel unaligned access", regs);
-	send_sig(SIGBUS, current, 1);
+	force_sig(SIGBUS, current);
 
 	return;
 
 sigill:
 	die_if_kernel("Unhandled kernel unaligned access or invalid instruction", regs);
-	send_sig(SIGILL, current, 1);
+	force_sig(SIGILL, current);
 }
 
 asmlinkage void do_ade(struct pt_regs *regs)
-- 
1.6.0.6
