Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2006 14:50:45 +0000 (GMT)
Received: from static-71-243-124-123.bos.east.verizon.net ([71.243.124.123]:46579
	"EHLO mail1.sicortex.com") by ftp.linux-mips.org with ESMTP
	id S20040187AbWK1Ouj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 28 Nov 2006 14:50:39 +0000
Received: from [192.168.1.9] (213-66-54-131-o837.telia.com [213.66.54.131])
	(using SSLv3 with cipher RC4-MD5 (128/128 bits))
	(No client certificate requested)
	by mail1.sicortex.com (Postfix) with ESMTP id 03162BBC5;
	Tue, 28 Nov 2006 09:50:28 -0500 (EST)
Subject: Re: [Perfctr-devel] 2.6.19-rc6-git10 new perfmon code base +
	libpfm + pfmon
From:	"Philip J. Mucci" <phil@sicortex.com>
To:	eranian@hpl.hp.com
Cc:	perfmon@napali.hpl.hp.com, linux-mips@linux-mips.org
In-Reply-To: <20061127143705.GC24980@frankl.hpl.hp.com>
References: <20061127143705.GC24980@frankl.hpl.hp.com>
Content-Type: multipart/mixed; boundary="=-NKNOX+KaNlfzWAaDtSaM"
Date:	Tue, 28 Nov 2006 15:50:27 +0100
Message-Id: <1164725427.2316.109.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.3 (2.6.3-1.fc5.5) 
Return-Path: <phil@sicortex.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13266
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: phil@sicortex.com
Precedence: bulk
X-list: linux-mips


--=-NKNOX+KaNlfzWAaDtSaM
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hi folks,

Linux-MIPS users will need the following patch to add the 'cpu'
directories to sysfs.

Phil


On Mon, 2006-11-27 at 06:37 -0800, Stephane Eranian wrote:
> Hello,
> 
> I have released another version of the perfmon new code base package.
> This version of the kernel patch is relative to 2.6.19-rc6-git10.
> 
> This is a major update because it completes the changes requested 
> during the code review on LKML. As a consequence, the kernel interface
> is NOT backward compatible with previous v2.2 versions. This release has
> the v2.3 version number. Backward compatibility with v2.0 is maintained
> on Itanium processors.
> 
> The kernel patch is split between infrastructure work and perfmon2 proper.
> The infrastructure contains the following changes which will be integrated
> into mainline before perfmon2 is. Those changes should appear in 2.6.20.
> They are provided in the base.diff file.
> 
> The infrastructure changes include:
> 	- x86_64: fix idle_notifier to cover all interrupts entry/exit for idle thread
> 	- i386  : add idle notifier (copy of x86_64 notifier)
> 	- ia64  : idle notifier (copy of x86_64 notifier)
> 	- i386  : add X86_FEATURE_ceforge.net, linux-kernel@vger.kernel.orgq,X86_FEATURE_PEBS to cpufeature.h
> 	- x86_64:  add X86_FEATURE_BTS,X86_FEATURE_PEBS to cpufeature.h
> 	- i386  : add PMU related MSR definitions to msr.h
> 	- x86_64: NMI watchdog uses PERFCTR1 to allow PEBS on Intel Core (requires PERFCTR0)
> 	- all   : remove unused carta_random32.h
> 
> 
> The perfmon2 kernel changes the release to v2.3 and includes the following changes:
> 	- updated to 2.6.19-rc6-git10 
> 	- sampling format identified with clear text string, not UUID anymore
> 	- pfm_create_context() returns file descriptor
> 	- sampling format name passed as argument
> 	- struct pfarg_ctx_t simplified
> 	- using random32() instead of carta_random32() (now obsolete)
> 	- in struct pfarg_pmd, reg_random_seed is obsolete
> 	- added support for Intel Core processors (Core 2 Duo)
> 	- unified PEBS support between P4 and Intel Core
> 	- fix bugs with munmap() of sampling buffer
> 	- changed sysfs to handle new naming for sampling formats
> 	- change rsvd_mask logic in PMU description modules
> 	- make idle notifier registration lazy (only when needed)
> 	- rewritten NMI integration using die_notifier()
> 	- NMI watchdog support and auto-detection for AMD K8, Intel Core
> 	- fix potential issues with locking/irq masking using LockDep checker
> 	- cleaned MIPS PMU description table setup
> 	- various MIPS bugs fixes (Phil Mucci, Manoj Ekbote)
> 	- various PowerPC updates  include PPC32 description table (Phil Mucci)
> 
> Due to problems with the git10 tree, the MIPS kernel does not compile regardless of
> perfmon2. A new patch will be generated once this problem is removed.
> 
> I have also released a new libpfm, libpfm-3.2-061127, with lots of
> changes. Here are some of the most important ones:
> 
> 	- added support for Intel Core (Core 2 Duo)
> 	- updated all example, header files to perfmon v2.3
> 	- updated man pages
> 	- Intel Core PEBS example
> 	- fixed rtop on 32-bit platforms
> 	- various MIPS updates (Phil Mucci)
> 	- big-endian support for MIPS
> 	- various Makefile improvements
> 
> Also a new version of pfmon, pfmon-3.2-061127, with a lot
> of changes as well:
> 	- updated to perfmon v2.3 interface
> 	- support for Intel Core processors (Core 2 Duo)
> 	- support for Intel Core PEBS as a sampling format
> 	- complete rewrite of system-wide  core loops to avoid race conditions with signals
> 	- added --print-interval to print intermediate deltas in system-wide mode
> 	- better handling of perfmon errors
> 	- corrected Montecito checks for L2D_CANCEL events
> 	- factorized 'detailed' sampling format for all arch
> 	- inst-hist default formats for all arch
> 	- corrected sampling buffer auto-sizing based on resource limit constraints
> 	- updated online documentation
> 	
> This version of pfmon requires libpfm-3.2-061127.
> 
> You can get a more detailed log of changes the the CVS tree.
> 
> You can grab the new packages at our web site:
> 
> 	 http://perfmon2.sf.net
> 
> Enjoy,
> 
> PS: I will post a kernel patch to LKML and a diffstat on the perfmon mailing list.
> -- 
> 
> -Stephane
> 
> -------------------------------------------------------------------------
> Take Surveys. Earn Cash. Influence the Future of IT
> Join SourceForge.net's Techsay panel and you'll get the chance to share your
> opinions on IT & business topics through brief surveys - and earn cash
> http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
> _______________________________________________
> Perfctr-devel mailing list
> Perfctr-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/perfctr-devel

