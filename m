Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 08:27:54 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:62426 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225219AbTDXH1x>;
	Thu, 24 Apr 2003 08:27:53 +0100
Received: from mdo00.iij4u.or.jp (mdo00.iij4u.or.jp [210.130.0.170])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id QAA23016;
	Thu, 24 Apr 2003 16:27:49 +0900 (JST)
Received: 4UMDO00 id h3O7Rnp27345; Thu, 24 Apr 2003 16:27:49 +0900 (JST)
Received: 4UMRO00 id h3O7Rmx08909; Thu, 24 Apr 2003 16:27:49 +0900 (JST)
	from pudding.montavista.co.jp (localhost [127.0.0.1]) (authenticated)
Date: Thu, 24 Apr 2003 16:27:49 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] simulate_llsc
Message-Id: <20030424162749.325b4533.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2159
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I found a problem in traps.c .
The simulate_llsc does not have return values.

Please apply these patches.

Yoichi

for v2.4
--- ./arch/mips/kernel/traps.c.orig     Mon Apr 21 10:56:54 2003
+++ ./arch/mips/kernel/traps.c  Thu Apr 24 16:25:57 2003
@@ -521,11 +521,11 @@
 
        if ((opcode & OPCODE) == LL) {
                simulate_ll(regs, opcode);
-               return;
+               return 0;
        }
        if ((opcode & OPCODE) == SC) {
                simulate_sc(regs, opcode);
-               return;
+               return 0;
        }
 }

for v2.5
--- ./arch/mips/kernel/traps.c.orig     Mon Apr 21 10:59:49 2003
+++ ./arch/mips/kernel/traps.c  Thu Apr 24 16:14:14 2003
@@ -516,11 +516,11 @@
 
        if ((opcode & OPCODE) == LL) {
                simulate_ll(regs, opcode);
-               return;
+               return 0;
        }
        if ((opcode & OPCODE) == SC) {
                simulate_sc(regs, opcode);
-               return;
+               return 0;
        }
 }
