Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 Apr 2003 04:35:25 +0100 (BST)
Received: from mo03.iij4u.or.jp ([IPv6:::ffff:210.130.0.20]:62700 "EHLO
	mo03.iij4u.or.jp") by linux-mips.org with ESMTP id <S8225202AbTDXDfY>;
	Thu, 24 Apr 2003 04:35:24 +0100
Received: from mdo01.iij4u.or.jp (mdo01.iij4u.or.jp [210.130.0.171])
	by mo03.iij4u.or.jp (8.8.8/MFO1.5) with ESMTP id MAA13278;
	Thu, 24 Apr 2003 12:35:21 +0900 (JST)
Received: 4UMDO01 id h3O3ZKm27327; Thu, 24 Apr 2003 12:35:20 +0900 (JST)
Received: 4UMRO01 id h3O3ZJW27551; Thu, 24 Apr 2003 12:35:20 +0900 (JST)
	from pudding.montavista.co.jp (localhost [127.0.0.1]) (authenticated)
Date: Thu, 24 Apr 2003 12:35:20 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: ralf@linux-mips.org
Cc: yuasa@hh.iij4u.or.jp, linux-mips@linux-mips.org
Subject: [patch] cpu-probe for VR41XX
Message-Id: <20030424123520.0dd54d5a.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 0.8.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2158
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

I found a problem in cpu-probe.c .
NEC VR4100 series do not have ll and sc.


for v2.4
--- ./arch/mips/kernel/cpu-probe.c.orig Thu Apr 24 10:50:53 2003
+++ ./arch/mips/kernel/cpu-probe.c      Thu Apr 24 12:33:06 2003
@@ -244,7 +244,7 @@
                                break;
                        }
                         current_cpu_data.isa_level = MIPS_CPU_ISA_III;
-                        current_cpu_data.options = R4K_OPTS | MIPS_CPU_LLSC;
+                        current_cpu_data.options = R4K_OPTS;
                         current_cpu_data.tlbsize = 32;
                         break;
                case PRID_IMP_R4300:


for v2.5
--- ./arch/mips/kernel/cpu-probe.c.orig Thu Apr 24 10:52:04 2003
+++ ./arch/mips/kernel/cpu-probe.c      Thu Apr 24 12:34:31 2003
@@ -244,7 +244,7 @@
                                break;
                        }
                         current_cpu_data.isa_level = MIPS_CPU_ISA_III;
-                        current_cpu_data.options = R4K_OPTS | MIPS_CPU_LLSC;
+                        current_cpu_data.options = R4K_OPTS;
                         current_cpu_data.tlbsize = 32;
                         break;
                case PRID_IMP_R4300:


--
Yoichi
