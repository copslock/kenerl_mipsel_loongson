Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:52:55 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:642 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580793AbXAPQlp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:45 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGeqjH000988;
	Tue, 16 Jan 2007 09:40:52 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGeojp000986;
	Tue, 16 Jan 2007 09:40:50 -0700
From:	"Eric W. Biederman" <ebiederm@xmission.com>
To:	"<Andrew Morton" <akpm@osdl.org>
Cc:	<linux-kernel@vger.kernel.org>, <containers@lists.osdl.org>,
	<netdev@vger.kernel.org>, xfs-masters@oss.sgi.com, xfs@oss.sgi.com,
	linux-scsi@vger.kernel.org, James.Bottomley@SteelEye.com,
	minyard@acm.org, openipmi-developer@lists.sourceforge.net,
	<tony.luck@intel.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com, linux390@de.ibm.com,
	linux-390@vm.marist.edu, paulus@samba.org, linuxppc-dev@ozlabs.org,
	lethal@linux-sh.org, linuxsh-shmedia-dev@lists.sourceforge.net,
	<ak@suse.de>, vojtech@suse.cz, clemens@ladisch.de,
	a.zummo@towertech.it, rtc-linux@googlegroups.com,
	linux-parport@lists.infradead.org, andrea@suse.de,
	tim@cyberelk.net, philb@gnu.org, aharkes@cs.cmu.edu,
	coda@cs.cmu.edu, codalist@TELEMANN.coda.cs.cmu.edu,
	aia21@cantab.net, linux-ntfs-dev@lists.sourceforge.net,
	mark.fasheh@oracle.com, kurt.hackel@oracle.com,
	"Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH 29/59] sysctl: C99 convert arch/ia64/kernel/perfmon and remove ABI breakage
Date:	Tue, 16 Jan 2007 09:39:34 -0700
Message-Id: <1168965650735-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13639
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

This convers the sysctl ctl_tables to use C99 initializers.
While I was looking at it I discovered it was using a portion of
the sysctl binary addresses space under CTL_KERN KERN_OSTYPE
which was completely inappropriate.  So I completely removed
all of the sysctl binary names, to remove and avoid the ABI conflict.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/kernel/perfmon.c |   56 ++++++++++++++++++++++++++++++++++++-------
 1 files changed, 47 insertions(+), 9 deletions(-)

diff --git a/arch/ia64/kernel/perfmon.c b/arch/ia64/kernel/perfmon.c
index aa94f60..8c679ab 100644
--- a/arch/ia64/kernel/perfmon.c
+++ b/arch/ia64/kernel/perfmon.c
@@ -521,19 +521,57 @@ pfm_sysctl_t pfm_sysctl;
 EXPORT_SYMBOL(pfm_sysctl);
 
 static ctl_table pfm_ctl_table[]={
-	{1, "debug", &pfm_sysctl.debug, sizeof(int), 0666, NULL, &proc_dointvec, NULL,},
-	{2, "debug_ovfl", &pfm_sysctl.debug_ovfl, sizeof(int), 0666, NULL, &proc_dointvec, NULL,},
-	{3, "fastctxsw", &pfm_sysctl.fastctxsw, sizeof(int), 0600, NULL, &proc_dointvec, NULL,},
-	{4, "expert_mode", &pfm_sysctl.expert_mode, sizeof(int), 0600, NULL, &proc_dointvec, NULL,},
-	{ 0, },
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "debug",
+		.data		= &pfm_sysctl.debug,
+		.maxlen		= sizeof(int),
+		.mode		= 0666,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "debug_ovfl",
+		.data		= &pfm_sysctl.debug_ovfl,
+		.maxlen		= sizeof(int),
+		.mode		= 0666,
+		.proc_handler	= &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "fastctxsw",
+		.data		= &pfm_sysctl.fastctxsw,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	=  &proc_dointvec,
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "expert_mode",
+		.data		= &pfm_sysctl.expert_mode,
+		.maxlen		= sizeof(int),
+		.mode		= 0600,
+		.proc_handler	= &proc_dointvec,
+	},
+	{}
 };
 static ctl_table pfm_sysctl_dir[] = {
-	{1, "perfmon", NULL, 0, 0755, pfm_ctl_table, },
- 	{0,},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "perfmon",
+		.mode		= 0755,
+		.child		= pfm_ctl_table,
+	},
+ 	{}
 };
 static ctl_table pfm_sysctl_root[] = {
-	{1, "kernel", NULL, 0, 0755, pfm_sysctl_dir, },
- 	{0,},
+	{
+		.ctl_name	= CTL_KERN,
+		.procname	= "kernel",
+		.mode		= 0755,
+		.child		= pfm_sysctl_dir,
+	},
+ 	{}
 };
 static struct ctl_table_header *pfm_sysctl_header;
 
-- 
1.4.4.1.g278f
