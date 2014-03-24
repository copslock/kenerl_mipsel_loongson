Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 24 Mar 2014 11:21:27 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.89.28.115]:45011 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaCXKUlGCDNa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 24 Mar 2014 11:20:41 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id DF5117F49844C
        for <linux-mips@linux-mips.org>; Mon, 24 Mar 2014 10:20:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:20:35 +0000
Received: from pburton-linux.le.imgtec.org (192.168.154.79) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.174.1; Mon, 24 Mar 2014 10:20:34 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/12] MIPS: remove ifdef around core number probe
Date:   Mon, 24 Mar 2014 10:19:27 +0000
Message-ID: <1395656375-9300-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
References: <1395656375-9300-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.79]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Now that this retrieves the correct value there is no need to skip it
when CONFIG_MIPS_CPS is enabled.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Feel free to apply this as a fixup to "MIPS: Coherent Processing System
SMP implementation", though preferrably after "MIPS: fix core number
detection for MT cores" in order to avoid brokenness.
---
 arch/mips/kernel/cpu-probe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
index 79526b2..3c1a77f 100644
--- a/arch/mips/kernel/cpu-probe.c
+++ b/arch/mips/kernel/cpu-probe.c
@@ -420,13 +420,11 @@ static void decode_configs(struct cpuinfo_mips *c)
 
 	mips_probe_watch_registers(c);
 
-#ifndef CONFIG_MIPS_CPS
 	if (cpu_has_mips_r2) {
 		c->core = read_c0_ebase() & 0x3ff;
 		if (cpu_has_mipsmt)
 			c->core >>= fls(smp_num_siblings) - 1;
 	}
-#endif
 }
 
 #define R4K_OPTS (MIPS_CPU_TLB | MIPS_CPU_4KEX | MIPS_CPU_4K_CACHE \
-- 
1.8.5.3
