Received:  by oss.sgi.com id <S42238AbQGMWwI>;
	Thu, 13 Jul 2000 15:52:08 -0700
Received: from u-212.karlsruhe.ipdial.viaginterkom.de ([62.180.21.212]:58628
        "EHLO u-212.karlsruhe.ipdial.viaginterkom.de") by oss.sgi.com
	with ESMTP id <S42205AbQGMWwA>; Thu, 13 Jul 2000 15:52:00 -0700
Received: (ralf@lappi) by lappi.waldorf-gmbh.de id <S639437AbQGMWvz>;
        Fri, 14 Jul 2000 00:51:55 +0200
Date:   Fri, 14 Jul 2000 00:51:55 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "J. Scott Kasten" <jsk@tetracon-eng.net>
Cc:     Keith M Wesolowski <wesolows@foobazco.org>, linux-mips@oss.sgi.com
Subject: Re: Simple Linux/MIPS 0.2b
Message-ID: <20000714005155.C8972@bacchus.dhis.org>
References: <20000713001601.A27565@foobazco.org> <Pine.SGI.4.10.10007131037590.20247-100000@thor.tetracon-eng.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <Pine.SGI.4.10.10007131037590.20247-100000@thor.tetracon-eng.net>; from jsk@tetracon-eng.net on Thu, Jul 13, 2000 at 10:58:48AM -0300
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

On Thu, Jul 13, 2000 at 10:58:48AM -0300, J. Scott Kasten wrote:

> distro and drop them in place, everything seems happy and works fine.
> Thus, there's something funky about the so's I'm building myself.
> 
> I've tried building the XFree 4.0.1 libraries, Lesstiff libraries, and
> libraries from our own code base.  All breaks the same way.
> 
> #1 What form of black magic are you guys using to do this?

Holy Penguin Pee (TM).  Available at www.antarctica.com.br ;-)

> #2 Are there specific compiler flags/phases that should/shouldn't be used
> with MIPS arch so's that are different than what I'd normally do under
> Linux?

No compiler flags needed.

> #3 Should I be trying to cross compile the so's them selves instead of
> native builds?

That should make no difference in the resulting binaries if you use the
same versions of everything.

> #4 Are you using different flavors of gcc/binutils to do different jobs
> because of known breakages?

We have various known problems with the various binutils version around.
We're working on getting a current snapshot of binutils working
properly but right now we still have various problems, therefore
egcs 1.0.3a + binutils 2.8.1 is still the recommended version.

  Ralf
