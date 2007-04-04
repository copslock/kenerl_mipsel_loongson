Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2007 15:32:19 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:19431 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022004AbXDDObN (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 4 Apr 2007 15:31:13 +0100
Received: (qmail 16930 invoked by uid 511); 4 Apr 2007 14:30:21 -0000
Received: from unknown (HELO heart.lemote.com) (192.168.2.206)
  by lemote.com with SMTP; 4 Apr 2007 14:30:21 -0000
Message-ID: <402414.148531051-sendEmail@heart>
From:	"zhangfx@lemote.com" <zhangfx@lemote.com>
To:	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject:  [PATCH 10/16] make cpu_probe recognize Loongson2
Date:	Wed, 4 Apr 2007 14:38:19 +0000
X-Mailer: sendEmail-1.55
MIME-Version: 1.0
Content-Type: multipart/related; boundary="----MIME delimiter for sendEmail-815403.761881502"
Return-Path: <zhangfx@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14793
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zhangfx@lemote.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format. To properly display this message you need a MIME-Version 1.0 compliant Email program.

------MIME delimiter for sendEmail-815403.761881502
Content-Type: text/plain;
        charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


Signed-off-by: Fuxin Zhang <zhangfx@lemote.com>
---
 arch/mips/kernel/cpu-probe.c |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ab755ea..125c72c 100644
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
1.4.4.4



------MIME delimiter for sendEmail-815403.761881502--
