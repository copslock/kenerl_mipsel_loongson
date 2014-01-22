Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Jan 2014 17:22:07 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:21299 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6827391AbaAVQUYfflLI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 22 Jan 2014 17:20:24 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>
Subject: [PATCH v2 4/5] MIPS: Allow FTLB to be turned on for CPU_P5600
Date:   Wed, 22 Jan 2014 16:19:40 +0000
Message-ID: <1390407581-24238-5-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
References: <1390407581-24238-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_01_22_16_20_19
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39071
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Allow FTLB to be turned on or off for CPU_P5600 as well as CPU_PROAPTIV.
The existing if statement is converted into a switch to allow for future
expansion.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/kernel/cpu-probe.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index ef9b415086c8..075ce0caa72c 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -166,11 +166,12 @@ static char unknown_isa[] = KERN_ERR \
 static void set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 {
 	unsigned int config6;
-	/*
-	 * Config6 is implementation dependent and it's currently only
-	 * used by proAptiv
-	 */
-	if (c->cputype == CPU_PROAPTIV) {
+
+	/* It's implementation dependent how the FTLB can be enabled */
+	switch (c->cputype) {
+	case CPU_PROAPTIV:
+	case CPU_P5600:
+		/* proAptiv & related cores use Config6 to enable the FTLB */
 		config6 = read_c0_config6();
 		if (enable)
 			/* Enable FTLB */
@@ -179,6 +180,7 @@ static void set_ftlb_enable(struct cpuinfo_mips *c, int enable)
 			/* Disable FTLB */
 			write_c0_config6(config6 &  ~MIPS_CONF6_FTLBEN);
 		back_to_back_c0_hazard();
+		break;
 	}
 }
 
-- 
1.8.1.2
