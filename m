Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2C3XXQ22082
	for linux-mips-outgoing; Mon, 11 Mar 2002 19:33:33 -0800
Received: from i01sv4138.ids1.intelonline.com (i01sv4138-p.ids1.intelonline.com [147.208.166.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2C3XU922077
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 19:33:31 -0800
Received: from i01sv0637 (unverified [10.81.26.22]) by i01sv4138.ids1.intelonline.com
 (Rockliffe SMTPRA 4.5.4) with SMTP id <B1516304643@i01sv4138.ids1.intelonline.com> for <linux-mips@oss.sgi.com>;
 Tue, 12 Mar 2002 02:33:23 +0000
Message-ID: <B1516304643@i01sv4138.ids1.intelonline.com>
From: Guo-Rong Koh <grk@start.com.au>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
X-Originating-IP: [203.14.96.10]
Date: Tue, 12 Mar 2002 12:33:22 +1030
X-MSMail-Priority: Normal
X-mailer: AspMail 4.0 4.02 (SMT4DD4B4F)
Subject: boot fails on decstation 5000/25
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi all,

My cross-compiled kernel (latest off CVS), kernel panics when
allocating root vfsmount. I've traced it back to the init_mount_tree
call in fs/super.c where it fails the check for CAP_SYS_ADMIN
capability.

Anyone know of this problem? Personally it seems a bit weird, could it
be related to the fact that I'm using the NetBSD boot loader??

Thanks in advance,
Guo-Rong


__________________________________________________________________
Get your free Australian email account at http://www.start.com.au
