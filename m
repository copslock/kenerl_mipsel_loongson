Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78FJIP13585
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:19:18 -0700
Received: from dea.waldorf-gmbh.de (u-121-18.karlsruhe.ipdial.viaginterkom.de [62.180.18.121])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78FJCV13571
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:19:13 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f78FI6J04205;
	Wed, 8 Aug 2001 17:18:06 +0200
Date: Wed, 8 Aug 2001 17:18:06 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc: Brandon Barker <bebarker@meginc.com>,
   "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010808171806.A4105@bacchus.dhis.org>
References: <20010808121706.A602@bacchus.dhis.org> <Pine.SGI.4.33.0108081042090.23638-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.SGI.4.33.0108081042090.23638-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Wed, Aug 08, 2001 at 11:02:44AM -0400
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Aug 08, 2001 at 11:02:44AM -0400, J. Scott Kasten wrote:

>    gcc -mips3 -mint64 test.c -o test
> 
> The file command says:
> 
>   test:           ELF N32 MSB mips-3 dynamic executable (not stripped) MIPS - version 1
> 
> Run:
> 
>   sizeof(int) = 8, sizeof(*) = 8
>   Result: 11
> 
> If we look at the assembly, we see a sign extended 64 bit load, and a 64
> bit add.  So we are indeed generating 64 bit instructions, at least in
> some cases.
> 
>         dli $3,0xa # 10
>         <snip>
>         daddu $3,$2,1
> 
> Does N32 legitimately allow 64 bit instructions,

Yes.  Hey, that's the 80% of the purpose of N32!

> or is this an example of code that I've truely "munged" togeather?

Doubleplusyesyesyes :-)  -mint64 is not valid for any MIPS code model.  Gas
is royally b0rken for N32.  If you really want to read about N32 get the
respective docs from techpubs.sgi.com.

  Ralf
