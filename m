Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9O6hgP28869
	for linux-mips-outgoing; Tue, 23 Oct 2001 23:43:42 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9O6hbD28864
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 23:43:37 -0700
Received: from scotty.mgnet.de (pD90247CB.dip.t-dialin.net [217.2.71.203])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id IAA14898
	for <linux-mips@oss.sgi.com>; Wed, 24 Oct 2001 08:43:35 +0200 (MET DST)
Received: (qmail 11718 invoked from network); 24 Oct 2001 06:43:34 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 24 Oct 2001 06:43:34 -0000
Date: Wed, 24 Oct 2001 08:43:35 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
In-Reply-To: <20011023171823.B3644@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0110240842170.2349-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Oct 2001, Ralf Baechle wrote:

> On Tue, Oct 23, 2001 at 02:41:33PM +0200, Klaus Naumann wrote:
> 
> > > > > 1. You don't compile shared libraries with -fpic/-fPIC.
> > > > > 2. Even if you do, you may overflow GOT table.
> > > > 
> > > > Well, even adding -fpic doesn't help a whole lot.
> > > > What is a GOT table ? And do you see any fix for the problem ?
> > > 
> > > -fpic is default on Linux/MIPS and as such adding that option won't have any
> > > effect.
> > 
> > I also tried -fPIC . -Wa,-xgot is also the default. -G X doesn't
> > change anything ...
> 
> -G is not supported with PIC and unless somebody really had his crack
> bucketwise or otherwise hates performance -Wa,-xgot isn't default.  ATM

No,

I meant it's default in the mozilla Makefile. Not really default
in binutils.

So to ask again, there is no other solution than -xgot ?
And if that's the only solution, what are the issues ? Only
bigger code ?

	Thx, Klaus


-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
