Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJ7lRw005701
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:07:47 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJ7lYb005700
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:07:47 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJ7gRw005691
	for <linux-mips@oss.sgi.com>; Wed, 24 Jul 2002 12:07:43 -0700
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g6OJ8d510075;
	Wed, 24 Jul 2002 12:08:39 -0700
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g6OJ8Yi29618;
	Wed, 24 Jul 2002 12:08:34 -0700
Message-Id: <200207241908.g6OJ8Yi29618@icarus.sanera.net>
Date: Wed, 24 Jul 2002 12:08:34 -0700 (PDT)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Re: kernel BUG at slab.c:1073!
To: jsun@mvista.com
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: q9CWB32feEV7Z+KQa0IiAQ==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
X-Spam-Status: No, hits=0.5 required=5.0 tests=PLING version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>> slab.c : line 1072-1073 is        
>> 
>> if (in_interrupt() && (flags & SLAB_LEVEL_MASK) != SLAB_ATOMIC)
>>                 BUG();
>> 
>> The driver being loaded is a small proprietary driver. The init routine of
>> the driver is doing kmalloc() with GFP_KERNEL as the second argument. I know
>> that I can fix my driver to use GFP_ATOMIC if running in interrupt context.
>> 
>> My question is why is the "insmod" command running in interrupt context?
>> 
>
>I don't think insmod should have interrupt context set.
>
>Do you have preemptible kernel enabled?  This problem often happens if 
>preemptible kernel is enabled and there is a missing interrupt path not pre-k 
>ready.
>

Thanks for the quick reply jun,

I don't think I am running preemptible kernel. Is there /proc file that shows
if I am running preemptible kernel or not?

Thanks
Krishna

>Jun
