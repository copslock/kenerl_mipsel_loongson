Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7EFTac12128
	for linux-mips-outgoing; Tue, 14 Aug 2001 08:29:36 -0700
Received: from web11904.mail.yahoo.com (web11904.mail.yahoo.com [216.136.172.188])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7EFTXj12123
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 08:29:33 -0700
Message-ID: <20010814152933.67337.qmail@web11904.mail.yahoo.com>
Received: from [209.243.184.191] by web11904.mail.yahoo.com; Tue, 14 Aug 2001 08:29:33 PDT
Date: Tue, 14 Aug 2001 08:29:33 -0700 (PDT)
From: Wayne Gowcher <wgowcher@yahoo.com>
Subject: Re: Benchmark performance
To: Ralf Baechle <ralf@oss.sgi.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <20010814095152.A5928@bacchus.dhis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf,

Thanks for the input.

> > a 3 % reduction in the Memory Index benchmark
> > a 2 % increase in the Integer Index benchmark
> > a 23 % reduction in the Floating Point Index
> benchmark
> 
> Small fluctuations in the range of 2 or 3 percent
> are usually explained
> by a changing usage pattern of the caches. 
> Therefore rerunning a the
> benchmarks is a good idea.  Especially
> microbenchmarks a la lmbench on
> caches of low associativity like the direct mapped
> R4k caches are extremly
> easily affected by cache usage patterns.

I messed up the figures for the redhat 7.1 case They
should have been :

Memory Index   6.7 % decrease
Integer Index  2 % decrease
Floating Point 27 % decrease

And it was the progressive reduction in performance of
the Memory Index that was raising a red flag to me.
Especially the big hit in floating point performance.

> Did you get any kernel messages during the Floating
> Point Index benchmark
> on the older kernel?

No, everything ran fine.

> > newer kernel and with a newer distribution ? newer
> > compiler ?
> 
> Gcc 3.0 has been reported to produce slightly slower
> code than it's
> predecessor by many people on various architecture. 
> I'm sad to find that
> MIPS is also one of them.

OK. That's one to remember.

> As for the kernel - I don't really know; your
> analysis isn't fine grained
> enough.

I didn't do any performance tweaking with the kernel
itself as I wouldn't really know how to go about it. I
was more trying to use a base kernel and then see how
I could improve the benchmark performance by using
compile options on the benchmark program only.
Admittedly improving kernel performance is a far more
efficient way of improving the benchmark scores.

> Successful tuning requires a detailed analysis
> first.

I read an article recently in Linux Journal on
tweaking an Alpha kernel. I suppose the same general
principles can be applied to MIPS. Alternatively, do
you ( or anyone else ) know of a howto or even a
general article on how to do this ?

I downloaded the benchmark from :

http://www.tux.org/~mayer/linux/bmark.html

Wayne

__________________________________________________
Do You Yahoo!?
Make international calls for as low as $.04/minute with Yahoo! Messenger
http://phonecard.yahoo.com/
