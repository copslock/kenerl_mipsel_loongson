Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f75JxWa20440
	for linux-mips-outgoing; Sun, 5 Aug 2001 12:59:32 -0700
Received: from scsoftware.sc-software.com (mipsdev@[206.40.202.193])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f75JxUV20435
	for <linux-mips@oss.sgi.com>; Sun, 5 Aug 2001 12:59:31 -0700
Received: from localhost (mipsdev@localhost) by scsoftware.sc-software.com (8.8.3/8.8.3) with SMTP id MAA15023; Sun, 5 Aug 2001 12:53:01 GMT
Date: Sun, 5 Aug 2001 12:53:01 +0000 (   )
From: John Heil <mipsdev@scsoftware.sc-software.com>
Reply-To: John Heil <mipsdev@scsoftware.sc-software.com>
To: cobalt-22@devel.alal.com, cobalt-developers@list.cobalt.com,
   linux-mips@oss.sgi.com
Subject: Qube2 gcc 2.7.2 compiler error
Message-ID: <Pine.LNX.3.95.1010805123910.15505I-100000@scsoftware.sc-software.com>
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
