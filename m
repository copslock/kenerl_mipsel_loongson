Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7DNAgi23113
	for linux-mips-outgoing; Mon, 13 Aug 2001 16:10:42 -0700
Received: from myth1.Stanford.EDU (myth1.Stanford.EDU [171.64.15.14])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7DNAfj23110
	for <linux-mips@oss.sgi.com>; Mon, 13 Aug 2001 16:10:41 -0700
Received: (from johnd@localhost)
	by myth1.Stanford.EDU (8.11.1/8.11.1) id f7DNAZC24949;
	Mon, 13 Aug 2001 16:10:35 -0700 (PDT)
Date: Mon, 13 Aug 2001 16:10:35 -0700 (PDT)
From: "John D. Davis" <johnd@Stanford.EDU>
To: Debian MIPS list <debian-mips@lists.debian.org>,
   SGI MIPS list <linux-mips@oss.sgi.com>
Subject: Tracing the Console
Message-ID: <Pine.GSO.4.31.0108131556230.21357-100000@myth1.Stanford.EDU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I am currently trying to trace the console on and R4400 Indy. It seems
that everything goes through console.c using either con_write or
con_put_char.  It would be great if I could communicate with someone that
has a thorough understanding of this code and its interaction with
newport_con.c.  I have put some prtink statements in and it seems that
newport_putcs is called several more times than it should. Is there some
interrupt handler that can jump right to it? I have manually traced the
calls from console.c con_write or con_put_char -> do_con_write ->
newport_putcs.  I am trying to pin down the console low-level read/write
functions, so that I can grab the characters at that level and redirect
them in a similar console driver.  This is what a normal call trace looks
like so far:

Aug  6 20:14:57 agamemnon kernel: IN: console.c:con_write():line 2244: int
0: string Entering runlevel: 2\210^KA4
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: IN: console.c:do_con_write():line 1839
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: OUT: console.c:do_con_write():line 2013
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423
Aug  6 20:14:57 agamemnon kernel: OUT: console.c:con_write():line 2251
Aug  6 20:14:57 agamemnon kernel: IN: newport_con.c:newport_putcs():line
393
Aug  6 20:14:57 agamemnon kernel: OUT: newport_con.c:newport_putcs():line
423

Even after exiting con_write(), there is another newport_putcs() call.
Any assistance/explanation would be greatly appreciated.

thanks,
john
