Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Nov 2008 22:30:56 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:7727 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23754608AbYKRWYb (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 18 Nov 2008 22:24:31 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B492340700001>; Tue, 18 Nov 2008 17:23:44 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:42 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 18 Nov 2008 14:23:41 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mAIMNblH004875;
	Tue, 18 Nov 2008 14:23:37 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mAIMNb15004874;
	Tue, 18 Nov 2008 14:23:37 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 17/26] MIPS:  Compute branch returns for Cavium OCTEON specific branch instructions.
Date:	Tue, 18 Nov 2008 14:23:32 -0800
Message-Id: <1227047013-4785-17-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <49233FDE.3010404@caviumnetworks.com>
References: <49233FDE.3010404@caviumnetworks.com>
X-OriginalArrivalTime: 18 Nov 2008 22:23:41.0909 (UTC) FILETIME=[4FE14850:01C949CC]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21320
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

For Cavium OCTEON, compute the return epc value for OCTEON specific
branch instructions.

Signed-off-by: Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/branch.c |   33 +++++++++++++++++++++++++++++++++
 1 files changed, 33 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/branch.c b/arch/mips/kernel/branch.c
index 6b5df8b..0176ed0 100644
--- a/arch/mips/kernel/branch.c
+++ b/arch/mips/kernel/branch.c
@@ -205,6 +205,39 @@ int __compute_return_epc(struct pt_regs *regs)
 			break;
 		}
 		break;
+#ifdef CONFIG_CPU_CAVIUM_OCTEON
+	case lwc2_op: /* This is bbit0 on Octeon */
+		if ((regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
+		     == 0)
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+	case ldc2_op: /* This is bbit032 on Octeon */
+		if ((regs->regs[insn.i_format.rs] &
+		    (1ull<<(insn.i_format.rt+32))) == 0)
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+	case swc2_op: /* This is bbit1 on Octeon */
+		if (regs->regs[insn.i_format.rs] & (1ull<<insn.i_format.rt))
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+	case sdc2_op: /* This is bbit132 on Octeon */
+		if (regs->regs[insn.i_format.rs] &
+		    (1ull<<(insn.i_format.rt+32)))
+			epc = epc + 4 + (insn.i_format.simmediate << 2);
+		else
+			epc += 8;
+		regs->cp0_epc = epc;
+		break;
+#endif
 	}
 
 	return 0;
-- 
1.5.6.5
