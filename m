Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 26 Nov 2002 03:16:30 +0100 (MET)
Received: from f169.law9.hotmail.com ([IPv6:::ffff:64.4.9.169]:5380 "EHLO
	hotmail.com") by ralf.linux-mips.org with ESMTP id <S868817AbSKZCQT>;
	Tue, 26 Nov 2002 03:16:19 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Mon, 25 Nov 2002 18:22:02 -0800
Received: from 12.18.185.141 by lw9fd.law9.hotmail.msn.com with HTTP;
	Tue, 26 Nov 2002 02:22:02 GMT
X-Originating-IP: [12.18.185.141]
From: "" <henaldohzh@hotmail.com>
To: jeff_lee@coventive.com
Cc: linux-mips@linux-mips.org
Subject: RE: Problem about porting mips kernel
Date: Tue, 26 Nov 2002 02:22:02 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <F169TgbLYluLCTaogxL00000112@hotmail.com>
X-OriginalArrivalTime: 26 Nov 2002 02:22:02.0868 (UTC) FILETIME=[9B52B340:01C294F2]
Return-Path: <henaldohzh@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 721
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: henaldohzh@hotmail.com
Precedence: bulk
X-list: linux-mips


  Yes. I have disabled the cache once on menuconfig. But still same 
problem.


>From: "jeff" <jeff_lee@coventive.com>
>To: <henaldohzh@hotmail.com>, <ralf@linux-mips.org>
>CC: <linux-mips@linux-mips.org>
>Subject: RE: Problem about porting mips kernel
>Date: Tue, 26 Nov 2002 10:23:05 +0800
>
>Hi, can you turn off the cache on menuconfig and try again?
>
>Regards,
>
>Jeff
>
>-----Original Message-----
>From: linux-mips-bounce@linux-mips.org 
[mailto:linux-mips-bounce@linux-mips.org]On Behalf Of 
henaldohzh@hotmail.com
>Sent: Tuesday, November 26, 2002 10:06 AM
>To: ralf@linux-mips.org
>Cc: linux-mips@linux-mips.org
>Subject: Re: Problem about porting mips kernel
>
>
>I think that kernel had been configured properly, because I can open the
>ttyS0 device in ramdisk. It means no ramdisk problem. But I have not any
>experience to fix tlb or cache bug. If you can give some more advice? Thx.
>
>
>
>
> >From: Ralf Baechle <ralf@linux-mips.org>
> >To: henaldohzh@hotmail.com
> >CC: linux-mips@linux-mips.org
> >Subject: Re: Problem about porting mips kernel
> >Date: Mon, 25 Nov 2002 13:53:10 +0100
> >
> >On Mon, Nov 25, 2002 at 12:47:28PM +0000, henaldohzh@hotmail.com wrote:
> >
> > >   these days, I am busy with porting mips kernel to a board with 
vr4131
> > > core. This board has only SIU serial port, and some hw have been
>modified.
> > > Now, I have ported the kernel to it, and modified hw run well. But so
> > > puzzling me, the execution file cann't run at all. If some one can 
help
>me
> > > or give some advices. I have been crazy for the problem. Off hat for
>your
> > > help. Thanks a lot.
> > >  btw, I use the ramdisk with busybox.
> >
> >In general this kind of problem means the tlb or cache code for a
>particular
> >platform is faulty or the kernel not configured properly.
> >
> >   Ralf
>
>
>_________________________________________________________________
>免费下载 MSN Explorer:  http://explorer.msn.com/lccn/


_________________________________________________________________
与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/lccn/ 
