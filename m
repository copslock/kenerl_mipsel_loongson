Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Dec 2004 14:49:55 +0000 (GMT)
Received: from mo01.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:30960 "EHLO
	mo01.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225341AbULAOtu>;
	Wed, 1 Dec 2004 14:49:50 +0000
Received: MO(mo01)id iB1EnkSi000947; Wed, 1 Dec 2004 23:49:46 +0900 (JST)
Received: MDO(mdo00) id iB1Enjid016307; Wed, 1 Dec 2004 23:49:45 +0900 (JST)
Received: 4UMRO01 id iB1EniOD004399; Wed, 1 Dec 2004 23:49:44 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Wed, 1 Dec 2004 23:49:43 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6] tlbwr hazard for NEC VR4100
Message-Id: <20041201234943.584d88e8.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6519
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch had added tlbwr hazard for NEC VR4100.
Please apply this patch to 2.6.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/arch/mips/mm/tlbex.c a/arch/mips/mm/tlbex.c
--- a-orig/arch/mips/mm/tlbex.c	Tue Nov 30 20:42:08 2004
+++ a/arch/mips/mm/tlbex.c	Wed Dec  1 23:23:11 2004
@@ -820,6 +820,25 @@
 		i_ssnop(p);
 		break;
 
+	case CPU_VR4111:
+	case CPU_VR4121:
+	case CPU_VR4122:
+	case CPU_VR4181:
+	case CPU_VR4181A:
+		i_nop(p);
+		i_nop(p);
+		i_tlbwr(p);
+		i_nop(p);
+		i_nop(p);
+		break;
+
+	case CPU_VR4131:
+	case CPU_VR4133:
+		i_nop(p);
+		i_nop(p);
+		i_tlbwr(p);
+		break;
+
 	default:
 		panic("No TLB refill handler yet (CPU type: %d)",
 		      current_cpu_data.cputype);
