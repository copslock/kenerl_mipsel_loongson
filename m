Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Oct 2008 02:02:28 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:42598 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S22251742AbYJXA6G (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 24 Oct 2008 01:58:06 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B49011d660005>; Thu, 23 Oct 2008 20:57:10 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:10 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 23 Oct 2008 17:57:08 -0700
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id m9O0v4C2005617;
	Thu, 23 Oct 2008 17:57:04 -0700
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id m9O0v45J005616;
	Thu, 23 Oct 2008 17:57:04 -0700
From:	ddaney@caviumnetworks.com
To:	linux-mips@linux-mips.org
Cc:	David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 14/37] Rewrite cpu_to_name so it has one statement per line.
Date:	Thu, 23 Oct 2008 17:56:38 -0700
Message-Id: <1224809821-5532-15-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
References: <1224809821-5532-1-git-send-email-ddaney@caviumnetworks.com>
X-OriginalArrivalTime: 24 Oct 2008 00:57:08.0938 (UTC) FILETIME=[70F4EAA0:01C93573]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20894
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

From: David Daney <ddaney@caviumnetworks.com>

Future changes can now pass checkpatch.pl

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
Acked-by: Maciej W. Rozycki <macro@linux-mips.org>
---
 arch/mips/kernel/cpu-probe.c |  156 +++++++++++++++++++++--------------------
 1 files changed, 80 insertions(+), 76 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0cf1545..30f7e8c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -820,86 +820,90 @@ const char *__cpu_name[NR_CPUS];
 /*
  * Name a CPU
  */
