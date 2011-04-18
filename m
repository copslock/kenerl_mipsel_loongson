Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Apr 2011 20:44:14 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:45718 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493122Ab1DRSoJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Apr 2011 20:44:09 +0200
Received: (qmail 24230 invoked from network); 18 Apr 2011 18:44:02 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 18 Apr 2011 18:44:02 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Mon, 18 Apr 2011 11:44:02 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Robert Millan <rmh@gnu.org>,
        David Daney <ddaney@caviumnetworks.com>,
        wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] MIPS: Introduce set_elf_platform() helper function
Date:   Mon, 18 Apr 2011 11:37:55 -0700
Message-Id: <12309140238d597edc0b48cbc07df218@localhost>
User-Agent: vim 7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29782
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
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---

v2: Move the new function into cpu-probe.c .  Retained the "inline"
qualifier because all but one of the other helper functions in
cpu-probe.c use it.

 arch/mips/kernel/cpu-probe.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index f65d4c8..4e4a0fd 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -771,6 +771,12 @@ static void __cpuinit decode_configs(struct cpuinfo_mips *c)
 		c->core = read_c0_ebase() & 0x3ff;
 }
 
+static inline void set_elf_platform(int cpu, const char *plat)
+{
+	if (cpu == 0)
+		__elf_platform = plat;
+}
+
 static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
 {
 	decode_configs(c);
@@ -956,14 +962,12 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
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
