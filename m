Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g1P4nXU13298
	for linux-mips-outgoing; Sun, 24 Feb 2002 20:49:33 -0800
Received: from dtla2.teknuts.com (adsl-66-125-62-110.dsl.lsan03.pacbell.net [66.125.62.110])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g1P4nV913288
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 20:49:31 -0800
Received: from delllaptop ([208.187.134.59])
	(authenticated)
	by dtla2.teknuts.com (8.11.3/8.10.1) with ESMTP id g1P3nTP09901
	for <linux-mips@oss.sgi.com>; Sun, 24 Feb 2002 19:49:29 -0800
From: "Robert Rusek" <robru@teknuts.com>
To: <linux-mips@oss.sgi.com>
Subject: System lockup problem. . .
Date: Sun, 24 Feb 2002 19:45:06 -0800
Message-ID: <000701c1bdae$d226c580$6601a8c0@delllaptop>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
Importance: Normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am running Kernel 2.4.3 on an SGI Indy (IP22).  I built the RedHat 7.1
system from the NFS root obtained from ftp.mips.com. Everything seems to
be working until I added an additional drive.  Now when I do an heavy IO
operation on the additional drive my system locks up.  It seems like
there is not enough buffer allocated somewhere. I know that the drive is
not an issue since when I boot the system up under IRIX 5.3 all works
well..  Has anyone had a similar problem?  Where should I look?  Is is
an Kernel issue or a setting in the OS?

Thanks in advance,
--
Robert Rusek
