Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6GJCD519666
	for linux-mips-outgoing; Mon, 16 Jul 2001 12:12:13 -0700
Received: from saturn.mikemac.com (saturn.mikemac.com [216.99.199.88])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6GJCCV19663
	for <linux-mips@oss.sgi.com>; Mon, 16 Jul 2001 12:12:12 -0700
Received: from Saturn (localhost [127.0.0.1])
	by saturn.mikemac.com (8.9.3/8.9.3) with ESMTP id MAA09606;
	Mon, 16 Jul 2001 12:12:08 -0700
Message-Id: <200107161912.MAA09606@saturn.mikemac.com>
cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@oss.sgi.com,
   linux-mips@fnet.fr
Subject: Re: ll/sc emulation patch 
In-Reply-To: Your message of "Mon, 16 Jul 2001 11:47:04 PDT."
             <200107161847.LAA09164@saturn.mikemac.com> 
Date: Mon, 16 Jul 2001 12:12:08 -0700
From: Mike McDonald <mikemac@mikemac.com>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


>To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>Subject: Re: ll/sc emulation patch 
>Date: Mon, 16 Jul 2001 11:47:04 -0700
>From: Mike McDonald <mikemac@mikemac.com>
>
>
>>Date: Mon, 16 Jul 2001 14:03:30 +0200 (MET DST)
>>From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
>>To: Ralf Baechle <ralf@oss.sgi.com>
>>Subject: Re: ll/sc emulation patch

>> I didn't profile it very extensively, yet when stracing `ls /usr/lib'
>>(fileutils 4.1 linked against glibc 2.2.3) on my system once I yielded
>>~4500 syscalls of which ~4000 were _test_and_set() (or MIPS_ATOMIC_SET,
>>depending on my kernel/glibc configuration) invocations.  Yes, libpthread
>>appears to assume atomic operations are cheap, which is justifiable as
>>they are indeed, for almost every other CPU type. 
>
>  Not knowing anything about the glibc architecture, I have a dumb
>question: why is 'ls' doing anything at all with pthreads?

  OK, let me rephrase this: why are ~90% of ls's syscalls calls to
_test_and_set() when 'ls' is(??) a single threaded program? Does glibc
always assume it's running in a multithreaded environment?

  Mike McDonald
  mikemac@mikemac.com
