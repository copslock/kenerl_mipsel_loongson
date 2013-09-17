Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 13:44:04 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46184 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6860907Ab3IQLn6Za1hl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 13:43:58 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r8HBhuGj026335;
        Tue, 17 Sep 2013 13:43:56 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r8HBhuJo026334;
        Tue, 17 Sep 2013 13:43:56 +0200
Date:   Tue, 17 Sep 2013 13:43:56 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix accessing to per-cpu data when flushing the
 cache
Message-ID: <20130917114356.GE22468@linux-mips.org>
References: <1379411005-20829-1-git-send-email-markos.chandras@imgtec.com>
 <20130917104431.GB22468@linux-mips.org>
 <5238353B.9050001@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5238353B.9050001@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37829
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

On Tue, Sep 17, 2013 at 11:55:55AM +0100, Markos Chandras wrote:

> On 09/17/13 11:44, Ralf Baechle wrote:
> >On Tue, Sep 17, 2013 at 10:43:25AM +0100, Markos Chandras wrote:
> >
> >>The cache flushing code uses the current_cpu_data macro which
> >>may cause problems in preemptive kernels because it relies on
> >>smp_processor_id() to get the current cpu number. Per cpu-data
> >>needs to be protected so we disable preemption around the flush
> >>caching code. We enable it back when we are about to return.
> >>
> >>Fixes the following problem:
> >>
> >>BUG: using smp_processor_id() in preemptible [00000000] code: kjournald/1761
> >>caller is blast_dcache32+0x30/0x254
> >
> >Just what I feared - these messages popping out from all over the tree.
> >
> >I'd prefer if we change the caller otherwise depending on the platform
> >a single cache flush might involve several preempt_disable/-enable
> >invocations.  Something like below.
> >
> >And it also keeps the header file more usable outside the core kernel
> >which Florian's recent zboot a little easier.
> >
> 
> Hi Ralf,
> 
> Changing the caller instead of the function in the header file looks
> good to me. Thanks for fixing it.

I think in the end the patch below is the better way of fixing it.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/cpu-info.h |  1 +
 arch/mips/include/asm/r4kcache.h | 16 ++++++++--------
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 41401d8..21c8e29 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -84,6 +84,7 @@ struct cpuinfo_mips {
 extern struct cpuinfo_mips cpu_data[];
 #define current_cpu_data cpu_data[smp_processor_id()]
 #define raw_current_cpu_data cpu_data[raw_smp_processor_id()]
+#define boot_cpu_data cpu_data[0]
 
 extern void cpu_probe(void);
 extern void cpu_report(void);
diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index a0b2650..be52f27 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -344,10 +344,10 @@ static inline void invalidate_tcache_page(unsigned long addr)
 static inline void blast_##pfx##cache##lsize(void)			\
 {									\
 	unsigned long start = INDEX_BASE;				\
-	unsigned long end = start + current_cpu_data.desc.waysize;	\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-			       current_cpu_data.desc.waybit;		\
+	unsigned long end = start + boot_cpu_data.desc.waysize;		\
+	unsigned long ws_inc = 1UL << boot_cpu_data.desc.waybit;	\
+	unsigned long ws_end = boot_cpu_data.desc.ways <<		\
+			       boot_cpu_data.desc.waybit;		\
 	unsigned long ws, addr;						\
 									\
 	__##pfx##flush_prologue						\
@@ -376,12 +376,12 @@ static inline void blast_##pfx##cache##lsize##_page(unsigned long page) \
 									\
 static inline void blast_##pfx##cache##lsize##_page_indexed(unsigned long page) \
 {									\
-	unsigned long indexmask = current_cpu_data.desc.waysize - 1;	\
+	unsigned long indexmask = boot_cpu_data.desc.waysize - 1;	\
 	unsigned long start = INDEX_BASE + (page & indexmask);		\
 	unsigned long end = start + PAGE_SIZE;				\
-	unsigned long ws_inc = 1UL << current_cpu_data.desc.waybit;	\
-	unsigned long ws_end = current_cpu_data.desc.ways <<		\
-			       current_cpu_data.desc.waybit;		\
+	unsigned long ws_inc = 1UL << boot_cpu_data.desc.waybit;	\
+	unsigned long ws_end = boot_cpu_data.desc.ways <<		\
+			       boot_cpu_data.desc.waybit;		\
 	unsigned long ws, addr;						\
 									\
 	__##pfx##flush_prologue						\
