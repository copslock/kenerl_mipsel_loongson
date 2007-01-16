Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 17:04:06 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9091 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580831AbXAPQme (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:34 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGfY79001085;
	Tue, 16 Jan 2007 09:41:34 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGfXUL001084;
	Tue, 16 Jan 2007 09:41:33 -0700
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
Subject: [PATCH 52/59] sysctl: Create sys/fs/binfmt_misc as an ordinary sysctl entry
Date:	Tue, 16 Jan 2007 09:39:57 -0700
Message-Id: <11689656932416-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13663
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

binfmt_misc has a mount point in the middle of the sysctl and
that mount point is created as a proc_generic directory.

Doing it that way gets in the way of cleaning up the sysctl
proc support as it continues the existence of a horrible hack.
So instead simply create the directory as an ordinary sysctl
directory.   At least that removes the magic special case.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 fs/proc/root.c  |    4 ----
 kernel/sysctl.c |   13 +++++++++++++
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/fs/proc/root.c b/fs/proc/root.c
index 64d242b..8059e92 100644
--- a/fs/proc/root.c
+++ b/fs/proc/root.c
@@ -74,10 +74,6 @@ void __init proc_root_init(void)
 #ifdef CONFIG_SYSCTL
 	proc_sys_root = proc_mkdir("sys", NULL);
 #endif
-#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
-	proc_mkdir("sys/fs", NULL);
-	proc_mkdir("sys/fs/binfmt_misc", NULL);
-#endif
 	proc_root_fs = proc_mkdir("fs", NULL);
 	proc_root_driver = proc_mkdir("driver", NULL);
 	proc_mkdir("fs/nfsd", NULL); /* somewhere for the nfsd filesystem to be mounted */
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 6e2e608..8da6647 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -142,6 +142,7 @@ static struct ctl_table_header root_table_header =
 static ctl_table kern_table[];
 static ctl_table vm_table[];
 static ctl_table fs_table[];
+static ctl_table binfmt_misc_table[];
 static ctl_table debug_table[];
 static ctl_table dev_table[];
 extern ctl_table random_table[];
@@ -1001,6 +1002,18 @@ static ctl_table fs_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+#if defined(CONFIG_BINFMT_MISC) || defined(CONFIG_BINFMT_MISC_MODULE)
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "binfmt_misc",
+		.mode		= 0555,
+		.child		= binfmt_misc_table,
+	},
+#endif
+	{ .ctl_name = 0 }
+};
+
+static ctl_table binfmt_misc_table[] = {
 	{ .ctl_name = 0 }
 };
 
-- 
1.4.4.1.g278f