--=-NKNOX+KaNlfzWAaDtSaM
Content-Disposition: inline
Content-Description: Attached message
Content-Type: message/rfc822

Return-Path: <phil@sicortex.com>
X-Original-To: mucci@cs.utk.edu
Received: from ka.cs.utk.edu (ka.cs.utk.edu [160.36.56.221]) by
	yomega.cs.utk.edu (Postfix) with ESMTP id B50008D03F for
	<mucci@cs.utk.edu>; Tue, 28 Nov 2006 09:45:59 -0500 (EST)
Received: from localhost (localhost [127.0.0.1]) by ka.cs.utk.edu (Postfix)
	with ESMTP id F01D62F27B for <mucci@cs.utk.edu>; Tue, 28 Nov 2006 09:47:17
	-0500 (EST)
X-Virus-Scanned: by amavisd-new with ClamAV and SpamAssasin at cs.utk.edu
X-Spam-Score: -0.648
X-Spam-Level: 
X-Spam-Status: No, score=-0.648 tagged_above=-100 required=5
	tests=[BAYES_00=-2.599, FORGED_RCVD_HELO=0.135, MISSING_SUBJECT=1.816]
Received: from ka.cs.utk.edu ([127.0.0.1]) by localhost (ka.cs.utk.edu
	[127.0.0.1]) (amavisd-new, port 10024) with ESMTP id Amv1QlkI8q3X for
	<mucci@cs.utk.edu>; Tue, 28 Nov 2006 09:47:13 -0500 (EST)
Received: from mail.sicortex.com
	(static-71-243-124-123.bos.east.verizon.net [71.243.124.123]) by
	ka.cs.utk.edu (Postfix) with ESMTP id 2151A2F275 for <mucci@cs.utk.edu>;
	Tue, 28 Nov 2006 09:47:10 -0500 (EST)
Received: from intranet.sicortex.com (intranet.sicortex.com [10.0.0.20]) by
	mail.sicortex.com (Postfix) with ESMTP id 1CBB8830C5 for
	<mucci@cs.utk.edu>; Tue, 28 Nov 2006 09:47:10 -0500 (EST)
Received: by intranet.sicortex.com (Postfix, from userid 1018) id
	04AF39A1BF; Tue, 28 Nov 2006 09:47:09 -0500 (EST)
Date: Tue, 28 Nov 2006 09:47:09 -0500
To: mucci@cs.utk.edu
Message-ID: <456C4BED.mailP0811VGTG@intranet.sicortex.com>
User-Agent: nail 11.4 8/29/04
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: phil@sicortex.com (Phil Mucci)
X-Evolution-Source: imap://mucci@imap.cs.utk.edu/
Subject: No Subject
Content-Transfer-Encoding: 7bit

Index: perfmon/perfmon_sysfs.c
===================================================================
--- perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-pre-fixup)	(revision 27882)
+++ perfmon/perfmon_sysfs.c	(.../perfmon2-post-sf-post-fixup)	(revision 27882)
@@ -79,6 +79,10 @@
 
 static struct kobject pfm_kernel_kobj, pfm_kernel_fmt_kobj;
 
+/* Remove this after mips get topology.c files */
+
+struct cpu sysfs_cpus[NR_CPUS];
+
 static void pfm_reset_stats(int cpu)
 {
 	struct pfm_stats *st;
@@ -400,6 +404,19 @@
 	int done_kobj_fmt = 0, done_kobj_kernel = 0;
 	int i, cpu = -1;
 	
+	/* This is a hack to be removed */
+
+        for_each_present_cpu(i) {
+          ret = register_cpu(&sysfs_cpus[i],i,NULL);
+          if (ret)
+            {
+              PFM_INFO("cannot register cpu %d: %d\n",i,ret);
+              goto error;
+            }
+        }
+
+	/* End hack */
+
 	ret = subsystem_register(&pfm_fmt_subsys);
 	if (ret) {
 		PFM_INFO("cannot register pfm_fmt_subsys: %d", ret);

--=-NKNOX+KaNlfzWAaDtSaM--
