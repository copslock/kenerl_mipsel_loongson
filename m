Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f78FfkC17147
	for linux-mips-outgoing; Wed, 8 Aug 2001 08:41:46 -0700
Received: from iris1.csv.ica.uni-stuttgart.de (iris1.csv.ica.uni-stuttgart.de [129.69.118.2])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f78FfiV17138
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 08:41:44 -0700
Received: from rembrandt.csv.ica.uni-stuttgart.de (rembrandt.csv.ica.uni-stuttgart.de [129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de (8.9.3/8.9.3) with ESMTP id RAA189603
	for <linux-mips@oss.sgi.com>; Wed, 8 Aug 2001 17:41:42 +0200 (MDT)
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.22 #1 (Debian))
	id 15UVSo-0001R1-00
	for <linux-mips@oss.sgi.com>; Wed, 08 Aug 2001 17:41:42 +0200
Date: Wed, 8 Aug 2001 17:41:42 +0200
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: Indy 64 or 32 bit?
Message-ID: <20010808174142.F4452@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20010808171806.A4105@bacchus.dhis.org>
User-Agent: Mutt/1.3.18i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> On Wed, Aug 08, 2001 at 11:02:44AM -0400, J. Scott Kasten wrote:
> 
> >    gcc -mips3 -mint64 test.c -o test
> > 
> > The file command says:
> > 
> >   test:           ELF N32 MSB mips-3 dynamic executable (not stripped) MIPS - version 1
                          ^^^
I don't know how file detects this, but at least current CVS gas
does not set the appropriate flag in the object file header.

> > 
> > Run:
> > 
> >   sizeof(int) = 8, sizeof(*) = 8
                    ^              ^
This should be both 4, I assume this happened due to -mint64.

> >   Result: 11
> > 
> > If we look at the assembly, we see a sign extended 64 bit load, and a 64
> > bit add.  So we are indeed generating 64 bit instructions, at least in
> > some cases.
> > 
> >         dli $3,0xa # 10

To what does this dli get expanded? I'm interested in the output of
objdump -d.

[snip]
> > or is this an example of code that I've truely "munged" togeather?
> 
> Doubleplusyesyesyes :-)  -mint64 is not valid for any MIPS code model.  Gas
> is royally b0rken for N32.

WRT what?


Thiemo
