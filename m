Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Nov 2002 15:50:52 +0100 (MET)
Received: from f116.law9.hotmail.com ([IPv6:::ffff:64.4.9.116]:9996 "EHLO
	hotmail.com") by ralf.linux-mips.org with ESMTP id <S868732AbSK1ChD>;
	Thu, 28 Nov 2002 03:37:03 +0100
Received: from mail pickup service by hotmail.com with Microsoft SMTPSVC;
	 Wed, 27 Nov 2002 18:42:22 -0800
Received: from 12.18.185.141 by lw9fd.law9.hotmail.msn.com with HTTP;
	Thu, 28 Nov 2002 02:42:22 GMT
X-Originating-IP: [12.18.185.141]
From: "" <henaldohzh@hotmail.com>
To: linux-mips@linux-mips.org
Subject: Re: Problem about porting mips kernel
Date: Thu, 28 Nov 2002 02:42:22 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
Message-ID: <F116EbjkyqU7a0xtAEH00000946@hotmail.com>
X-OriginalArrivalTime: 28 Nov 2002 02:42:22.0746 (UTC) FILETIME=[C740CFA0:01C29687]
Return-Path: <henaldohzh@hotmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 723
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: henaldohzh@hotmail.com
Precedence: bulk
X-list: linux-mips

 I carefully check the codes of TLB, but no any problem found.
 And I debug my kernel, I found that before init task jump into 
application, it means after do_execve, sp is 0. it is for 
__strnlen_user_asm function return invalid result. And I done a little 
change(only for test), the system stop after ret_from_syscall. In normal, 
it should jump to user space to execute user task.
before ret_from_syscall, the start_thread arguments 
is:"elf_entry:0x2aaa8a00,user_sp is:0x7fff7f40,cp0_status is:0x200cc13".I 
determine that the arguments are correct. But why my application cann't run 
at all?
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
与联机的朋友进行交流，请使用 MSN Messenger: http://messenger.msn.com/cn 
