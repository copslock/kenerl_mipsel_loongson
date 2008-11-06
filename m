Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Nov 2008 21:01:57 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12955 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S23298236AbYKFU4D (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Nov 2008 20:56:03 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B491359a30000>; Thu, 06 Nov 2008 15:54:59 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:58 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 6 Nov 2008 12:54:58 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mA6KsrDC027761;
	Thu, 6 Nov 2008 12:54:53 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mA6KsrDm027760;
	Thu, 6 Nov 2008 12:54:53 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>,
	Tomaso Paoletti <tpaoletti@caviumnetworks.com>
Subject: [PATCH 21/29] MIPS:  Compute branch returns for Cavium OCTEON specific branch instructions.
Date:	Thu,  6 Nov 2008 12:54:34 -0800
Message-Id: <1226004875-27654-21-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <491358F5.7040002@caviumnetworks.com>
References: <491358F5.7040002@caviumnetworks.com>
X-OriginalArrivalTime: 06 Nov 2008 20:54:58.0808 (UTC) FILETIME=[EE1B8780:01C94051]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21215
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
