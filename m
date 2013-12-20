Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Dec 2013 18:44:15 +0100 (CET)
Received: from qmta07.emeryville.ca.mail.comcast.net ([76.96.30.64]:35766 "EHLO
        qmta07.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6867128Ab3LTRoLDJ5vm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Dec 2013 18:44:11 +0100
Received: from omta14.emeryville.ca.mail.comcast.net ([76.96.30.60])
        by qmta07.emeryville.ca.mail.comcast.net with comcast
        id 3qcY1n0051HpZEsA7tk392; Fri, 20 Dec 2013 17:44:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20121106; t=1387561443;
        bh=ZozvllXG9DX4C01hdGkbXTMp1SkjMQdi7NJI3SoArGY=;
        h=Received:Received:Received:Received:Date:From:To:Subject:
         Message-ID:Content-Type;
        b=cHdN2glbBvxjznF9n8ucgIiaxu+3E0yQmLqb3BKrOv60zeCMVlGBwyelM3slzXAnt
         qp+MpcYB+6KsjmzeLNocWjLEThcysxUuJ+8f/iabNuXD3p8N96OCQ63ZjxI1Rf6Ary
         qvntvvMRhEGOgIX+YvkP2QjTTmPrDj7Da7QkowjDxjhOjgYVZOfjTv/4WopyfTVYg0
         NxcLHHO7uBdBxyKrdzMMSfTRpTaB0mXVBCjspftLcdP5VX/VXKiUj2fY+/ZBG7XJ2I
         oROWLgDHQQN5tMqXKyAsI5UOrgfBiZcrH4H9eitVwjpJxKb/JJHzf6/Sf5O+mUpBNy
         5QVchnTDNpFHQ==
Received: from gentwo.org ([98.213.233.247])
        by omta14.emeryville.ca.mail.comcast.net with comcast
        id 3tjz1n00T5Lw0ES8atk0BS; Fri, 20 Dec 2013 17:44:02 +0000
X-Authority-Analysis: v=2.1 cv=dfa5gxne c=1 sm=1 tr=0
 a=P1/czelPj/zYsqkqtI4LGg==:117 a=P1/czelPj/zYsqkqtI4LGg==:17 a=PuvxfXWCAAAA:8
 a=C_IRinGWAAAA:8 a=GGcpBh7Jt_oA:10 a=-WwNHMU88Q4A:10 a=WuCusnQs47UA:10
 a=wPDyFdB5xvgA:10 a=NufY4J3AAAAA:8 a=KzMNtAa5ikUA:10 a=nlC_4_pT8q9DhB4Ho9EA:9
 a=cz2ZRIgtxKwA:10 a=wJWlkF7cXJYA:10 a=jP3r5qrIOmJWLxy-jIAA:9
 a=CjuIK1q_8ugA:10 a=bLOH0to22SMA:10 a=5mp-4R8GUREA:10 a=zAyngx5bAAAA:8
 a=VAFAUJkowcUm3wKbofEA:9 a=kt2o4b_9nEejsCxR:21 a=tHNyf73kXbzlcCHq:21
 a=9g6PTisfegMA:10
Received: by gentwo.org (Postfix, from userid 1001)
        id 5E98630F04; Fri, 20 Dec 2013 11:43:59 -0600 (CST)
Received: from localhost (localhost [127.0.0.1])
        by gentwo.org (Postfix) with ESMTP id 5C50A1FF23;
        Fri, 20 Dec 2013 11:43:59 -0600 (CST)
Date:   Fri, 20 Dec 2013 11:43:59 -0600 (CST)
From:   Christoph Lameter <cl@linux.com>
X-X-Sender: cl@nuc
To:     David Daney <ddaney.cavm@gmail.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Tejun Heo <tj@kernel.org>, akpm@linuxfoundation.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 29/40] mips: Replace __get_cpu_var uses
In-Reply-To: <52B37C56.7090302@gmail.com>
Message-ID: <alpine.DEB.2.10.1312201143010.10717@nuc>
References: <20131219155015.443763038@linux.com> <20131219155033.834416420@linux.com> <52B330F3.4090603@gmail.com> <alpine.DEB.2.10.1312191506370.17603@nuc> <52B37C56.7090302@gmail.com>
Content-Type: MULTIPART/Mixed; BOUNDARY=------------070507070702050801040409
Content-ID: <alpine.DEB.2.10.1312201143011.10717@nuc>
Return-Path: <cl@linux.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cl@linux.com
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

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--------------070507070702050801040409
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII; FORMAT=flowed
Content-ID: <alpine.DEB.2.10.1312201143012.10717@nuc>

