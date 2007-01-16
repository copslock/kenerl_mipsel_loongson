Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:56:11 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:35202 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580810AbXAPQmC (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:02 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGf2fM001021;
	Tue, 16 Jan 2007 09:41:02 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGf2Pd001020;
	Tue, 16 Jan 2007 09:41:02 -0700
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
Subject: [PATCH 37/59] sysctl: C99 convert arch/sh64/kernel/traps.c and remove ABI breakage.
Date:	Tue, 16 Jan 2007 09:39:42 -0700
Message-Id: <11689656622749-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13646
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

While doing the C99 conversion I notices that the top level sh64
directory was using the binary number for CTL_KERN.  That is a
no-no so I removed the support for the sysctl binary interface
only leaving sysctl /proc support.

At least the sysctl tables were placed at the end of
the list so user space did not see this mistake.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/sh64/kernel/traps.c |   49 +++++++++++++++++++++++++++++++++++----------
 1 files changed, 38 insertions(+), 11 deletions(-)

diff --git a/arch/sh64/kernel/traps.c b/arch/sh64/kernel/traps.c
index 224b7f5..02cca74 100644
--- a/arch/sh64/kernel/traps.c
+++ b/arch/sh64/kernel/traps.c
@@ -910,25 +910,52 @@ static int misaligned_fixup(struct pt_regs *regs)
 }
 
 static ctl_table unaligned_table[] = {
-	{1, "kernel_reports", &kernel_mode_unaligned_fixup_count,
-		sizeof(int), 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "kernel_reports",
+		.data		= &kernel_mode_unaligned_fixup_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
 #if defined(CONFIG_SH64_USER_MISALIGNED_FIXUP)
-	{2, "user_reports", &user_mode_unaligned_fixup_count,
-		sizeof(int), 0644, NULL, &proc_dointvec},
-	{3, "user_enable", &user_mode_unaligned_fixup_enable,
-		sizeof(int), 0644, NULL, &proc_dointvec},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "user_reports",
+		.data		= &user_mode_unaligned_fixup_count,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec
+	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "user_enable",
+		.data		= &user_mode_unaligned_fixup_enable,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec},
 #endif
-	{0}
+	{}
 };
 
 static ctl_table unaligned_root[] = {
-	{1, "unaligned_fixup", NULL, 0, 0555, unaligned_table},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "unaligned_fixup",
+		.mode		= 0555,
+		unaligned_table
+	},
+	{}
 };
 
 static ctl_table sh64_root[] = {
-	{1, "sh64", NULL, 0, 0555, unaligned_root},
-	{0}
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "sh64",
+		.mode		= 0555,
+		.child		= unaligned_root
+	},
+	{}
 };
 static struct ctl_table_header *sysctl_header;
 static int __init init_sysctl(void)
-- 
1.4.4.1.g278f
