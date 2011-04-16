Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 20:37:28 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:59226 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491090Ab1DPShZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Apr 2011 20:37:25 +0200
Received: (qmail 27950 invoked from network); 16 Apr 2011 18:37:21 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Apr 2011 18:37:21 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Apr 2011 11:37:21 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Robert Millan <rmh@gnu.org>,
        David Daney <ddaney@caviumnetworks.com>,
        wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] MIPS: Set ELF AT_PLATFORM string for BMIPS processors
Date:   Sat, 16 Apr 2011 11:29:28 -0700
Message-Id: <7f27896d6ff6598a4b9e003454ef10e0@localhost>
In-Reply-To: <f571cce5cf7793777f8303cea5e9628f@localhost>
References: <f571cce5cf7793777f8303cea5e9628f@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29769
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/cpu-probe.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 5633ab1..e3cf292 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -911,12 +911,14 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_BMIPS32_REV8:
 		c->cputype = CPU_BMIPS32;
 		__cpu_name[cpu] = "Broadcom BMIPS32";
+		set_elf_platform(cpu, "bmips32");
 		break;
 	case PRID_IMP_BMIPS3300:
 	case PRID_IMP_BMIPS3300_ALT:
 	case PRID_IMP_BMIPS3300_BUG:
 		c->cputype = CPU_BMIPS3300;
 		__cpu_name[cpu] = "Broadcom BMIPS3300";
+		set_elf_platform(cpu, "bmips3300");
 		break;
 	case PRID_IMP_BMIPS43XX: {
 		int rev = c->processor_id & 0xff;
@@ -925,15 +927,18 @@ static inline void cpu_probe_broadcom(struct cpuinfo_mips *c, unsigned int cpu)
 				rev <= PRID_REV_BMIPS4380_HI) {
 			c->cputype = CPU_BMIPS4380;
 			__cpu_name[cpu] = "Broadcom BMIPS4380";
+			set_elf_platform(cpu, "bmips4380");
 		} else {
 			c->cputype = CPU_BMIPS4350;
 			__cpu_name[cpu] = "Broadcom BMIPS4350";
+			set_elf_platform(cpu, "bmips4350");
 		}
 		break;
 	}
 	case PRID_IMP_BMIPS5000:
 		c->cputype = CPU_BMIPS5000;
 		__cpu_name[cpu] = "Broadcom BMIPS5000";
+		set_elf_platform(cpu, "bmips5000");
 		c->options |= MIPS_CPU_ULRI;
 		break;
 	}
-- 
1.7.4.3
