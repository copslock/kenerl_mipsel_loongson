Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g66MSVRw028208
	for <linux-mips-outgoing@oss.sgi.com>; Sat, 6 Jul 2002 15:28:31 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g66MSV7H028207
	for linux-mips-outgoing; Sat, 6 Jul 2002 15:28:31 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g66MSSRw028198
	for <linux-mips@oss.sgi.com>; Sat, 6 Jul 2002 15:28:28 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA448;
          Sat, 6 Jul 2002 15:32:38 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: <linux-mips@oss.sgi.com>, <linux-mips-kernel@lists.sourceforge.net>
Subject: never mind
Date: Sat, 6 Jul 2002 15:34:54 -0700
Message-ID: <020401c2253d$5a4cca90$3501a8c0@wssseeger>
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

Well I fixed it. Somehow kswapd_wait gets a bad entry in its task_list and
it's always 0xffffffff8. So, putting a hack in __wake_up_common to look for
that address and break out (since that always seems to be at the end of the
list) fixed the problem. How odd. Of course I really should find out why
that bad value gets in there, but I'm so lazy.

Steve
