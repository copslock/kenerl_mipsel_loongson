Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g65NpMRw014473
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 16:51:22 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g65NpMFK014472
	for linux-mips-outgoing; Fri, 5 Jul 2002 16:51:22 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from nt_server.stellartec.com (mail.stellartec.com [65.107.16.99])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g65NpDRw014463
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 16:51:13 -0700
Received: from wssseeger ([192.168.1.53]) by nt_server.stellartec.com
          (Post.Office MTA v3.1.2 release (PO205-101c)
          ID# 568-43562U100L2S100) with SMTP id AAA536;
          Fri, 5 Jul 2002 16:55:15 -0700
Reply-To: <sseeger@stellartec.com>
From: sseeger@stellartec.com (Steven Seeger)
To: "'Bradley D. LaRonde'" <brad@ltc.com>
Cc: <linux-mips@oss.sgi.com>
Subject: RE: sys_execve problem
Date: Fri, 5 Jul 2002 16:57:27 -0700
Message-ID: <01da01c2247f$b80c5e20$3501a8c0@wssseeger>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook CWS, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <006401c2247d$3356e580$4c00a8c0@prefect>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
X-Spam-Status: No, hits=-4.4 required=5.0 tests=IN_REP_TO version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

By init do you mean the init_task_union? That's in the data segment and not
static. ld.so is needed but it's also executable. It boots fine under other
kernels. I either have this problem with 2.4.19 or the 2.4.18 problem where
kfree doesn't free any memory and the system eventually runs out of memory
because of the buffer caches. I'd love to get 2.4.19 booting because then I
wouldn't have to mess with a problem with 2.4.16 from SF where the
current->user gets set to 0 somewhere in kernel_thread and crashes in
do_fork. I know the kfree works on 2.4.19 because the system doesn't freeze
up when the rom block driver tries to call fsync_dev in rom_release like it
does on the 2.4.18. (It freezes up in sync_inodes)

I'm about to look for a new job here. :)

Steve

>-----Original Message-----
>From: Bradley D. LaRonde [mailto:brad@ltc.com]
>Sent: Friday, July 05, 2002 4:39 PM
>To: sseeger@stellartec.com
>Cc: linux-mips@oss.sgi.com
>Subject: Re: sys_execve problem
>
>
>Is your init static?  Does it need ld.so?  Is ld.so executable
>(that's a
>tricky one).
>
>Regards,
>Brad
>
>----- Original Message -----
>From: "Steven Seeger" <sseeger@stellartec.com>
>To: <linux-mips@oss.sgi.com>
>Sent: Friday, July 05, 2002 12:15 PM
>Subject: sys_execve problem
>
>
>> Hey guys. I have compiled 2.4.19-ac1 from the CVS with the
>linux_2_4 tag
>for
>> my NEC Osprey board (NEC VR4181) It boots fine and stuff,
>but doesn't load
>> init. I've confirmed with simple print statements that do_execve is
>> returning a 0 at the point in fs/exec.c where it says "/*
>execve success
>*/"
>> and yet init doesn't load. The system just sits there. I see
>on a scope
>that
>> my timer interrupt is firing every 10 ms and the serial
>console responds
>> properly. It echos characters and stops the echo when it
>receives a ctrl-S
>> and resumes it on ctrl-Q. Obviously this is the last little
>part of the
>> kernel to work though here. Any ideas?
>>
>> Steve
>
