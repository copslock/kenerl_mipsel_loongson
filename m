Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GIlHR17943
	for linux-mips-outgoing; Mon, 16 Jul 2001 11:47:17 -0700
Received: from saturn.mikemac.com (saturn.mikemac.com [216.99.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GIlGV17937
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 11:47:16 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id LAA09164;
	Mon, 16 Jul 2001 11:47:04 -0700
Message-Id: <200107161847.LAA09164@saturn.mikemac.com>
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
cc: linux-mips@oss.sgi.com, linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch 
In-Reply-To: Your message of "Mon, 16 Jul 2001 14:03:30 +0200."
             <Pine.GSO.3.96.1010716133926.12988B-100000@delta.ds2.pg.gda.pl> 
Date: Mon, 16 Jul 2001 11:47:04 -0700
From: Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>Date: Mon, 16 Jul 2001 14:03:30 +0200 (MET DST)
>From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>To: Ralf Baechle <ralf@oss.sgi.com>
>Subject: Re: ll/sc emulation patch
>
>On Sat, 14 Jul 2001, Ralf Baechle wrote:
>
>> I'm just making an attempt to re-implement the ll/sc emulation as light
>> as possible.  I hope to get the overhead down to the point were we don't
>> need _test_and_set anymore - in any case below the overhead of a syscall.
>> 
>> Have you ever profiled the number of calls to MIPS_ATOMIC_SET or
>> _test_and_set?  They'll be the other factor in a decission.
>
> I didn't profile it very extensively, yet when stracing `ls /usr/lib'
>(fileutils 4.1 linked against glibc 2.2.3) on my system once I yielded
>~4500 syscalls of which ~4000 were _test_and_set() (or MIPS_ATOMIC_SET,
>depending on my kernel/glibc configuration) invocations.  Yes, libpthread
>appears to assume atomic operations are cheap, which is justifiable as
>they are indeed, for almost every other CPU type. 

  Not knowing anything about the glibc architecture, I have a dumb
question: why is 'ls' doing anything at all with pthreads?

  Mike McDonald
  mikemac@mikemac.com
