Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 17:11:36 +0200 (CEST)
Received: from mail-pd0-f180.google.com ([209.85.192.180]:48325 "EHLO
        mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3HAPLXfPk7M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Aug 2013 17:11:23 +0200
Received: by mail-pd0-f180.google.com with SMTP id 15so2117298pdi.25
        for <multiple recipients>; Thu, 01 Aug 2013 08:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=w1+zwYLXTvVtA/1BOKrDrg4ftVLJ3u3DDQw0yRlYl/k=;
        b=cyh0TOv4LPlgY6GfGg16IIUT9aZihOfZCuqiEDL1ycS7hC/c6CFlX6HtM9KtR0ESWJ
         3XGim3HmTBz3W/S68l2jr9IcGS+dhY0vUE5zcy1WngKc43ox/eCD5AV332gpeozUU42V
         wPOzX6Evid4+PGlZ4cYkH+ALnYE7MNBVOvPg44k/pI3oQCEcF1/YvDwtr5RlMVlgZ/Bf
         g/jr/j1KfJbNS4uGOunm8atkwlK1lBhv/Uq3LTWls63DF5ZHK4PUqV/v2+0CUgx12RX7
         PKTd1YT2PcqQOfna9HYN0SQMTWntOTFl/kDOaVw3wcs+JNr7o1g62EnmssyAbfyX0ppT
         7ddQ==
X-Received: by 10.66.2.130 with SMTP id 2mr4876036pau.13.1375369876463;
        Thu, 01 Aug 2013 08:11:16 -0700 (PDT)
Received: from localhost.localdomain ([115.111.18.195])
        by mx.google.com with ESMTPSA id ep4sm4575198pbd.35.2013.08.01.08.11.13
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 01 Aug 2013 08:11:15 -0700 (PDT)
From:   Jerin Jacob <jerinjacobk@gmail.com>
To:     ralf@linux-mips.org
Cc:     Jerin Jacob <jerinjacobk@gmail.com>, linux-mips@linux-mips.org,
        mbhat@netlogicmicro.com, jchandra@broadcom.com
Subject: [PATCH] MIPS: oprofile: Fix for BUG: using smp_processor_id() in preemptible [00000000] code: oprofiled/1362
Date:   Thu,  1 Aug 2013 20:40:41 +0530
Message-Id: <1375369841-16427-1-git-send-email-jerinjacobk@gmail.com>
X-Mailer: git-send-email 1.7.6.5
Return-Path: <jerinjacobk@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37419
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jerinjacobk@gmail.com
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

current_cpu_type() is not preemption-safe.
If CONFIG_PREEMPT is enabled then mipsxx_reg_setup() can be called from preemptible state.
Added get_cpu()/put_cpu() pair to make it preemption-safe.

This was found while testing oprofile with CONFIG_DEBUG_PREEMPT enable.

/usr/zntestsuite # opcontrol --init
/usr/zntestsuite # opcontrol --setup --event=L2_CACHE_ACCESSES:500 --event=L2_CACHE_MISSES:500 --no-vmlinux
/usr/zntestsuite # opcontrol --start
Using 2.6+ OProfile kernel interface.
BUG: using smp_processor_id() in preemptible [00000000] code: oprofiled/1362
caller is mipsxx_reg_setup+0x11c/0x164
CPU: 0 PID: 1362 Comm: oprofiled Not tainted 3.10.4 #18
Stack : 00000006 70757465 00000000 00000000 00000000 00000000 80b173f6 00000037
          80b10000 00000000 80b21614 88f5a220 00000000 00000000 00000000 00000000
          00000000 00000000 00000000 00000000 00000000 00000000 00000000 00000000
          00000000 00000000 00000000 89c49c00 89c49c2c 80721254 807b7927 8012c1d0
          80b10000 80721254 00000000 00000552 88f5a220 80b1335c 807b78e6 89c49ba8
          ...
Call Trace:
[<801099a4>] show_stack+0x64/0x7c
[<80665520>] dump_stack+0x20/0x2c
[<803a2250>] debug_smp_processor_id+0xe0/0xf0
[<8052df24>] mipsxx_reg_setup+0x11c/0x164
[<8052cd70>] op_mips_setup+0x24/0x4c
[<80529cfc>] oprofile_setup+0x5c/0x12c
[<8052b9f8>] event_buffer_open+0x78/0xf8
[<801c3150>] do_dentry_open.isra.15+0x2b8/0x3b0
[<801c3270>] finish_open+0x28/0x4c
[<801d49b8>] do_last.isra.41+0x2cc/0xd00
[<801d54a0>] path_openat+0xb4/0x4c4
[<801d5c44>] do_filp_open+0x3c/0xac
[<801c4744>] do_sys_open+0x110/0x1f4
[<8010f47c>] stack_done+0x20/0x44

Signed-off-by: Jerin Jacob <jerinjacobk@gmail.com>
---
 arch/mips/oprofile/op_model_mipsxx.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index e4b1140..20a80ea 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -147,7 +147,7 @@ static struct mipsxx_register_config {
 
 static void mipsxx_reg_setup(struct op_counter_config *ctr)
 {
-	unsigned int counters = op_model_mipsxx_ops.num_counters;
+	unsigned int curr_cpu, counters = op_model_mipsxx_ops.num_counters;
 	int i;
 
 	/* Compute the performance counter control word.  */
@@ -166,8 +166,10 @@ static void mipsxx_reg_setup(struct op_counter_config *ctr)
 			reg.control[i] |= M_PERFCTL_USER;
 		if (ctr[i].exl)
 			reg.control[i] |= M_PERFCTL_EXL;
-		if (current_cpu_type() == CPU_XLR)
+		curr_cpu = get_cpu();
+		if (cpu_data[curr_cpu].cputype == CPU_XLR)
 			reg.control[i] |= M_PERFCTL_COUNT_ALL_THREADS;
+		put_cpu();
 		reg.counter[i] = 0x80000000 - ctr[i].count;
 	}
 }
-- 
1.7.6.5
