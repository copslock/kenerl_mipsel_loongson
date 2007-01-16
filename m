Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:44:36 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:9089 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580768AbXAPQlT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:19 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGeZgp000941;
	Tue, 16 Jan 2007 09:40:35 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGeZhL000940;
	Tue, 16 Jan 2007 09:40:35 -0700
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
Subject: [PATCH 18/59] sysctl: ipmi remove unnecessary insert_at_head flag
Date:	Tue, 16 Jan 2007 09:39:23 -0700
Message-Id: <1168965635875-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13621
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

With unique sysctl binary numbers setting insert_at_head is pointless.

Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 drivers/char/ipmi/ipmi_poweroff.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/char/ipmi/ipmi_poweroff.c b/drivers/char/ipmi/ipmi_poweroff.c
index 9d23136..b3ae65e 100644
--- a/drivers/char/ipmi/ipmi_poweroff.c
+++ b/drivers/char/ipmi/ipmi_poweroff.c
@@ -686,7 +686,7 @@ static int ipmi_poweroff_init (void)
 		printk(KERN_INFO PFX "Power cycle is enabled.\n");
 
 #ifdef CONFIG_PROC_FS
-	ipmi_table_header = register_sysctl_table(ipmi_root_table, 1);
+	ipmi_table_header = register_sysctl_table(ipmi_root_table, 0);
 	if (!ipmi_table_header) {
 		printk(KERN_ERR PFX "Unable to register powercycle sysctl\n");
 		rv = -ENOMEM;
-- 
1.4.4.1.g278f
