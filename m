Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 17:00:54 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:58242 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580823AbXAPQmS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:18 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGf5Ir001029;
	Tue, 16 Jan 2007 09:41:05 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGf4Wk001028;
	Tue, 16 Jan 2007 09:41:04 -0700
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
Subject: [PATCH 39/59] sysctl: C99 convert ctl_tables in arch/x86_64/ia32/ia32_binfmt.c
Date:	Tue, 16 Jan 2007 09:39:44 -0700
Message-Id: <1168965664873-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13656
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/ia32/ia32_binfmt.c |   30 ++++++++++++++++++++----------
 1 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 75677ad..644b203 100644
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -395,16 +395,26 @@ EXPORT_SYMBOL(ia32_setup_arg_pages);
 #include <linux/sysctl.h>
 
 static ctl_table abi_table2[] = {
-	{ 99, "vsyscall32", &sysctl_vsyscall32, sizeof(int), 0644, NULL,
-	  proc_dointvec },
-	{ 0, }
-}; 
-
-static ctl_table abi_root_table2[] = { 
-	{ .ctl_name = CTL_ABI, .procname = "abi", .mode = 0555, 
-	  .child = abi_table2 }, 
-	{ 0 }, 
-}; 
+	{
+		.ctl_name	= 99,
+		.procname	= "vsyscall32",
+		.data		= &sysctl_vsyscall32,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec
+	},
+	{}
+};
+
+static ctl_table abi_root_table2[] = {
+	{
+		.ctl_name = CTL_ABI,
+		.procname = "abi",
+		.mode = 0555,
+		.child = abi_table2
+	},
+	{}
+};
 
 static __init int ia32_binfmt_init(void)
 { 
-- 
1.4.4.1.g278f
