Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Aug 2013 18:31:18 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:39487 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824758Ab3HAQbLgOL8r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Aug 2013 18:31:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r71GV7oB011113;
        Thu, 1 Aug 2013 18:31:07 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r71GV6XG011112;
        Thu, 1 Aug 2013 18:31:06 +0200
Date:   Thu, 1 Aug 2013 18:31:05 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jerin Jacob <jerinjacobk@gmail.com>
Cc:     linux-mips@linux-mips.org, mbhat@netlogicmicro.com,
        jchandra@broadcom.com
Subject: Re: [PATCH] MIPS: oprofile: Fix for BUG: using smp_processor_id() in
 preemptible [00000000] code: oprofiled/1362
Message-ID: <20130801163105.GC23583@linux-mips.org>
References: <1375369841-16427-1-git-send-email-jerinjacobk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1375369841-16427-1-git-send-email-jerinjacobk@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Aug 01, 2013 at 08:40:41PM +0530, Jerin Jacob wrote:

> current_cpu_type() is not preemption-safe.
> If CONFIG_PREEMPT is enabled then mipsxx_reg_setup() can be called from preemptible state.
> Added get_cpu()/put_cpu() pair to make it preemption-safe.
> 
> This was found while testing oprofile with CONFIG_DEBUG_PREEMPT enable.
[...]

Interesting.  I wonder how many more of this kind of bug we got lurking
around.

In case of oprofile, we silently assume that all processors have the same
number of counters, the same style and number of counters.  So it'd be
ok to just look at the boot CPU which is even simpler than your fix.

What do you think about below fix?

Thanks,

  Ralf

 arch/mips/include/asm/cpu-features.h | 2 ++
 arch/mips/oprofile/op_model_mipsxx.c | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-features.h b/arch/mips/include/asm/cpu-features.h
index 1dc0860..fa44f3e 100644
--- a/arch/mips/include/asm/cpu-features.h
+++ b/arch/mips/include/asm/cpu-features.h
@@ -17,6 +17,8 @@
 #define current_cpu_type()	current_cpu_data.cputype
 #endif
 
+#define boot_cpu_type()		cpu_data[0].cputype
+
 /*
  * SMP assumption: Options of CPU 0 are a superset of all processors.
  * This is true for all known MIPS systems.
diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index e4b1140..3a2b6e9 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -166,7 +166,7 @@ static void mipsxx_reg_setup(struct op_counter_config *ctr)
 			reg.control[i] |= M_PERFCTL_USER;
 		if (ctr[i].exl)
 			reg.control[i] |= M_PERFCTL_EXL;
-		if (current_cpu_type() == CPU_XLR)
+		if (boot_cpu_type() == CPU_XLR)
 			reg.control[i] |= M_PERFCTL_COUNT_ALL_THREADS;
 		reg.counter[i] = 0x80000000 - ctr[i].count;
 	}
