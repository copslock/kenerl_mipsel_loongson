Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 06 Jun 2007 07:53:31 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:55945 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20021471AbXFFGxF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 6 Jun 2007 07:53:05 +0100
Received: (qmail 7081 invoked by uid 511); 6 Jun 2007 07:00:19 -0000
Received: from unknown (HELO localhost.localdomain) (192.168.2.233)
  by lemote.com with SMTP; 6 Jun 2007 07:00:19 -0000
From:	tiansm@lemote.com
To:	linux-mips@linux-mips.org
Cc:	Fuxin Zhang <zhangfx@lemote.com>
Subject: [PATCH 10/15] make cpu_probe recognize Loongson2
Date:	Wed,  6 Jun 2007 14:52:47 +0800
Message-Id: <11811127742180-git-send-email-tiansm@lemote.com>
X-Mailer: git-send-email 1.5.2.1
In-Reply-To: <11811127722019-git-send-email-tiansm@lemote.com>
References: <11811127722019-git-send-email-tiansm@lemote.com>
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15282
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

From: Fuxin Zhang <zhangfx@lemote.com>

Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ab755ea..c9e3637 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -464,6 +464,14 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c)
 		             MIPS_CPU_LLSC;
 		c->tlbsize = 64;
 		break;
+	case PRID_IMP_LOONGSON2:
+		c->cputype = CPU_LOONGSON2;
+		c->isa_level = MIPS_CPU_ISA_III;
+		c->options = R4K_OPTS |
+			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
+			     MIPS_CPU_32FPR;
+		c->tlbsize = 64;
+		break;
 	}
 }
 
-- 
1.5.2.1