On Thu, 19 Dec 2013, David Daney wrote:

> See the attached patch.  Feel free to include it as part of your patch set.

Looks good. I will place this before the mips patch.
--------------070507070702050801040409
Content-Type: TEXT/X-PATCH; NAME=0001-MIPS-Replace-__get_cpu_var-uses-in-FPU-emulator.patch
Content-ID: <alpine.DEB.2.10.1312201143013.10717@nuc>
Content-Description: 
Content-Disposition: ATTACHMENT; FILENAME*0=0001-MIPS-Replace-__get_cpu_var-uses-in-FPU-emulator.patch

>From cc9590cf4d75cf7fd36a58be132d35fbbe536a64 Mon Sep 17 00:00:00 2001
From: David Daney <david.daney@cavium.com>
Date: Thu, 19 Dec 2013 14:00:17 -0800
Subject: [PATCH] MIPS: Replace __get_cpu_var uses in FPU emulator.

The use of __this_cpu_inc() requires a fundamental integer type, so
change the type of all the counters to unsigned long, which is the
same width they were before, but not wrapped in local_t.

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/fpu_emulator.h | 14 +++++++-------
 arch/mips/math-emu/cp1emu.c          |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/fpu_emulator.h b/arch/mips/include/asm/fpu_emulator.h
index 2abb587..619fa5f 100644
--- a/arch/mips/include/asm/fpu_emulator.h
+++ b/arch/mips/include/asm/fpu_emulator.h
@@ -30,12 +30,12 @@
 #ifdef CONFIG_DEBUG_FS
 
 struct mips_fpu_emulator_stats {
-	local_t emulated;
-	local_t loads;
-	local_t stores;
-	local_t cp1ops;
-	local_t cp1xops;
-	local_t errors;
+	unsigned long emulated;
+	unsigned long loads;
+	unsigned long stores;
+	unsigned long cp1ops;
+	unsigned long cp1xops;
+	unsigned long errors;
 };
 
 DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
@@ -43,7 +43,7 @@ DECLARE_PER_CPU(struct mips_fpu_emulator_stats, fpuemustats);
 #define MIPS_FPU_EMU_INC_STATS(M)					\
 do {									\
 	preempt_disable();						\
-	__local_inc(&__get_cpu_var(fpuemustats).M);			\
+	__this_cpu_inc(fpuemustats.M);					\
 	preempt_enable();						\
 } while (0)
 
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index efe0088..b853d05 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -2110,13 +2110,13 @@ int fpu_emulator_cop1Handler(struct pt_regs *xcp, struct mips_fpu_struct *ctx,
 static int fpuemu_stat_get(void *data, u64 *val)
 {
 	int cpu;
-	unsigned long sum = 0;
+	u64 sum = 0;
 	for_each_online_cpu(cpu) {
 		struct mips_fpu_emulator_stats *ps;
-		local_t *pv;
+		unsigned long *pv;
 		ps = &per_cpu(fpuemustats, cpu);
 		pv = (void *)ps + (unsigned long)data;
-		sum += local_read(pv);
+		sum += *pv;
 	}
 	*val = sum;
 	return 0;
-- 
1.7.11.7


--------------070507070702050801040409--
