Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2D2QXX28969
	for linux-mips-outgoing; Tue, 12 Mar 2002 18:26:33 -0800
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2D2QV928966
	for <linux-mips@oss.sgi.com>; Tue, 12 Mar 2002 18:26:31 -0800
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id BAA28719
	for <linux-mips@oss.sgi.com>; Wed, 13 Mar 2002 01:38:24 -0800
Subject: XFS
From: Pete Popov <ppopov@mvista.com>
To: linux-mips <linux-mips@oss.sgi.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.2 
Date: 12 Mar 2002 17:29:11 -0800
Message-Id: <1015982952.5196.62.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Thanks to everyone who sent me suggestions and help on how they got xfs
working on mips.

I tried the split patches on a 2.4.18 kernel, compiled with a 2.95.3
compiler, and the kernel crashes consistently when running bonnie++. 
The same kernel compiled with a 3.0.1 based compiler seems to work fine.
I've ran bonnie++ a few times, as well as other conventional tests. I
need to do a lot more testing before I'm convinced that xfs is rock
solid on mips, but it appears that the compiler problems described on
the web site are for real.

Pete
