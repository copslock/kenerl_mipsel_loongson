Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9NBHxA01645
	for linux-mips-outgoing; Tue, 23 Oct 2001 04:17:59 -0700
Received: from dea.linux-mips.net (a1as16-p134.stg.tli.de [195.252.192.134])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9NBHpD01642
	for <linux-mips@oss.sgi.com>; Tue, 23 Oct 2001 04:17:52 -0700
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.1/8.11.1) id f9NBHLY12870;
	Tue, 23 Oct 2001 13:17:21 +0200
Date: Tue, 23 Oct 2001 13:17:21 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Klaus Naumann <spock@mgnet.de>
Cc: "H . J . Lu" <hjl@lucon.org>, linux-mips@oss.sgi.com,
   binutils@sourceware.cygnus.com
Subject: Re: The Linux binutils 2.11.92.0.7 is released.
Message-ID: <20011023131721.A12848@dea.linux-mips.net>
References: <20011021091125.A1774@lucon.org> <Pine.LNX.4.21.0110222242190.18455-100000@spock.mgnet.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.21.0110222242190.18455-100000@spock.mgnet.de>; from spock@mgnet.de on Mon, Oct 22, 2001 at 10:43:00PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Mon, Oct 22, 2001 at 10:43:00PM +0200, Klaus Naumann wrote:

> > 1. You don't compile shared libraries with -fpic/-fPIC.
> > 2. Even if you do, you may overflow GOT table.
> 
> Well, even adding -fpic doesn't help a whole lot.
> What is a GOT table ? And do you see any fix for the problem ?

-fpic is default on Linux/MIPS and as such adding that option won't have any
effect.

  Ralf
