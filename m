Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:59:58 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55170 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580820AbXAPQmQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:42:16 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGf3PU001025;
	Tue, 16 Jan 2007 09:41:03 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGf3mK001024;
	Tue, 16 Jan 2007 09:41:03 -0700
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
Subject: [PATCH 38/59] sysctl: x86_64 Remove unnecessary use of insert_at_head
Date:	Tue, 16 Jan 2007 09:39:43 -0700
Message-Id: <1168965663675-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

The only sysctl x86_64 provides are not provided elsewhere,
so insert_at_head is unnecessary.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/x86_64/ia32/ia32_binfmt.c |    2 +-
 arch/x86_64/mm/init.c          |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86_64/ia32/ia32_binfmt.c b/arch/x86_64/ia32/ia32_binfmt.c
index 543ef4f..75677ad 100644
--- a/arch/x86_64/ia32/ia32_binfmt.c
+++ b/arch/x86_64/ia32/ia32_binfmt.c
@@ -408,7 +408,7 @@ static ctl_table abi_root_table2[] = {
 
 static __init int ia32_binfmt_init(void)
 { 
-	register_sysctl_table(abi_root_table2, 1);
+	register_sysctl_table(abi_root_table2, 0);
 	return 0;
 }
 __initcall(ia32_binfmt_init);
diff --git a/arch/x86_64/mm/init.c b/arch/x86_64/mm/init.c
index 2968b90..65aa66c 100644
--- a/arch/x86_64/mm/init.c
+++ b/arch/x86_64/mm/init.c
@@ -724,7 +724,7 @@ static ctl_table debug_root_table2[] = {
 
 static __init int x8664_sysctl_init(void)
 { 
-	register_sysctl_table(debug_root_table2, 1);
+	register_sysctl_table(debug_root_table2, 0);
 	return 0;
 }
 __initcall(x8664_sysctl_init);
-- 
1.4.4.1.g278f
