Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.5/8.12.5) with ESMTP id g6OJMkRw006129
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 24 Jul 2002 12:22:46 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.5/8.12.3/Submit) id g6OJMk1X006128
	for linux-mips-outgoing; Wed, 24 Jul 2002 12:22:46 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from sentinel.sanera.net (ns1.sanera.net [208.253.254.10])
	by oss.sgi.com (8.12.5/8.12.5) with SMTP id g6OJMaRw006119;
	Wed, 24 Jul 2002 12:22:36 -0700
Received: from icarus.sanera.net (icarus [192.168.254.11])
	by sentinel.sanera.net (8.11.2/8.11.2) with ESMTP id g6OJNX510274;
	Wed, 24 Jul 2002 12:23:33 -0700
Received: from exceed2.sanera.net (exceed2.sanera.net [172.16.2.39])
	by icarus.sanera.net (8.11.6/8.11.6) with SMTP id g6OJNRi30295;
	Wed, 24 Jul 2002 12:23:27 -0700
Message-Id: <200207241923.g6OJNRi30295@icarus.sanera.net>
Date: Wed, 24 Jul 2002 12:23:27 -0700 (PDT)
From: Krishna Kondaka <krishna@Sanera.net>
Reply-To: Krishna Kondaka <krishna@Sanera.net>
Subject: Re: kernel BUG at slab.c:1073!
To: ralf@oss.sgi.com
Cc: linux-mips@oss.sgi.com
MIME-Version: 1.0
Content-Type: TEXT/plain; charset=us-ascii
Content-MD5: vkNzuE5Y0s5FHGqHUjFR2g==
X-Mailer: dtmail 1.3.0 @(#)CDE Version 1.4.2 SunOS 5.8 sun4u sparc 
X-Spam-Status: No, hits=0.6 required=5.0 tests=PLING,PORN_10 version=2.20
X-Spam-Level: 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>
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
>
>Simple answer: it isn't, normally.  You should try to figure out who was
>calling kmalloc or the slab allocator; knowing the function will probably
>already solve the miracle.  All the addresses in the call trace that are
>in the range from 0xc0000000 and above are potencially modules addresses,
>so they're worth some closer examination.

well, my init code is some what like this -

int __init xxx_init(void)
{
	...
	xxx_init_instance();
}

int xxx_init_instance()
{
	...some code containing locks and unlocks()...
	xxx_inst = kmalloc(size, GFP_KERNEL);
}

So from this code, only xxx_init_instance should be calling kmalloc(). I will
check the caller and let you know.

>
>Aside, I urgently recommend an upgrade to a newer kernel.  2.4.9 is lacking
>more than half a year worth of bug fixes.  That can ruin your whole day ...

Unfortunately, it's not that easy. It will ruin more than a single day
for more than one person! We will very soon move to the version supplied by
monta vista based on 2.4.17.

Krishna

>
>  Ralf
