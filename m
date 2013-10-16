Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Oct 2013 17:10:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40487 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822832Ab3JPPKLrbHeb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Oct 2013 17:10:11 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id r9GFA8CB007302;
        Wed, 16 Oct 2013 17:10:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id r9GFA7WV007301;
        Wed, 16 Oct 2013 17:10:07 +0200
Date:   Wed, 16 Oct 2013 17:10:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: MT: proc: Add support for printing VPE and TC ids
Message-ID: <20131016151007.GP1615@linux-mips.org>
References: <1381846382-26437-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1381846382-26437-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38354
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

On Tue, Oct 15, 2013 at 03:13:02PM +0100, Markos Chandras wrote:

> Add support for including VPE and TC ids in /proc/cpuinfo output as
> appropriate when MT/SMTC is enabled.

The pile of #ifdefs cracked my glasses ...

And there are more CPUs or configuration that want to provide special
per-CPU information in /proc/cpuinfo.  So I think there needs to be a
hook mechanism, such as a notifier.

This is a first cut only; I need to think about what sort of looking
the notifier needs to have.  But I'd appreciate testing on MT hardware!

Thanks,

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/cpu-info.h | 21 +++++++++++++++++++++
 arch/mips/kernel/proc.c          | 23 +++++++++++++++++++++++
 arch/mips/kernel/smp-mt.c        | 22 ++++++++++++++++++++++
 arch/mips/kernel/smtc-proc.c     | 23 +++++++++++++++++++++++
 4 files changed, 89 insertions(+)

diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/cpu-info.h
index 21c8e29..95c1c42 100644
--- a/arch/mips/include/asm/cpu-info.h
+++ b/arch/mips/include/asm/cpu-info.h
@@ -92,4 +92,25 @@ extern void cpu_report(void);
 extern const char *__cpu_name[];
 #define cpu_name_string()	__cpu_name[smp_processor_id()]
 
+struct seq_file;
+struct notifier_block;
+
+extern int register_proc_cpuinfo_notifier(struct notifier_block *nb);
+extern int proc_cpuinfo_notifier_call_chain(unsigned long val, void *v);
+
+#define proc_cpuinfo_notifier(fn, pri)					\
+({									\
+	static struct notifier_block fn##_nb = {			\
+		.notifier_call = fn,					\
+		.priority = pri						\
+	};								\
+									\
+	register_proc_cpuinfo_notifier(&fn##_nb);			\
+})
+
+struct proc_cpuinfo_notifier_args {
+	struct seq_file *m;
+	unsigned long n;
+};
+
 #endif /* __ASM_CPU_INFO_H */
diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
index 8c58d8a..5ca804d 100644
--- a/arch/mips/kernel/proc.c
+++ b/arch/mips/kernel/proc.c
@@ -17,8 +17,24 @@
 
 unsigned int vced_count, vcei_count;
 
+/*
+ *  * No lock; only written during early bootup by CPU 0.
+ *   */
+static RAW_NOTIFIER_HEAD(proc_cpuinfo_chain);
+
+int __ref register_proc_cpuinfo_notifier(struct notifier_block *nb)
+{
+	return raw_notifier_chain_register(&proc_cpuinfo_chain, nb);
+}
+
+int proc_cpuinfo_notifier_call_chain(unsigned long val, void *v)
+{
+	return raw_notifier_call_chain(&proc_cpuinfo_chain, val, v);
+}
+
 static int show_cpuinfo(struct seq_file *m, void *v)
 {
+	struct proc_cpuinfo_notifier_args proc_cpuinfo_notifier_args;
 	unsigned long n = (unsigned long) v - 1;
 	unsigned int version = cpu_data[n].processor_id;
 	unsigned int fp_vers = cpu_data[n].fpu_id;
@@ -112,6 +128,13 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		      cpu_has_vce ? "%u" : "not available");
 	seq_printf(m, fmt, 'D', vced_count);
 	seq_printf(m, fmt, 'I', vcei_count);
+
+	proc_cpuinfo_notifier_args.m = m;
+	proc_cpuinfo_notifier_args.n = n;
+
+	raw_notifier_call_chain(&proc_cpuinfo_chain, 0,
+				&proc_cpuinfo_notifier_args);
+
 	seq_printf(m, "\n");
 
 	return 0;
diff --git a/arch/mips/kernel/smp-mt.c b/arch/mips/kernel/smp-mt.c
index 57a3f7a..9a43e78 100644
--- a/arch/mips/kernel/smp-mt.c
+++ b/arch/mips/kernel/smp-mt.c
@@ -285,3 +285,25 @@ struct plat_smp_ops vsmp_smp_ops = {
 	.smp_setup		= vsmp_smp_setup,
 	.prepare_cpus		= vsmp_prepare_cpus,
 };
+
+static int proc_cpuinfo_chain_call(struct notifier_block *nfb,
+	unsigned long action_unused, void *data)
+{
+	struct proc_cpuinfo_notifier_args *pcn = data;
+	struct seq_file *m = pcn->m;
+	unsigned long n = pcn->n;
+
+	if (!cpu_has_mipsmt)
+		return NOTIFY_OK;
+
+	seq_printf(m, "VPE\t\t\t: %d\n", cpu_data[n].vpe_id);
+
+	return NOTIFY_OK;
+}
+
+static int __init proc_cpuinfo_notifier_init(void)
+{
+	return proc_cpuinfo_notifier(proc_cpuinfo_chain_call, 0);
+}
+
+subsys_initcall(proc_cpuinfo_notifier_init);
diff --git a/arch/mips/kernel/smtc-proc.c b/arch/mips/kernel/smtc-proc.c
index c10aa84..38635a9 100644
--- a/arch/mips/kernel/smtc-proc.c
+++ b/arch/mips/kernel/smtc-proc.c
@@ -77,3 +77,26 @@ void init_smtc_stats(void)
 
 	proc_create("smtc", 0444, NULL, &smtc_proc_fops);
 }
+
+static int proc_cpuinfo_chain_call(struct notifier_block *nfb,
+	unsigned long action_unused, void *data)
+{
+	struct proc_cpuinfo_notifier_args *pcn = data;
+	struct seq_file *m = pcn->m;
+	unsigned long n = pcn->n;
+
+	if (!cpu_has_mipsmt)
+		return NOTIFY_OK;
+
+	seq_printf(m, "VPE\t\t\t: %d\n", cpu_data[n].vpe_id);
+	seq_printf(m, "TC\t\t\t: %d\n", cpu_data[n].tc_id);
+
+	return NOTIFY_OK;
+}
+
+static int __init proc_cpuinfo_notifier_init(void)
+{
+	return proc_cpuinfo_notifier(proc_cpuinfo_chain_call, 0);
+}
+
+subsys_initcall(proc_cpuinfo_notifier_init);
