Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f75K5h821043
	for linux-mips-outgoing; Sun, 5 Aug 2001 13:05:43 -0700
Received: from scsoftware.sc-software.com (mipsdev@[206.40.202.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f75K5fV21040
	for <linux-mips@oss.sgi.com>; Sun, 5 Aug 2001 13:05:42 -0700
Received: from localhost (mipsdev@localhost) by scsoftware.sc-software.com (8.8.3/8.8.3) with SMTP id MAA15054; Sun, 5 Aug 2001 12:59:23 GMT
Date: Sun, 5 Aug 2001 12:59:23 +0000 (   )
From: John Heil <mipsdev@scsoftware.sc-software.com>
To: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
   linux-mips@oss.sgi.com
Subject: Qube2 gcc 2.7.2 compiler error (fwd)
Message-ID: <Pine.LNX.3.95.1010805125641.15505J-100000@scsoftware.sc-software.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


On the Qube2, gcc 2.7.2, option -s, to generate MIPS assembler
corresponding to the input C code, generates invalid assembler
by virtue of generating duplicate labels. The resultant 
assembler will not assemble, of course, due to the duplicate
labels.  The code (linux kernel's printk.c) compiles cleanly
from C to object code.

Q: How do I get valid assembler from gcc on Qube2 ?
(My ultimate goal here is to be able to get listings out
of gas.)

Thanks much
John H

Oops, Sorry -> typo. I meant   gcc -S  

Thanks
