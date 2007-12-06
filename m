Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Dec 2007 08:09:06 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:44298 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20022323AbXLFII4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 6 Dec 2007 08:08:56 +0000
Received: (qmail 20550 invoked by uid 1000); 6 Dec 2007 09:07:55 +0100
Date:	Thu, 6 Dec 2007 09:07:55 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [RFC PATCH] Alchemy: Au1210/Au1250 CPU support
Message-ID: <20071206080755.GA20485@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17715
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

This patch adds IDs fornew Au1200 variants: Au1210 and Au1250.
They are essentially identical to the Au1200 except for the Au1210
which has a different SoC-ID in the PRId register [bits 31:24].
The Au1250 is a "Au1200 V0.2".

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>

--- linux-2.6.24-rc4/include/asm-mips/cpu.h	2007-12-04 08:33:33.143002000 +0100
+++ linux-2.6.24-rc4-work/include/asm-mips/cpu.h	2007-12-06 16:28:48.000000000 +0100
@@ -195,8 +195,8 @@ enum cpu_type_enum {
 	 * MIPS32 class processors
 	 */
 	CPU_4KC, CPU_4KEC, CPU_4KSC, CPU_24K, CPU_34K, CPU_74K, CPU_AU1000,
-	CPU_AU1100, CPU_AU1200, CPU_AU1500, CPU_AU1550, CPU_PR4450,
-	CPU_BCM3302, CPU_BCM4710,
+	CPU_AU1100, CPU_AU1200, CPU_AU1210, CPU_AU1250, CPU_AU1500, CPU_AU1550,
+	CPU_PR4450, CPU_BCM3302, CPU_BCM4710,
 
 	/*
 	 * MIPS64 class processors
--- linux-2.6.24-rc4/arch/mips/kernel/cpu-probe.c	2007-12-04 08:33:00.793002000 +0100
+++ linux-2.6.24-rc4-work/arch/mips/kernel/cpu-probe.c	2007-12-06 16:27:06.000000000 +0100
@@ -188,6 +188,8 @@ static inline void check_wait(void)
 	case CPU_AU1500:
 	case CPU_AU1550:
 	case CPU_AU1200:
+	case CPU_AU1210:
+	case CPU_AU1250:
 		if (allow_au1k_wait)
 			cpu_wait = au1k_wait;
 		break;
@@ -733,6 +735,11 @@ static inline void cpu_probe_alchemy(str
 			break;
 		case 4:
 			c->cputype = CPU_AU1200;
+			if (2 == (c->processor_id & 0xff))
+				c->cputype = CPU_AU1250;
+			break;
+		case 5:
+			c->cputype = CPU_AU1210;
 			break;
 		default:
 			panic("Unknown Au Core!");
@@ -858,6 +865,8 @@ static __init const char *cpu_to_name(st
 	case CPU_AU1100:	name = "Au1100"; break;
 	case CPU_AU1550:	name = "Au1550"; break;
 	case CPU_AU1200:	name = "Au1200"; break;
+	case CPU_AU1210:	name = "Au1210"; break;
+	case CPU_AU1250:	name = "Au1250"; break;
 	case CPU_4KEC:		name = "MIPS 4KEc"; break;
 	case CPU_4KSC:		name = "MIPS 4KSc"; break;
 	case CPU_VR41XX:	name = "NEC Vr41xx"; break;
--- linux-2.6.24-rc4/arch/mips/mm/c-r4k.c	2007-12-04 08:33:00.963002000 +0100
+++ linux-2.6.24-rc4-work/arch/mips/mm/c-r4k.c	2007-12-06 16:44:07.000000000 +0100
@@ -989,6 +989,8 @@ static void __init probe_pcache(void)
 	case CPU_AU1100:
 	case CPU_AU1550:
 	case CPU_AU1200:
+	case CPU_AU1210:
+	case CPU_AU1250:
 		c->icache.flags |= MIPS_CACHE_IC_F_DC;
 		break;
 	}
--- linux-2.6.24-rc4/arch/mips/mm/tlbex.c	2007-12-04 08:33:00.983002000 +0100
+++ linux-2.6.24-rc4-work/arch/mips/mm/tlbex.c	2007-12-06 16:44:30.000000000 +0100
@@ -894,6 +894,8 @@ static __init void build_tlb_write_entry
 	case CPU_AU1500:
 	case CPU_AU1550:
 	case CPU_AU1200:
+	case CPU_AU1210:
+	case CPU_AU1250:
 	case CPU_PR4450:
 		i_nop(p);
 		tlbw(p);
