Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 20:37:51 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:59228 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491109Ab1DPShZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Apr 2011 20:37:25 +0200
Received: (qmail 27922 invoked from network); 16 Apr 2011 18:37:19 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Apr 2011 18:37:19 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Apr 2011 11:37:19 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Robert Millan <rmh@gnu.org>,
        David Daney <ddaney@caviumnetworks.com>,
        wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] MIPS: Introduce set_elf_platform() helper function
Date:   Sat, 16 Apr 2011 11:29:27 -0700
Message-Id: <f571cce5cf7793777f8303cea5e9628f@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

From: Robert Millan <rmh@gnu.org>

Replace these sequences:

if (cpu == 0)
	__elf_platform = "foo";

with a trivial inline function.

Signed-off-by: Robert Millan <rmh@gnu.org>
Acked-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/include/asm/elf.h  |    6 ++++++
 arch/mips/kernel/cpu-probe.c |    6 ++----
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 455c0ac..455da05 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -348,6 +348,12 @@ extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
 #define ELF_PLATFORM  __elf_platform
 extern const char *__elf_platform;
 
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu == 0)
+		__elf_platform = plat;
+}
+
 /*
  * See comments in asm-alpha/elf.h, this is the same thing
  * on the MIPS.
diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f65d4c8..5633ab1 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -956,14 +956,12 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
 		c->cputype = CPU_CAVIUM_OCTEON_PLUS;
 		__cpu_name[cpu] = "Cavium Octeon+";
 platform:
-		if (cpu == 0)
-			__elf_platform = "octeon";
+		set_elf_platform(cpu, "octeon");
 		break;
 	case PRID_IMP_CAVIUM_CN63XX:
 		c->cputype = CPU_CAVIUM_OCTEON2;
 		__cpu_name[cpu] = "Cavium Octeon II";
-		if (cpu == 0)
-			__elf_platform = "octeon2";
+		set_elf_platform(cpu, "octeon2");
 		break;
 	default:
 		printk(KERN_INFO "Unknown Octeon chip!\n");
-- 
1.7.4.3
