Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f8IFAdx00550
	for linux-mips-outgoing; Tue, 18 Sep 2001 08:10:39 -0700
Received: from mail.ict.ac.cn ([159.226.39.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f8IFAYe00546
	for <linux-mips@oss.sgi.com>; Tue, 18 Sep 2001 08:10:34 -0700
Message-Id: <200109181510.f8IFAYe00546@oss.sgi.com>
Received: (qmail 27998 invoked from network); 18 Sep 2001 15:04:44 -0000
Received: from unknown (HELO heart1) (159.226.39.162)
  by 159.226.39.4 with SMTP; 18 Sep 2001 15:04:44 -0000
Date: Tue, 18 Sep 2001 23:9:53 +0800
From: Zhang Fuxin <fxzhang@ict.ac.cn>
To: "Siders, Keith" <keith_siders@toshibatv.com>
CC: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: RE: How to access kernel memory?
X-mailer: FoxMail 3.11 Release [cn]
Mime-Version: 1.0
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by oss.sgi.com id f8IFAZe00547
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

hi,Siders, Keith£¬
   Hehe,I can think of some usage of 'hot-patched': virus or security
daemon,binary code enhancement or some kind of transform,auto parallelize...:)
   But all this could be done through /dev/mem,in theory.


ÔÚ 2001-09-18 09:59:00 you wrote£º
>I have just the opposite requirement. I need to allow any running process
>and its threads to be "hot-patched" with executable code. I know you're
>thinking "why?". I can't tell you that. I can only say  it's a firm
>requirement, and I could use some helpful ideas.
>
>Keith 
>
>-> -----Original Message-----
>-> From: Zhang Fuxin [mailto:fxzhang@ict.ac.cn]
>-> Sent: Tuesday, September 18, 2001 9:53 AM
>-> To: han han
>-> Cc: linux-mips@oss.sgi.com
>-> Subject: Re: How to access kernel memory?
>-> 
>-> 
>-> hi,han han£¬
>->    There are several ways.For example:
>->    1.You can create a character device , implement its mmap function
>-> to map the memory block you allcated.This can be done in a little
>-> kernel module.There are some sample code before.
>->    2.via /dev/mem,/dev/kmem etc
>->    
>-> 
>-> 
>-> 
>-> ÔÚ 2001-09-18 07:35:00 you wrote£º
>-> >Hi, All,
>-> >
>-> >I allocated a block of memory in the kernel space. But
>-> >I don't know how to directly access kernel space from
>-> >user space. Anyone can help me?
>-> >
>-> >Thanks in advance.
>-> >
>-> >piggie
>-> >
>-> >
>-> >__________________________________________________
>-> >Terrorist Attacks on U.S. - How can you help?
>-> >Donate cash, emergency relief information
>-> >http://dailynews.yahoo.com/fc/US/Emergency_Information/
>-> 
>-> Regards
>->             Zhang Fuxin
>->             fxzhang@ict.ac.cn
>-> 

Regards
            Zhang Fuxin
            fxzhang@ict.ac.cn
