Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2006 06:05:05 +0100 (BST)
Received: from mail1.lge.co.kr ([156.147.1.151]:59345 "EHLO mail1.lge.co.kr")
	by ftp.linux-mips.org with ESMTP id S8133367AbWD0FEz (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Apr 2006 06:04:55 +0100
Received: from [150.150.71.243] (jsungkim@lge.com) by 
          mail1.lge.co.kr (Terrace MailWatcher) 
          with ESMTP id 2006042714:04:45:263075.280.53
          for <kevink@mips.com>; 
          Thu, 27 Apr 2006 14:04:45 +0900 (KST) 
From:	"Kim, Jong-Sung" <jsungkim@lge.com>
To:	"'Kevin D. Kissell'" <kevink@mips.com>
Cc:	<linux-mips@linux-mips.org>
Subject: RE: Reading an entire cacheline
Date:	Thu, 27 Apr 2006 14:04:07 +0900
Message-ID: <00fc01c669b8$0319f6d0$f3479696@LGE.NET>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2869
thread-index: AcZpI6WdesB47VwiQC6Il3XWvKC/4gAfcEmg
In-Reply-To: <005701c66924$00a74860$10eca8c0@grendel>
X-TERRACE-SPAMMARK: NOT spam-marked.                              
  (by Terrace)                                            
Return-Path: <jsungkim@lge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jsungkim@lge.com
Precedence: bulk
X-list: linux-mips

Dear Mr. Kissell,

Thank you for your advices about disassembling. Please see:

1380:	...
1384:	00431025	or	v0,v0,v1
1388:	00441025	or	v0,v0,a0
138c:	bc450000	cache	0x5,0(v0)
1390:	4002e000	mfc0	v0,c0_taglo
1394:	4003e001	mfc0	v1,c0_datalo
1398:	4004e801	mfc0	a0,c0_datahi
139c:	bc450008	cache	0x5,8(v0)
13a0:	4005e000	mfc0	a1,c0_taglo
13a4:	4006e001	mfc0	a2,c0_datalo
13a8:	4007e801	mfc0	a3,c0_datahi
13ac:	bc450010	cache	0x5,16(v0)
13b0:	4008e000	mfc0	t0,c0_taglo
13b4:	4009e001	mfc0	t1,c0_datalo
13b8:	400ae801	mfc0	t2,c0_datahi
13bc:	bc450010	cache	0x5,16(v0)
13c0:	400be000	mfc0	t3,c0_taglo
13c4:	400ee001	mfc0	t6,c0_datalo
13c8:	400ce801	mfc0	t4,c0_datahi
13cc:	ae020020	sw	v0,32(s0)
13d0:	ae030060	sw	v1,96(s0)
13d4:	...

It seems no memory variable is accessed during the sequence. The obviously
unexpected thing is the use of register v0. It should have the value of the
index and should not be touched before the execution of the last cache
instruction. In this way, tags read are doomed to be different.

It's my fault. So, I corrected the "=r" to be "=&r", and it seems work.
Thank you again.

Regards,
JS.


-----Original Message-----
From: linux-mips-bounce@linux-mips.org
[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of Kevin D. Kissell
Sent: Wednesday, April 26, 2006 8:25 PM
To: Kim, Jong-Sung; Thiemo Seufer
Cc: linux-mips@linux-mips.org
Subject: Re: Reading an entire cacheline

> [snip]
> > //" bne %0, %9, 2b\n"
> > " .set mips0\n"
> > " .set reorder"
> > : "=r" (tag[1][way][0]), "=r" (datalo[1][way][0]),
> >   "=r" (datahi[1][way][0]),
> >   "=r" (tag[1][way][1]), "=r" (datalo[1][way][1]),
> >   "=r" (datahi[1][way][1]),
> >   "=r" (tag[1][way][2]), "=r" (datalo[1][way][2]),
> >   "=r" (datahi[1][way][2]),
> >   "=r" (tag[1][way][3]), "=r" (datalo[1][way][3]),
> >   "=r" (datahi[1][way][3])
> > : "r" (0x80000000 | (way << 14) | (line << 5))
> > );
> 
> And this part may cause the problem you are seeing, I presume
> datalo/datahi live in memory, and accesses of it change the dcache.

As I was hoping disassembly would demonstrate for you,
declaring "=r" doesn't mean that the variable has no life
outside a register.

            Regards,

            Kevin K.
