Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 15 Dec 2004 16:21:17 +0000 (GMT)
Received: from pD9562F66.dip.t-dialin.net ([IPv6:::ffff:217.86.47.102]:31940
	"EHLO pD9562F66.dip.t-dialin.net") by linux-mips.org with ESMTP
	id <S8225005AbULOQVN>; Wed, 15 Dec 2004 16:21:13 +0000
Received: from mo00.iij4u.or.jp ([IPv6:::ffff:210.130.0.19]:24570 "EHLO
	mo00.iij4u.or.jp") by linux-mips.net with ESMTP id <S868871AbULOQVB>;
	Wed, 15 Dec 2004 17:21:01 +0100
Received: MO(mo00)id iBFGKbZm000953; Thu, 16 Dec 2004 01:20:37 +0900 (JST)
Received: MDO(mdo00) id iBFGKaRO006393; Thu, 16 Dec 2004 01:20:36 +0900 (JST)
Received: 4UMRO01 id iBFGKZ3S001846; Thu, 16 Dec 2004 01:20:36 +0900 (JST)
	from stratos (localhost [127.0.0.1]) (authenticated)
Date: Thu, 16 Dec 2004 01:20:32 +0900
From: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: yuasa@hh.iij4u.or.jp, linux-mips <linux-mips@linux-mips.org>
Subject: [PATCH 2.6.10-rc3] remove duplicate extern in <linux/sched.h>
Message-Id: <20041216012032.3af62ce1.yuasa@hh.iij4u.or.jp>
X-Mailer: Sylpheed version 1.0.0beta3 (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <yuasa@hh.iij4u.or.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6677
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yuasa@hh.iij4u.or.jp
Precedence: bulk
X-list: linux-mips

Hi Ralf,

This patch remove duplicate extern in <linux/sched.h>.
Please apply this patch to v2.6 CVS tree.

Yoichi

Signed-off-by: Yoichi Yuasa <yuasa@hh.iij4u.or.jp>

diff -urN -X dontdiff a-orig/include/linux/sched.h a/include/linux/sched.h
--- a-orig/include/linux/sched.h	Sun Dec  5 21:25:05 2004
+++ a/include/linux/sched.h	Thu Dec 16 00:55:42 2004
@@ -802,8 +802,6 @@
 extern int in_group_p(gid_t);
 extern int in_egroup_p(gid_t);
 
-extern void release_task(struct task_struct * p);
-
 extern void proc_caches_init(void);
 extern void flush_signals(struct task_struct *);
 extern void flush_signal_handlers(struct task_struct *, int force_default);
