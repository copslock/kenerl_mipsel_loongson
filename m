Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 20:38:16 +0200 (CEST)
Received: from [69.28.251.93] ([69.28.251.93]:59235 "EHLO b32.net"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491115Ab1DPSh0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 16 Apr 2011 20:37:26 +0200
Received: (qmail 27986 invoked from network); 16 Apr 2011 18:37:23 -0000
Received: from localhost (HELO vps-1001064-677.cp.jvds.com) (127.0.0.1)
  by localhost with (DHE-RSA-AES128-SHA encrypted) SMTP; 16 Apr 2011 18:37:23 -0000
Received: by vps-1001064-677.cp.jvds.com (sSMTP sendmail emulation); Sat, 16 Apr 2011 11:37:23 -0700
From:   Kevin Cernekee <cernekee@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Robert Millan <rmh@gnu.org>,
        David Daney <ddaney@caviumnetworks.com>,
        wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] MIPS: Set ELF AT_PLATFORM string for Loongson2 processors
Date:   Sat, 16 Apr 2011 11:29:29 -0700
Message-Id: <a1275ec38fac95ce721717488dcaeb3a@localhost>
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
X-archive-position: 29771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
Precedence: bulk
X-list: linux-mips

From: Robert Millan <rmh@gnu.org>

Signed-off-by: Robert Millan <rmh@gnu.org>
Acked-by: David Daney <ddaney@caviumnetworks.com>
Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 arch/mips/kernel/cpu-probe.c |   10 ++++++++++
 1 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index e3cf292..27ef0fc 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -614,6 +614,16 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 	case PRID_IMP_LOONGSON2:
 		c->cputype = CPU_LOONGSON2;
 		__cpu_name[cpu] = "ICT Loongson-2";
+
+		switch (c->processor_id & PRID_REV_MASK) {
+		case PRID_REV_LOONGSON2E:
+			set_elf_platform(cpu, "loongson2e");
+			break;
+		case PRID_REV_LOONGSON2F:
+			set_elf_platform(cpu, "loongson2f");
+			break;
+		}
+
 		c->isa_level = MIPS_CPU_ISA_III;
 		c->options = R4K_OPTS |
 			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
-- 
1.7.4.3
