Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Oct 2008 19:00:54 +0100 (BST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:26066 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S21405438AbYJMSAt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 13 Oct 2008 19:00:49 +0100
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B48f38cc20000>; Mon, 13 Oct 2008 14:00:34 -0400
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 11:00:31 -0700
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 13 Oct 2008 11:00:31 -0700
Message-ID: <48F38CBE.20303@caviumnetworks.com>
Date:	Mon, 13 Oct 2008 11:00:30 -0700
From:	David Daney <ddaney@caviumnetworks.com>
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per line.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 13 Oct 2008 18:00:31.0048 (UTC) FILETIME=[94EC1C80:01C92D5D]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

Rewrite cpu_to_name so it has one statement per line.

Future changes can now pass checkpatch.pl

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/mips/kernel/cpu-probe.c |  217 +++++++++++++++++++++++++++--------------
 1 files changed, 143 insertions(+), 74 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0cf1545..1e57d04 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -822,85 +822,154 @@ const char *__cpu_name[NR_CPUS];
  */
 static __cpuinit const char *cpu_to_name(struct cpuinfo_mips *c)
 {
-	const char *name = NULL;
-
 	switch (c->cputype) {
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
+	case CPU_UNKNOWN:
+		return "unknown";
+	case CPU_R2000:
+		return "R2000";
+	case CPU_R3000:
+		return "R3000";
+	case CPU_R3000A:
+		return "R3000A";
+	case CPU_R3041:
+		return "R3041";
+	case CPU_R3051:
+		return "R3051";
+	case CPU_R3052:
+		return "R3052";
+	case CPU_R3081:
+		return "R3081";
+	case CPU_R3081E:
+		return "R3081E";
+	case CPU_R4000PC:
+		return "R4000PC";
+	case CPU_R4000SC:
+		return "R4000SC";
+	case CPU_R4000MC:
+		return "R4000MC";
+	case CPU_R4200:
+		return "R4200";
+	case CPU_R4400PC:
+		return "R4400PC";
+	case CPU_R4400SC:
+		return "R4400SC";
+	case CPU_R4400MC:
+		return "R4400MC";
+	case CPU_R4600:
+		return "R4600";
+	case CPU_R6000:
+		return "R6000";
+	case CPU_R6000A:
+		return "R6000A";
+	case CPU_R8000:
+		return "R8000";
+	case CPU_R10000:
+		return "R10000";
+	case CPU_R12000:
+		return "R12000";
+	case CPU_R14000:
+		return "R14000";
+	case CPU_R4300:
+		return "R4300";
+	case CPU_R4650:
+		return "R4650";
+	case CPU_R4700:
+		return "R4700";
+	case CPU_R5000:
+		return "R5000";
+	case CPU_R5000A:
+		return "R5000A";
+	case CPU_R4640:
+		return "R4640";
+	case CPU_NEVADA:
+		return "Nevada";
+	case CPU_RM7000:
+		return "RM7000";
+	case CPU_RM9000:
+		return "RM9000";
+	case CPU_R5432:
+		return "R5432";
+	case CPU_4KC:
+		return "MIPS 4Kc";
+	case CPU_5KC:
+		return "MIPS 5Kc";
+	case CPU_R4310:
+		return "R4310";
+	case CPU_SB1:
+		return "SiByte SB1";
+	case CPU_SB1A:
+		return "SiByte SB1A";
+	case CPU_TX3912:
+		return "TX3912";
+	case CPU_TX3922:
+		return "TX3922";
+	case CPU_TX3927:
+		return "TX3927";
+	case CPU_AU1000:
+		return "Au1000";
+	case CPU_AU1500:
+		return "Au1500";
+	case CPU_AU1100:
+		return "Au1100";
+	case CPU_AU1550:
+		return "Au1550";
+	case CPU_AU1200:
+		return "Au1200";
+	case CPU_AU1210:
+		return "Au1210";
+	case CPU_AU1250:
+		return "Au1250";
+	case CPU_4KEC:
+		return "MIPS 4KEc";
+	case CPU_4KSC:
+		return "MIPS 4KSc";
+	case CPU_VR41XX:
+		return "NEC Vr41xx";
+	case CPU_R5500:
+		return "R5500";
+	case CPU_TX49XX:
+		return "TX49xx";
+	case CPU_20KC:
+		return "MIPS 20Kc";
+	case CPU_24K:
+		return "MIPS 24K";
+	case CPU_25KF:
+		return "MIPS 25Kf";
+	case CPU_34K:
+		return "MIPS 34K";
+	case CPU_1004K:
+		return "MIPS 1004K";
+	case CPU_74K:
+		return "MIPS 74K";
+	case CPU_VR4111:
+		return "NEC VR4111";
+	case CPU_VR4121:
+		return "NEC VR4121";
+	case CPU_VR4122:
+		return "NEC VR4122";
+	case CPU_VR4131:
+		return "NEC VR4131";
+	case CPU_VR4133:
+		return "NEC VR4133";
+	case CPU_VR4181:
+		return "NEC VR4181";
+	case CPU_VR4181A:
+		return "NEC VR4181A";
+	case CPU_SR71000:
+		return "Sandcraft SR71000";
+	case CPU_BCM3302:
+		return "Broadcom BCM3302";
+	case CPU_BCM4710:
+		return "Broadcom BCM4710";
+	case CPU_PR4450:
+		return "Philips PR4450";
+	case CPU_LOONGSON2:
+		return "ICT Loongson-2";
 	default:
 		BUG();
 	}
 
-	return name;
+	return NULL;
 }
 
 __cpuinit void cpu_probe(void)
