Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Sep 2013 14:35:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39265 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818702Ab3IWMfb72CXy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Sep 2013 14:35:31 +0200
Date:   Mon, 23 Sep 2013 13:35:31 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Jonas Gorski <jogo@openwrt.org>, Ralf Baechle <ralf@linux-mips.org>
cc:     MIPS Mailing List <linux-mips@linux-mips.org>
Subject: [PATCH v2] MIPS: Tell R4k SC and MC variations apart
In-Reply-To: <CAOiHx==GRTP3FpSfPG9yUc50mZBvrzjnXnGMXA6A5WSBRXbp3g@mail.gmail.com>
Message-ID: <alpine.LFD.2.03.1309231332500.16797@linux-mips.org>
References: <alpine.LFD.2.03.1309222307440.16797@linux-mips.org> <CAOiHx==GRTP3FpSfPG9yUc50mZBvrzjnXnGMXA6A5WSBRXbp3g@mail.gmail.com>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

There is no reliable way to tell R4000/R4400 SC and MC variations apart,
however simple heuristic should give good results.  Only the MC version
supports coherent caching so we can rely on such a mode having been set
for KSEG0 by the power-on firmware to reliably indicate an MC processor.
SC processors reportedly hang on coherent cached memory accesses and Linux
is linked to a cached load address so the firmware has to use the correct
caching mode to download the kernel image in a cached mode successfully.

OTOH if the firmware chooses to use either the non-coherent cached or the
uncached mode for KSEG0 on an MC processor, then the SC variant will be
reported, just as we currently do, so no regression here.

Signed-off-by: Maciej W. Rozycki <macro@linux-mips.org>
---
> > +                               c->cputype = mc ? CPU_R4000MC : CPU_R4000SC;
> > +                               __cpu_name[cpu] = mc ? "R4400SC" : "R4000SC";
> 
> I guess the first one should be "R4000MC", not "R4400SC".

 Good catch, thanks, here's an update.

  Maciej

linux-mips-r4k-mc.patch
Index: linux/arch/mips/kernel/cpu-probe.c
===================================================================
--- linux.orig/arch/mips/kernel/cpu-probe.c
+++ linux/arch/mips/kernel/cpu-probe.c
@@ -362,13 +362,33 @@ static inline void cpu_probe_legacy(stru
 				__cpu_name[cpu] = "R4000PC";
 			}
 		} else {
+			int cca = read_c0_config() & CONF_CM_CMASK;
+			int mc;
+
+			/*
+			 * SC and MC versions can't be reliably told apart,
+			 * but only the latter support coherent caching
+			 * modes so assume the firmware has set the KSEG0
+			 * coherency attribute reasonably (if uncached, we
+			 * assume SC).
+			 */
+			switch (cca) {
+			case CONF_CM_CACHABLE_CE:
+			case CONF_CM_CACHABLE_COW:
+			case CONF_CM_CACHABLE_CUW:
+				mc = 1;
+				break;
+			default:
+				mc = 0;
+				break;
+			}
 			if ((c->processor_id & PRID_REV_MASK) >=
 			    PRID_REV_R4400) {
-				c->cputype = CPU_R4400SC;
-				__cpu_name[cpu] = "R4400SC";
+				c->cputype = mc ? CPU_R4400MC : CPU_R4400SC;
+				__cpu_name[cpu] = mc ? "R4400MC" : "R4400SC";
 			} else {
-				c->cputype = CPU_R4000SC;
-				__cpu_name[cpu] = "R4000SC";
+				c->cputype = mc ? CPU_R4000MC : CPU_R4000SC;
+				__cpu_name[cpu] = mc ? "R4400MC" : "R4000SC";
 			}
 		}
 