+static const char *mips_cpu_names[] = {
+	[CPU_UNKNOWN]		= "unknown",
+	[CPU_R2000]		= "R2000",
+	[CPU_R3000]		= "R3000",
+	[CPU_R3000A]		= "R3000A",
+	[CPU_R3041]		= "R3041",
+	[CPU_R3051]		= "R3051",
+	[CPU_R3052]		= "R3052",
+	[CPU_R3081]		= "R3081",
+	[CPU_R3081E]		= "R3081E",
+	[CPU_R4000PC]		= "R4000PC",
+	[CPU_R4000SC]		= "R4000SC",
+	[CPU_R4000MC]		= "R4000MC",
+	[CPU_R4200]		= "R4200",
+	[CPU_R4400PC]		= "R4400PC",
+	[CPU_R4400SC]		= "R4400SC",
+	[CPU_R4400MC]		= "R4400MC",
+	[CPU_R4600]		= "R4600",
+	[CPU_R6000]		= "R6000",
+	[CPU_R6000A]		= "R6000A",
+	[CPU_R8000]		= "R8000",
+	[CPU_R10000]		= "R10000",
+	[CPU_R12000]		= "R12000",
+	[CPU_R14000]		= "R14000",
+	[CPU_R4300]		= "R4300",
+	[CPU_R4650]		= "R4650",
+	[CPU_R4700]		= "R4700",
+	[CPU_R5000]		= "R5000",
+	[CPU_R5000A]		= "R5000A",
+	[CPU_R4640]		= "R4640",
+	[CPU_NEVADA]		= "Nevada",
+	[CPU_RM7000]		= "RM7000",
+	[CPU_RM9000]		= "RM9000",
+	[CPU_R5432]		= "R5432",
+	[CPU_4KC]		= "MIPS 4Kc",
+	[CPU_5KC]		= "MIPS 5Kc",
+	[CPU_R4310]		= "R4310",
+	[CPU_SB1]		= "SiByte SB1",
+	[CPU_SB1A]		= "SiByte SB1A",
+	[CPU_TX3912]		= "TX3912",
+	[CPU_TX3922]		= "TX3922",
+	[CPU_TX3927]		= "TX3927",
+	[CPU_AU1000]		= "Au1000",
+	[CPU_AU1500]		= "Au1500",
+	[CPU_AU1100]		= "Au1100",
+	[CPU_AU1550]		= "Au1550",
+	[CPU_AU1200]		= "Au1200",
+	[CPU_AU1210]		= "Au1210",
+	[CPU_AU1250]		= "Au1250",
+	[CPU_4KEC]		= "MIPS 4KEc",
+	[CPU_4KSC]		= "MIPS 4KSc",
+	[CPU_VR41XX]		= "NEC Vr41xx",
+	[CPU_R5500]		= "R5500",
+	[CPU_TX49XX]		= "TX49xx",
+	[CPU_20KC]		= "MIPS 20Kc",
+	[CPU_24K]		= "MIPS 24K",
+	[CPU_25KF]		= "MIPS 25Kf",
+	[CPU_34K]		= "MIPS 34K",
+	[CPU_1004K]		= "MIPS 1004K",
+	[CPU_74K]		= "MIPS 74K",
+	[CPU_VR4111]		= "NEC VR4111",
+	[CPU_VR4121]		= "NEC VR4121",
+	[CPU_VR4122]		= "NEC VR4122",
+	[CPU_VR4131]		= "NEC VR4131",
+	[CPU_VR4133]		= "NEC VR4133",
+	[CPU_VR4181]		= "NEC VR4181",
+	[CPU_VR4181A]		= "NEC VR4181A",
+	[CPU_SR71000]		= "Sandcraft SR71000",
+	[CPU_BCM3302]		= "Broadcom BCM3302",
+	[CPU_BCM4710]		= "Broadcom BCM4710",
+	[CPU_PR4450]		= "Philips PR4450",
+	[CPU_LOONGSON2]		= "ICT Loongson-2",
+	[CPU_LAST]		= NULL
+};
+
 static __cpuinit const char *cpu_to_name(struct cpuinfo_mips *c)
 {
-	const char *name = NULL;
+	const char *name;
 
-	switch (c->cputype) {
-	case CPU_UNKNOWN:	name = "unknown"; break;
-	case CPU_R2000:		name = "R2000"; break;
-	case CPU_R3000:		name = "R3000"; break;
-	case CPU_R3000A:	name = "R3000A"; break;
-	case CPU_R3041:		name = "R3041"; break;
-	case CPU_R3051:		name = "R3051"; break;
-	case CPU_R3052:		name = "R3052"; break;
-	case CPU_R3081:		name = "R3081"; break;
-	case CPU_R3081E:	name = "R3081E"; break;
-	case CPU_R4000PC:	name = "R4000PC"; break;
-	case CPU_R4000SC:	name = "R4000SC"; break;
-	case CPU_R4000MC:	name = "R4000MC"; break;
-	case CPU_R4200:		name = "R4200"; break;
-	case CPU_R4400PC:	name = "R4400PC"; break;
-	case CPU_R4400SC:	name = "R4400SC"; break;
-	case CPU_R4400MC:	name = "R4400MC"; break;
-	case CPU_R4600:		name = "R4600"; break;
-	case CPU_R6000:		name = "R6000"; break;
-	case CPU_R6000A:	name = "R6000A"; break;
-	case CPU_R8000:		name = "R8000"; break;
-	case CPU_R10000:	name = "R10000"; break;
-	case CPU_R12000:	name = "R12000"; break;
-	case CPU_R14000:	name = "R14000"; break;
-	case CPU_R4300:		name = "R4300"; break;
-	case CPU_R4650:		name = "R4650"; break;
-	case CPU_R4700:		name = "R4700"; break;
-	case CPU_R5000:		name = "R5000"; break;
-	case CPU_R5000A:	name = "R5000A"; break;
-	case CPU_R4640:		name = "R4640"; break;
-	case CPU_NEVADA:	name = "Nevada"; break;
-	case CPU_RM7000:	name = "RM7000"; break;
-	case CPU_RM9000:	name = "RM9000"; break;
-	case CPU_R5432:		name = "R5432"; break;
-	case CPU_4KC:		name = "MIPS 4Kc"; break;
-	case CPU_5KC:		name = "MIPS 5Kc"; break;
-	case CPU_R4310:		name = "R4310"; break;
-	case CPU_SB1:		name = "SiByte SB1"; break;
-	case CPU_SB1A:		name = "SiByte SB1A"; break;
-	case CPU_TX3912:	name = "TX3912"; break;
-	case CPU_TX3922:	name = "TX3922"; break;
-	case CPU_TX3927:	name = "TX3927"; break;
-	case CPU_AU1000:	name = "Au1000"; break;
-	case CPU_AU1500:	name = "Au1500"; break;
-	case CPU_AU1100:	name = "Au1100"; break;
-	case CPU_AU1550:	name = "Au1550"; break;
-	case CPU_AU1200:	name = "Au1200"; break;
-	case CPU_AU1210:	name = "Au1210"; break;
-	case CPU_AU1250:	name = "Au1250"; break;
-	case CPU_4KEC:		name = "MIPS 4KEc"; break;
-	case CPU_4KSC:		name = "MIPS 4KSc"; break;
-	case CPU_VR41XX:	name = "NEC Vr41xx"; break;
-	case CPU_R5500:		name = "R5500"; break;
-	case CPU_TX49XX:	name = "TX49xx"; break;
-	case CPU_20KC:		name = "MIPS 20Kc"; break;
-	case CPU_24K:		name = "MIPS 24K"; break;
-	case CPU_25KF:		name = "MIPS 25Kf"; break;
-	case CPU_34K:		name = "MIPS 34K"; break;
-	case CPU_1004K:		name = "MIPS 1004K"; break;
-	case CPU_74K:		name = "MIPS 74K"; break;
-	case CPU_VR4111:	name = "NEC VR4111"; break;
-	case CPU_VR4121:	name = "NEC VR4121"; break;
-	case CPU_VR4122:	name = "NEC VR4122"; break;
-	case CPU_VR4131:	name = "NEC VR4131"; break;
-	case CPU_VR4133:	name = "NEC VR4133"; break;
-	case CPU_VR4181:	name = "NEC VR4181"; break;
-	case CPU_VR4181A:	name = "NEC VR4181A"; break;
-	case CPU_SR71000:	name = "Sandcraft SR71000"; break;
-	case CPU_BCM3302:	name = "Broadcom BCM3302"; break;
-	case CPU_BCM4710:	name = "Broadcom BCM4710"; break;
-	case CPU_PR4450:	name = "Philips PR4450"; break;
-	case CPU_LOONGSON2:	name = "ICT Loongson-2"; break;
-	default:
+	if (c->cputype > CPU_LAST)
+		BUG();
+	name = mips_cpu_names[c->cputype];
+	if (!name)
 		BUG();
-	}
-
 	return name;
 }
 
-- 
1.5.5.1
