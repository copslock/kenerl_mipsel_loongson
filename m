Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 20:32:55 +0100 (BST)
Received: from mxout2.netvision.net.il ([IPv6:::ffff:194.90.9.21]:14485 "EHLO
	mxout2.netvision.net.il") by linux-mips.org with ESMTP
	id <S8225211AbTDVTcy>; Tue, 22 Apr 2003 20:32:54 +0100
Received: from mail.riverhead.com ([194.90.64.163]) by mxout2.netvision.net.il
 (iPlanet Messaging Server 5.2 HotFix 1.08 (built Dec  6 2002))
 with ESMTP id <0HDR00CB2FMO1C@mxout2.netvision.net.il> for
 linux-mips@linux-mips.org; Tue, 22 Apr 2003 22:32:48 +0300 (IDT)
Received: from exchange.riverhead.com (exchange.riverhead.com [10.0.0.10])
	by mail.riverhead.com (8.11.0/8.11.0) with ESMTP id h3MJbo516496; Tue,
 22 Apr 2003 22:37:50 +0300
Date: Tue, 22 Apr 2003 22:32:14 +0200
From: Gilad Benjamini <gilad@riverhead.com>
Subject: Re: Crash on insmod
To: ilya@theIlya.com
Cc: kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Message-id: <328392AA673C0A49B54DABA457E37DAA15EEAB@exchange>
MIME-version: 1.0
X-MIMEOLE: Produced By Microsoft Exchange V6.0.4417.0
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7BIT
Content-class: urn:content-classes:message
Thread-topic: Crash on insmod
Thread-index: AcMJCmfBboi+WuucQuOMFRlm5in5vQ==
X-RAV-AntiVirus: This e-mail has been scanned for viruses on host:
 mail.riverhead.com
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Return-Path: <gilad@riverhead.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2133
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@riverhead.com
Precedence: bulk
X-list: linux-mips

Maybe I wasn't clear.
I CAN get a trace from ksymoops, but it's different each time.
I've seen hangs in sys_create_module (printk-s proved it to be OK),
I've seen hangs in stack_done, I've seen situtations where lsmod shows
the module as initializing. 
The only thing that's consistent is the info below for one of my
modules,
and do_page_fault (I may be in-accurate on the name) for another module.
All other 8 modules show no problems.

On Tue, Apr 22, 2003 at 07:38:57PM +0200, Gilad Benjamini wrote:
> Sad to say that this IS the interesting part.
> The ksymoops data is very un-consistent. This is the only thing that
is
> consistent.
Umm... Not having backtrace makes this information virtually useless.
You can reconstruct backtrace manually, by looking at call stack
addresses, and finding them in System.map.

> 
> > -----Original Message-----
> > From: ilya@theIlya.com [mailto:ilya@theIlya.com]
> > Sent: Tuesday, April 22, 2003 6:27 PM
> > To: Gilad Benjamini
> > Cc: kernelnewbies@nl.linux.org; linux-mips@linux-mips.org
> > Subject: Re: Crash on insmod
> > 
> > 
> > I think this is not an interesting part.
> > run the whole thing through ksymoops, and send output here.
> > For mor information see linux/Documentation/OOPS-tracing
> > 
> > 	Ilya
> > 
> > On Tue, Apr 22, 2003 at 10:15:32AM +0000, Gilad Benjamini wrote:
> > > This is the interesting part from the oops message:
> > > 
> > > Using /lib/modules/2.4.20-pre6-sb20021114 ...
> > > unable to handle kernel paging request at virtual address 
> > 00006e76, epc == c0005100, ra == 80117e08
> > > Oops in fault.c::do_page_fault, line 224:
> > > 
> > > 
> > > 
> > > 
> > > 
> > 
