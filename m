Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6NM6vRw014790
	for <linux-mips-outgoing@oss.sgi.com>; Tue, 23 Jul 2002 15:06:57 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6NM6v3k014789
	for linux-mips-outgoing; Tue, 23 Jul 2002 15:06:57 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from tnint11.telogy.design.ti.com ([209.116.120.7])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6NM6rRw014779
	for <linux-mips@oss.sgi.com>; Tue, 23 Jul 2002 15:06:53 -0700
Received: from gtlinuxserver1.telogy.design.ti.com (GTLINUX1 [158.218.102.44]) by tnint11.telogy.design.ti.com with SMTP (Microsoft Exchange Internet Mail Service Version 5.5.2653.13)
	id NYM51LY0; Tue, 23 Jul 2002 18:06:08 -0400
Subject: Question about generic\time.c 2.4.17
From: Nick Zajerko-McKee <nmckee@telogy.com>
To: linux-mips@oss.sgi.com
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 (1.0.3-6) 
Date: 23 Jul 2002 18:05:13 -0400
Message-Id: <1027461913.4699.26.camel@gtlinuxserver1.telogy.design.ti.com>
Mime-Version: 1.0
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hi,

I'm working on a new 4Kc platform and was looking at the
arch\mips\mips-boards\generic\time.c sources.  Can someone explain to me
the function of do_fast_gettimeoffset(), especially the do_div64_32()
assembler routine?  One of the requirements I have will be not modify
the timer resolution for my platform to something in the msec range w/o
disturbing the underlying jiffie setup found in linux.

Thanks.
