Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f85LrRb32329
	for linux-mips-outgoing; Wed, 5 Sep 2001 14:53:27 -0700
Received: from neurosis.mit.edu (NEUROSIS.MIT.EDU [18.243.0.82])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f85LrPd32325
	for <linux-mips@oss.sgi.com>; Wed, 5 Sep 2001 14:53:25 -0700
Received: (from jim@localhost)
	by neurosis.mit.edu (8.11.4/8.11.4) id f85LrP029985
	for linux-mips@oss.sgi.com; Wed, 5 Sep 2001 17:53:25 -0400
Date: Wed, 5 Sep 2001 17:53:25 -0400
From: Jim Paris <jim@jtan.com>
To: linux-mips@oss.sgi.com
Subject: Re: segfault
Message-ID: <20010905175325.C26734@neurosis.mit.edu>
Reply-To: jim@jtan.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

[ resending to list, since I accidently replied only to Maciej ]

>  Since there appears to be no conclusion of the sysmips-on-MIPS-I problem
> in sight, I've just put all the related patches I use in a single place
> for easy retrieval.  All of them were sent to this mailing list once but
> digging through archives is tiresome.  Get them from
> 'ftp://ftp.ds2.pg.gda.pl/pub/macro/sysmips/'. 
> 
>  There is a sys_sysmips() fix in the "sysmips-1" patch and two additional
> patches implementing a sys__test_and_set() syscall and its usage in glibc. 
> Feel free to use them until an official solution is available. 

I applied these patches and I still have the same problem.

I'm starting to think that maybe my kernel is just too broken to use
with my recent binutils/gcc/glibc mix.  I was hoping that my efforts
to patch it up to 2.4.5 would have fixed that; I wish the linux-vr
tree was still being updated by people who actually knew what they
were doing (as I certainly don't).

-jim
