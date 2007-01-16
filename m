Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:44:09 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:6785 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S20041462AbXAPQlR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:17 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGeRWl000913;
	Tue, 16 Jan 2007 09:40:27 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGeRVj000911;
	Tue, 16 Jan 2007 09:40:27 -0700
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
Subject: [PATCH 11/59] sysctl: ax25 remove unnecessary insert_at_head flag
Date:	Tue, 16 Jan 2007 09:39:16 -0700
Message-Id: <11689656273396-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13620
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 net/ax25/sysctl_net_ax25.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/net/ax25/sysctl_net_ax25.c b/net/ax25/sysctl_net_ax25.c
index d23a27f..afdba04 100644
--- a/net/ax25/sysctl_net_ax25.c
+++ b/net/ax25/sysctl_net_ax25.c
@@ -245,7 +245,7 @@ void ax25_register_sysctl(void)
 
 	ax25_dir_table[0].child = ax25_table;
 
-	ax25_table_header = register_sysctl_table(ax25_root_table, 1);
+	ax25_table_header = register_sysctl_table(ax25_root_table, 0);
 }
 
 void ax25_unregister_sysctl(void)
-- 
1.4.4.1.g278f
