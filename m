Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2007 16:49:40 +0000 (GMT)
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:51073 "EHLO
	ebiederm.dsl.xmission.com") by ftp.linux-mips.org with ESMTP
	id S28580786AbXAPQlh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 16 Jan 2007 16:41:37 +0000
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Debian-2) with ESMTP id l0GGem4a000979;
	Tue, 16 Jan 2007 09:40:48 -0700
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.8/8.13.8/Submit) id l0GGelJh000978;
	Tue, 16 Jan 2007 09:40:47 -0700
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
Subject: [PATCH 27/59] sysctl: sn Remove sysctl ABI BREAKAGE
Date:	Tue, 16 Jan 2007 09:39:32 -0700
Message-Id: <1168965647511-git-send-email-ebiederm@xmission.com>
X-Mailer: git-send-email 1.5.0.rc1.gb60d
In-Reply-To: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
References: <m1ac0jc4no.fsf@ebiederm.dsl.xmission.com>
Return-Path: <eric@ebiederm.dsl.xmission.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ebiederm@xmission.com
Precedence: bulk
X-list: linux-mips

From: Eric W. Biederman <ebiederm@xmission.com> - unquoted

By not using the enumeration in sysctl.h (or even understanding it)
the SN platform placed their arch specific xpc directory on top of
CTL_KERN and only because they didn't have 4 entries in their xpc
directory got lucky and didn't break glibc.

This is totally irresponsible.  So this patch entirely removes
sys_sysctl support from their sysctl code.  Hopefully they
don't have ascii name conflicts as well.

And now that they have no ABI numbers add them to the end
instead of the sysctl list instead of the head so nothing
else will be overridden.

Cc: Tony Luck <tony.luck@intel.com>
Signed-off-by: Eric W. Biederman <ebiederm@xmission.com>
---
 arch/ia64/sn/kernel/xpc_main.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/ia64/sn/kernel/xpc_main.c b/arch/ia64/sn/kernel/xpc_main.c
index 7a387d2..24adb75 100644
--- a/arch/ia64/sn/kernel/xpc_main.c
+++ b/arch/ia64/sn/kernel/xpc_main.c
@@ -101,7 +101,7 @@ static int xpc_disengage_request_max_timelimit = 120;
 
 static ctl_table xpc_sys_xpc_hb_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"hb_interval",
 		&xpc_hb_interval,
 		sizeof(int),
@@ -114,7 +114,7 @@ static ctl_table xpc_sys_xpc_hb_dir[] = {
 		&xpc_hb_max_interval
 	},
 	{
-		2,
+		CTL_UNNUMBERED,
 		"hb_check_interval",
 		&xpc_hb_check_interval,
 		sizeof(int),
@@ -130,7 +130,7 @@ static ctl_table xpc_sys_xpc_hb_dir[] = {
 };
 static ctl_table xpc_sys_xpc_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"hb",
 		NULL,
 		0,
@@ -138,7 +138,7 @@ static ctl_table xpc_sys_xpc_dir[] = {
 		xpc_sys_xpc_hb_dir
 	},
 	{
-		2,
+		CTL_UNNUMBERED,
 		"disengage_request_timelimit",
 		&xpc_disengage_request_timelimit,
 		sizeof(int),
@@ -154,7 +154,7 @@ static ctl_table xpc_sys_xpc_dir[] = {
 };
 static ctl_table xpc_sys_dir[] = {
 	{
-		1,
+		CTL_UNNUMBERED,
 		"xpc",
 		NULL,
 		0,
@@ -1251,7 +1251,7 @@ xpc_init(void)
 	snprintf(xpc_part->bus_id, BUS_ID_SIZE, "part");
 	snprintf(xpc_chan->bus_id, BUS_ID_SIZE, "chan");
 
-	xpc_sysctl = register_sysctl_table(xpc_sys_dir, 1);
+	xpc_sysctl = register_sysctl_table(xpc_sys_dir, 0);
 
 	/*
 	 * The first few fields of each entry of xpc_partitions[] need to
-- 
1.4.4.1.g278f
