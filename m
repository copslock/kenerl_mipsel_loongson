Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA09376; Wed, 28 May 1997 12:25:15 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id MAA22396 for linux-list; Wed, 28 May 1997 12:24:53 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA22337 for <linux@cthulhu.engr.sgi.com>; Wed, 28 May 1997 12:24:46 -0700
Received: from neteng.engr.sgi.com (gate5-neteng.engr.sgi.com [150.166.61.33]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id MAA11809 for <linux@yon.engr.sgi.com>; Wed, 28 May 1997 12:24:45 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id MAA09260; Wed, 28 May 1997 12:24:36 -0700
Message-Id: <199705281924.MAA09260@neteng.engr.sgi.com>
To: miguel@nuclecu.unam.mx, shaver@neon.ingenia.ca, linux@yon.engr.sgi.com
Cc: kenmcd@gonzo.melbourne.sgi.com
Subject: nifty tools on Linux/IRIX
Date: Wed, 28 May 1997 12:24:36 -0700
From: Larry McVoy <lm@neteng.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel asked about cool tools.  Talk to Ken, he's the man.

------- Forwarded Message

Date:    Fri, 23 May 1997 05:20:54 -0500
From:    "Ken McDonell" <kenmcd@gonzo.melbourne.sgi.com>
To:      ptg@melbourne.sgi.com
cc:      lm@cthulhu
Subject: scary ... irix and linux exchange simple PCP PDUs

After minor brain-failure on my part, we have success at exchanging
the PDU headers (with no translation for the PDU body).

linux -> linux -> linux

[guest@linux pcp]$ ./pdu-client -D1 -h linux.engr.sgi.com 12345
pdu-client: PID 12334
pdu-client: connected fd=3
[12334]pmXmitPDU: DATA_X fd=3 len=16
000:       10     700b     302e 12345678 
[12334]pmGetPDU: DATA_X fd=3 len=16 from=12329 moreinput? no
000:       10     700b     3029 12345678 

linux -> irix -> linux

[guest@linux pcp]$ ./pdu-client -D1 -h bozo.melbourne.sgi.com 12345
pdu-client: PID 12333
pdu-client: connected fd=3
[12333]pmXmitPDU: DATA_X fd=3 len=16
000:       10     700b     302d 12345678 
[12333]pmGetPDU: DATA_X fd=3 len=16 from=29807 moreinput? no
000:       10     700b     746f 12345678 

irix -> linux -> irix

bozo 8% ./pdu-client -D1 -h linux.engr.sgi.com 12345
pdu-client: PID 29821
pdu-client: connected fd=3
[29821]pmXmitPDU: DATA_X fd=3 len=16
000:       10     700b     747d 12345678 
[29821]pmGetPDU: DATA_X fd=3 len=16 from=12329 moreinput? no
000:       10     700b     3029 12345678 

Now moving onto the translation of the PDU body for each PDU type.

------- End of Forwarded Message
