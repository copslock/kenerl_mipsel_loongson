Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:57:34 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:39298 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580813AbXAPQmF (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:05 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGfKjk001061;
	Tue, 16 Jan 2007 09:41:20 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGfJ0P001060;
	Tue, 16 Jan 2007 09:41:19 -0700
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
Subject: [PATCH 47/59] sysctl: C99 convert ctl_tables in NTFS and remove sys_sysctl support
Date:	Tue, 16 Jan 2007 09:39:52 -0700
Message-Id: <11689656793474-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13649
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Putting ntfs-debug under FS_NRINODE was not a kosher thing to do
so don't give it any binary number.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/ntfs/sysctl.c |   24 ++++++++++++++++--------
 1 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/fs/ntfs/sysctl.c b/fs/ntfs/sysctl.c
index 1c23138..bc217de 100644
--- a/fs/ntfs/sysctl.c
+++ b/fs/ntfs/sysctl.c
@@ -33,20 +33,28 @@
 #include "sysctl.h"
 #include "debug.h"
 
-#define FS_NTFS	1
-
 /* Definition of the ntfs sysctl. */
 static ctl_table ntfs_sysctls[] = {
-	{ FS_NTFS, "ntfs-debug",		/* Binary and text IDs. */
-	  &debug_msgs,sizeof(debug_msgs),	/* Data pointer and size. */
-	  0644,	NULL, &proc_dointvec },		/* Mode, child, proc handler. */
-	{ 0 }
+	{
+		.ctl_name	= CTL_UNUMBERED,	/* Binary and text IDs. */
+		.procname	= "ntfs-debug",
+		.data		= &debug_msgs,		/* Data pointer and size. */
+		.maxlen		= sizeof(debug_msgs),
+		.mode		= 0644,			/* Mode, proc handler. */
+		.proc_handler	= &proc_dointvec
+	},
+	{}
 };
 
 /* Define the parent directory /proc/sys/fs. */
 static ctl_table sysctls_root[] = {
-	{ CTL_FS, "fs", NULL, 0, 0555, ntfs_sysctls },
-	{ 0 }
+	{
+		.ctl_name	= CTL_FS,
+		.procname	= "fs",
+		.mode		= 0555,
+		.child		= ntfs_sysctls
+	},
+	{}
 };
 
 /* Storage for the sysctls header. */
-- 
1.4.4.1.g278f
