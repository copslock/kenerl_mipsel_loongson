Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g662SRRw015402
	for <linux-mips-outgoing@oss.sgi.com>; Fri, 5 Jul 2002 19:28:27 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g662SRXX015401
	for linux-mips-outgoing; Fri, 5 Jul 2002 19:28:27 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from lahoo.mshome.net (vsat-148-63-243-254.c004.g4.mrt.starband.net [148.63.243.254])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g662S4Rw015392
	for <linux-mips@oss.sgi.com>; Fri, 5 Jul 2002 19:28:10 -0700
Received: from [192.168.0.76] (helo=prefect)
	by lahoo.mshome.net with smtp (Exim 3.12 #1 (Debian))
	id 17QfJO-0004tY-00; Fri, 05 Jul 2002 22:28:38 -0400
Message-ID: <01bd01c22495$53e99820$4c00a8c0@prefect>
From: "Bradley D. LaRonde" <brad@ltc.com>
To: <sseeger@stellartec.com>
Cc: <linux-mips@oss.sgi.com>
References: <01da01c2247f$b80c5e20$3501a8c0@wssseeger>
Subject: Re: sys_execve problem
Date: Fri, 5 Jul 2002 22:32:08 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
X-Spam-Status: No, hits=0.0 required=5.0 tests= version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

I meant "is /sbin/init statically linked?"

What /sbin/init are you using?  Have you tried a statically linked busybox
init?

Regards,
Brad

----- Original Message -----
From: "Steven Seeger" <sseeger@stellartec.com>
To: "'Bradley D. LaRonde'" <brad@ltc.com>
Cc: <linux-mips@oss.sgi.com>
Sent: Friday, July 05, 2002 7:57 PM
Subject: RE: sys_execve problem


> By init do you mean the init_task_union? That's in the data segment and
not
> static. ld.so is needed but it's also executable. It boots fine under
other
> kernels. I either have this problem with 2.4.19 or the 2.4.18 problem
where
> kfree doesn't free any memory and the system eventually runs out of memory
> because of the buffer caches. I'd love to get 2.4.19 booting because then
I
> wouldn't have to mess with a problem with 2.4.16 from SF where the
> current->user gets set to 0 somewhere in kernel_thread and crashes in
> do_fork. I know the kfree works on 2.4.19 because the system doesn't
freeze
> up when the rom block driver tries to call fsync_dev in rom_release like
it
> does on the 2.4.18. (It freezes up in sync_inodes)
>
> I'm about to look for a new job here. :)
>
> Steve
>
> >-----Original Message-----
> >From: Bradley D. LaRonde [mailto:brad@ltc.com]
> >Sent: Friday, July 05, 2002 4:39 PM
> >To: sseeger@stellartec.com
> >Cc: linux-mips@oss.sgi.com
> >Subject: Re: sys_execve problem
> >
> >
> >Is your init static?  Does it need ld.so?  Is ld.so executable
> >(that's a
> >tricky one).
> >
> >Regards,
> >Brad
> >
> >----- Original Message -----
> >From: "Steven Seeger" <sseeger@stellartec.com>
> >To: <linux-mips@oss.sgi.com>
> >Sent: Friday, July 05, 2002 12:15 PM
> >Subject: sys_execve problem
> >
> >
> >> Hey guys. I have compiled 2.4.19-ac1 from the CVS with the
> >linux_2_4 tag
> >for
> >> my NEC Osprey board (NEC VR4181) It boots fine and stuff,
> >but doesn't load
> >> init. I've confirmed with simple print statements that do_execve is
> >> returning a 0 at the point in fs/exec.c where it says "/*
> >execve success
> >*/"
> >> and yet init doesn't load. The system just sits there. I see
> >on a scope
> >that
> >> my timer interrupt is firing every 10 ms and the serial
> >console responds
> >> properly. It echos characters and stops the echo when it
> >receives a ctrl-S
> >> and resumes it on ctrl-Q. Obviously this is the last little
> >part of the
> >> kernel to work though here. Any ideas?
> >>
> >> Steve
> >
>
>
