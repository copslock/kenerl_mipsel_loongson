Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7E8x8w03412
	for linux-mips-outgoing; Tue, 14 Aug 2001 01:59:08 -0700
Received: from dea.waldorf-gmbh.de (u-198-10.karlsruhe.ipdial.viaginterkom.de [62.180.10.198])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7E8wxj03344
	for <linux-mips@oss.sgi.com>; Tue, 14 Aug 2001 01:58:59 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f7E7pqw06166;
	Tue, 14 Aug 2001 09:51:52 +0200
Date: Tue, 14 Aug 2001 09:51:52 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Wayne Gowcher <wgowcher@yahoo.com>
Cc: linux-mips@oss.sgi.com
Subject: Re: Benchmark performance
Message-ID: <20010814095152.A5928@bacchus.dhis.org>
References: <20010809215522.A1958@lucon.org> <20010813173446.61234.qmail@web11901.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010813173446.61234.qmail@web11901.mail.yahoo.com>; from wgowcher@yahoo.com on Mon, Aug 13, 2001 at 10:34:46AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Aug 13, 2001 at 10:34:46AM -0700, Wayne Gowcher wrote:

> I have been running the nbench-byte-2.1 benchmark on a
> mips r4k processor with various combinations of kernel
> and distribution packages. I initially started with a
> 2.4.2 kernel using the redhat 5.1 distribution found
> on the SGI mips site. I compiled nbench native on the
> target with redhat mounted via nfs. I used this as my
> base.
> 
> I then ran a 2.4.6 kernel on the same mips 4k
> processor, but this time with the redhat 7.0
> distribution. I compiled native using the
> distributions compiler. This resulted in :
> 
> a 3 % reduction in the Memory Index benchmark
> a 2 % increase in the Integer Index benchmark
> a 23 % reduction in the Floating Point Index benchmark

Small fluctuations in the range of 2 or 3 percent are usually explained
by a changing usage pattern of the caches.  Therefore rerunning a the
benchmarks is a good idea.  Especially microbenchmarks a la lmbench on
caches of low associativity like the direct mapped R4k caches are extremly
easily affected by cache usage patterns.

Did you get any kernel messages during the Floating Point Index benchmark
on the older kernel?

> a, has suggestions on how to optimize compiler
> performance.
> 
> b, may know why performance seems to degrade with a
> newer kernel and with a newer distribution ? newer
> compiler ?

Gcc 3.0 has been reported to produce slightly slower code than it's
predecessor by many people on various architecture.  I'm sad to find that
MIPS is also one of them.

As for the kernel - I don't really know; your analysis isn't fine grained
enough.  I don't run kernel benchmarks religiously on every version but
what I can say my number have in part risen dramatically.

> c, any other tips for improving kernel / application
> performance.

Successful tuning requires a detailed analysis first.

  Ralf
