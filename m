Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Feb 2013 07:39:16 +0100 (CET)
Received: from mo10.iij4u.or.jp ([210.138.174.78]:58980 "EHLO mo.iij4u.or.jp"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827530Ab3BUGjOTVvWf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Feb 2013 07:39:14 +0100
Received: by mo.iij4u.or.jp (mo10) id r1L6d9hw021022; Thu, 21 Feb 2013 15:39:09 +0900
Received: from delta (sannin29190.nirai.ne.jp [203.160.29.190])
        by mbox.iij4u.or.jp (mbox10) id r1L6d713000384
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Thu, 21 Feb 2013 15:39:09 +0900
Date:   Thu, 21 Feb 2013 15:38:19 +0900
From:   Yoichi Yuasa <yuasa@linux-mips.org>
To:     ralf@linux-mips.org
Cc:     yuasa@linux-mips.org, linux-mips@linux-mips.org
Subject: [PATCH] MIPS: VR4133: add LL/SC support
Message-Id: <20130221153819.b3e9b650d87ffea492679a86@linux-mips.org>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-archive-position: 35801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@linux-mips.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>


Signed-off-by: Yoichi Yuasa <yuasa@linux-mips.org>
---
 arch/mips/kernel/cpu-probe.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 9f31334..44c5aad 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -547,6 +547,9 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 		c->tlbsize = 48;
 		break;
 	case PRID_IMP_VR41XX:
+		c->isa_level = MIPS_CPU_ISA_III;
+		c->options = R4K_OPTS;
+		c->tlbsize = 32;
 		switch (c->processor_id & 0xf0) {
 		case PRID_REV_VR4111:
 			c->cputype = CPU_VR4111;
@@ -571,6 +574,7 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 				__cpu_name[cpu] = "NEC VR4131";
 			} else {
 				c->cputype = CPU_VR4133;
+				c->options |= MIPS_CPU_LLSC;
 				__cpu_name[cpu] = "NEC VR4133";
 			}
 			break;
@@ -580,9 +584,6 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
 			__cpu_name[cpu] = "NEC Vr41xx";
 			break;
 		}
-		c->isa_level = MIPS_CPU_ISA_III;
-		c->options = R4K_OPTS;
-		c->tlbsize = 32;
 		break;
 	case PRID_IMP_R4300:
 		c->cputype = CPU_R4300;
-- 
1.7.9.5
