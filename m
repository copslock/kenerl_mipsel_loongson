Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9NCfd303366
	for linux-mips-outgoing; Tue, 23 Oct 2001 05:41:39 -0700
Received: from post.webmailer.de (natpost.webmailer.de [192.67.198.65])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9NCfaD03360
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 05:41:36 -0700
Received: from scotty.mgnet.de (pD9024776.dip.t-dialin.net [217.2.71.118])
	by post.webmailer.de (8.9.3/8.8.7) with SMTP id OAA04901
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 14:41:33 +0200 (MET DST)
Received: (qmail 5509 invoked from network); 23 Oct 2001 12:41:32 -0000
Received: from spock.mgnet.de (192.168.1.4)
  by scotty.mgnet.de with SMTP; 23 Oct 2001 12:41:32 -0000
Date: Tue, 23 Oct 2001 14:41:33 +0200 (CEST)
From: Klaus Naumann <spock@mgnet.de>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
In-Reply-To: <20011023131721.A12848@dea.linux-mips.net>
Message-ID: <Pine.LNX.4.21.0110231440550.1967-100000@spock.mgnet.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 23 Oct 2001, Ralf Baechle wrote:

> On Mon, Oct 22, 2001 at 10:43:00PM +0200, Klaus Naumann wrote:
> 
> > > 1. You don't compile shared libraries with -fpic/-fPIC.
> > > 2. Even if you do, you may overflow GOT table.
> > 
> > Well, even adding -fpic doesn't help a whole lot.
> > What is a GOT table ? And do you see any fix for the problem ?
> 
> -fpic is default on Linux/MIPS and as such adding that option won't have any
> effect.

I also tried -fPIC . -Wa,-xgot is also the default. -G X doesn't
change anything ...
Other solutions ?

	Thanks, Klaus

-- 
Full Name   : Klaus Naumann     | (http://www.mgnet.de/) (Germany)
Nickname    : Spock             | Org.: Mad Guys Network
Phone / FAX : ++49/177/7862964  | E-Mail: (spock@mgnet.de)
PGP Key     : www.mgnet.de/keys/key_spock.txt
