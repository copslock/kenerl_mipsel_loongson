Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2002 03:00:57 +0100 (MET)
Received: from f61.law9.hotmail.com ([IPv6:::ffff:64.4.9.61]:41988 "EHLO
	hotmail.com") by ralf.linux-mips.org with ESMTP id <S868814AbSKZCAq>;
	Tue, 26 Nov 2002 03:00:46 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 25 Nov 2002 18:06:22 -0800
Received: from 12.18.185.141 by lw9fd.law9.hotmail.msn.com with HTTP;
	Tue, 26 Nov 2002 02:06:21 GMT
X-Originating-IP: [12.18.185.141]
From: "" <henaldohzh@hotmail.com>
To: ralf@linux-mips.org
Cc: linux-mips@linux-mips.org
Subject: Re: Problem about porting mips kernel
Date: Tue, 26 Nov 2002 02:06:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <F61cMzfoV1qdiixjnzi000000e5@hotmail.com>
X-OriginalArrivalTime: 26 Nov 2002 02:06:22.0226 (UTC) FILETIME=[6AA81F20:01C294F0]
Return-Path: <henaldohzh@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 719
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: henaldohzh@hotmail.com
Precedence: bulk
X-list: linux-mips

I think that kernel had been configured properly, because I can open the 
ttyS0 device in ramdisk. It means no ramdisk problem. But I have not any 
experience to fix tlb or cache bug. If you can give some more advice? Thx.




>From: Ralf Baechle <ralf@linux-mips.org>
>To: henaldohzh@hotmail.com
>CC: linux-mips@linux-mips.org
>Subject: Re: Problem about porting mips kernel
>Date: Mon, 25 Nov 2002 13:53:10 +0100
>
>On Mon, Nov 25, 2002 at 12:47:28PM +0000, henaldohzh@hotmail.com wrote:
>
> >   these days, I am busy with porting mips kernel to a board with vr4131
> > core. This board has only SIU serial port, and some hw have been 
modified.
> > Now, I have ported the kernel to it, and modified hw run well. But so
> > puzzling me, the execution file cann't run at all. If some one can help 
me
> > or give some advices. I have been crazy for the problem. Off hat for 
your
> > help. Thanks a lot.
> >  btw, I use the ramdisk with busybox.
>
>In general this kind of problem means the tlb or cache code for a 
particular
>platform is faulty or the kernel not configured properly.
>
>   Ralf


_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:  http://explorer.msn.com/lccn/ 
