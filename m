Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IFFqY00675
	for linux-mips-outgoing; Tue, 18 Sep 2001 08:15:52 -0700
Received: from web10802.mail.yahoo.com (web10802.mail.yahoo.com [216.136.130.244])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IFFne00665
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 08:15:49 -0700
Message-ID: <20010918151548.75811.qmail@web10802.mail.yahoo.com>
Received: from [12.146.133.130] by web10802.mail.yahoo.com via HTTP; Tue, 18 Sep 2001 08:15:48 PDT
Date: Tue, 18 Sep 2001 08:15:48 -0700 (PDT)
From: han han <piggie111000@yahoo.com>
Subject: Re: How to access kernel memory?
To: Zhang Fuxin <fxzhang@ict.ac.cn>
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

>    There are several ways.For example:
>    1.You can create a character device , implement
> its mmap function
> to map the memory block you allcated.This can be
> done in a little
> kernel module.There are some sample code before.
>    2.via /dev/mem,/dev/kmem etc

If allocating a block memory in the user space. I can
use functions like "map_user_kiobuf()" to lock it in
the physical memory and access it in the kernel space.
Does there exist corresponding methods to give my
application ability to directly access it without
using any kinds of mem/character devices?

> 
> 
> 
> 
> ÔÚ 2001-09-18 07:35:00 you wrote£º
> >Hi, All,
> >
> >I allocated a block of memory in the kernel space.
> But
> >I don't know how to directly access kernel space
> from
> >user space. Anyone can help me?
> >
> >Thanks in advance.
> >
> >piggie
> >
> >
> >__________________________________________________
> >Terrorist Attacks on U.S. - How can you help?
> >Donate cash, emergency relief information
>
>http://dailynews.yahoo.com/fc/US/Emergency_Information/
> 
> Regards
>             Zhang Fuxin
>             fxzhang@ict.ac.cn
> 


__________________________________________________
Terrorist Attacks on U.S. - How can you help?
Donate cash, emergency relief information
http://dailynews.yahoo.com/fc/US/Emergency_Information/
