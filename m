Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g4DLrAnC014952
	for <linux-mips-outgoing@oss.sgi.com>; Mon, 13 May 2002 14:53:10 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g4DLrA5D014951
	for linux-mips-outgoing; Mon, 13 May 2002 14:53:10 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g4DLr8nC014948
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 14:53:08 -0700
Received: from whrrusek (whnat1.weiderpub.com [65.115.104.67])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g4DLrSn03080
	for <linux-mips@oss.sgi.com>; Mon, 13 May 2002 14:53:28 -0700
From: "Robert Rusek" <rrusek@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: dump/Restore issues on Indy
Date: Mon, 13 May 2002 14:53:26 -0700
Message-ID: <C0F41630CD8B9C4680F2412914C1CF070164C9@WH-EXCHANGE1.AD.WEIDERPUB.COM>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4910.0300
Importance: Normal
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am having problems doing a restore after a dump.  The dump finishes
without any problems.  I get an invalid header when doing a restore.
When I use tar it works great so I know that it is not a hardware
problem.  I have compiled the lates dump/restore and ef2progs.  

Any help would be greatly appreciated.

--
Robert Rusek
    
