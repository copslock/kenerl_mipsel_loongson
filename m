Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g65G97Rw007217
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 09:09:07 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g65G96o1007216
	for linux-mips-outgoing; Fri, 5 Jul 2002 09:09:06 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g65G94Rw007206
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 09:09:04 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA161
          for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 09:13:11 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>
Subject: sys_execve problem
Date: Fri, 5 Jul 2002 09:15:20 -0700
Message-ID: <01c501c2243f$2951c700$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Hey guys. I have compiled 2.4.19-ac1 from the CVS with the linux_2_4 tag for
my NEC Osprey board (NEC VR4181) It boots fine and stuff, but doesn't load
init. I've confirmed with simple print statements that do_execve is
returning a 0 at the point in fs/exec.c where it says "/* execve success */"
and yet init doesn't load. The system just sits there. I see on a scope that
my timer interrupt is firing every 10 ms and the serial console responds
properly. It echos characters and stops the echo when it receives a ctrl-S
and resumes it on ctrl-Q. Obviously this is the last little part of the
kernel to work though here. Any ideas?

Steve
