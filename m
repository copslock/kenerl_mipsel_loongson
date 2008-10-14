Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Oct 2008 10:01:31 +0100 (BST)
Received: from h4.dl5rb.org.uk ([81.2.74.4]:45466 "EHLO
	ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk") by ftp.linux-mips.org
	with ESMTP id S21453693AbYJNJB3 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 14 Oct 2008 10:01:29 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by ditditdahdahdah-dahdahdahditdit.dl5rb.org.uk (8.14.2/8.14.1) with ESMTP id m9E919D7000810;
	Tue, 14 Oct 2008 10:01:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.2/8.14.2/Submit) id m9E919xQ000809;
	Tue, 14 Oct 2008 10:01:09 +0100
Date:	Tue, 14 Oct 2008 10:01:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@caviumnetworks.com>
Cc:	linux-mips@linux-mips.org,
	"Paoletti, Tomaso" <Tomaso.Paoletti@caviumnetworks.com>
Subject: Re: [PATCH] MIPS: Rewrite cpu_to_name so it has one statement per
	line.
Message-ID: <20081014090109.GB30880@linux-mips.org>
References: <48F38CBE.20303@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48F38CBE.20303@caviumnetworks.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 13, 2008 at 11:00:30AM -0700, David Daney wrote:

> Rewrite cpu_to_name so it has one statement per line.
>
> Future changes can now pass checkpatch.pl

It's been one of those changes where I found the Linux coding style in my
opinion at least, not to be optimal.  My plan was to rewrite it like below
incomplete patch for ages.  What do you think?

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 744cd8f..6d0f891 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -75,6 +75,7 @@ struct cpuinfo_mips {
 	unsigned int		watch_reg_use_cnt; /* Usable by ptrace */
 #define NUM_WATCH_REGS 4
 	u16			watch_reg_masks[NUM_WATCH_REGS];
+	const char		*name;
 } __attribute__((aligned(SMP_CACHE_BYTES)));
 
 extern struct cpuinfo_mips cpu_data[];
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 0cf1545..b05f9a3 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -291,6 +291,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c)
 	switch (c->processor_id & 0xff00) {
 	case PRID_IMP_R2000:
 		c->cputype = CPU_R2000;
+		c->name = "R2000A";
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 		             MIPS_CPU_NOFPUEX;
@@ -300,12 +301,17 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c)
 		break;
 	case PRID_IMP_R3000:
 		if ((c->processor_id & 0xff) == PRID_REV_R3000A)
-			if (cpu_has_confreg())
+			if (cpu_has_confreg()) {
 				c->cputype = CPU_R3081E;
-			else
+				c->name = "R3081E";
+			} else {
 				c->cputype = CPU_R3000A;
-		else
+				c->name = "R3000A";
+			}
+		else {
 			c->cputype = CPU_R3000;
+			c->name = "R3000";
+		}
 		c->isa_level = MIPS_CPU_ISA_I;
 		c->options = MIPS_CPU_TLB | MIPS_CPU_3K_CACHE |
 		             MIPS_CPU_NOFPUEX;
@@ -315,15 +321,21 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c)
 		break;
 	case PRID_IMP_R4000:
 		if (read_c0_config() & CONF_SC) {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400)
+			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400PC;
-			else
+				c->name = "R4400PC";
+			} else {
 				c->cputype = CPU_R4000PC;
+				c->name = "R4000PC";
+			}
 		} else {
-			if ((c->processor_id & 0xff) >= PRID_REV_R4400)
+			if ((c->processor_id & 0xff) >= PRID_REV_R4400) {
 				c->cputype = CPU_R4400SC;
-			else
+				c->name = "R4400SC";
+			} else {
 				c->cputype = CPU_R4000SC;
+				c->name = "R4000SC";
+			}
 		}
 
 		c->isa_level = MIPS_CPU_ISA_III;
@@ -822,83 +834,9 @@ const char *__cpu_name[NR_CPUS];
  */
 static __cpuinit const char *cpu_to_name(struct cpuinfo_mips *c)
 {
-	const char *name = NULL;
+	const char *name = c->name;
 
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
-		BUG();
-	}
+	BUG_ON(!name);
 
 	return name;
 }
