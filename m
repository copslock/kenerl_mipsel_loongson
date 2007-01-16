Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 17:00:26 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:57474 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580822AbXAPQmS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:18 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGf7QC001033;
	Tue, 16 Jan 2007 09:41:07 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGf6LG001032;
	Tue, 16 Jan 2007 09:41:06 -0700
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
Subject: [PATCH 40/59] sysctl: C99 convert ctl_tables in arch/x86_64/kernel/vsyscall.c
Date:	Tue, 16 Jan 2007 09:39:45 -0700
Message-Id: <11689656651135-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13655
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Basically everything was done but I removed all element
initializers from the trailing entries to make it clear
the entire last entry should be zero filled.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/kernel/vsyscall.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/kernel/vsyscall.c b/arch/x86_64/kernel/vsyscall.c
index 2433d6f..c0e2b48 100644
--- a/arch/x86_64/kernel/vsyscall.c
+++ b/arch/x86_64/kernel/vsyscall.c
@@ -235,13 +235,13 @@ static ctl_table kernel_table2[] = {
 	  .data = &sysctl_vsyscall, .maxlen = sizeof(int), .mode = 0644,
 	  .strategy = vsyscall_sysctl_nostrat,
 	  .proc_handler = vsyscall_sysctl_change },
-	{ 0, }
+	{}
 };
 
 static ctl_table kernel_root_table2[] = {
 	{ .ctl_name = CTL_KERN, .procname = "kernel", .mode = 0555,
 	  .child = kernel_table2 },
-	{ 0 },
+	{}
 };
 
 #endif
-- 
1.4.4.1.g278f
