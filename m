Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5GB5tk02565
	for linux-mips-outgoing; Sat, 16 Jun 2001 04:05:55 -0700
Received: from dea.waldorf-gmbh.de (u-43-19.karlsruhe.ipdial.viaginterkom.de [62.180.19.43])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5GB5fZ02561
	for <linux-mips@oss.sgi.com>; Sat, 16 Jun 2001 04:05:41 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5G9MKC21300;
	Sat, 16 Jun 2001 11:22:20 +0200
Date: Sat, 16 Jun 2001 11:22:20 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>, Raoul Borenius <borenius@shuttle.de>,
   linux-mips@oss.sgi.com
Subject: Re: ksymoops changes for mips (was Kernel crash on boot with current cvs)
Message-ID: <20010616112220.A21117@bacchus.dhis.org>
References: <20010613140550.B31221@bacchus.dhis.org> <8465.992434754@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <8465.992434754@ocs4.ocs-net>; from kaos@melbourne.sgi.com on Wed, Jun 13, 2001 at 10:19:14PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 10:19:14PM +1000, Keith Owens wrote:

> >That can be done automatically.  For 32-bit ELF files mips*-linux binutils
> >dump some of the addresses as 32-bit addresses, some as sign-extended (!)
> >64-bit addresses.  So ksymops should just sign extend any 32-bit addresses
> >to 64-bit and then work on full lenght addresses.
> 
> Some utilities extend with leading 0, some with leading 1, some with
> special values (alpha).  It is safer to truncate everything to the
> specified width instead of guessing what the extension value is.

That's a processor specific thing.  In case of MIPS only signed extension
is correct.  Some older binutils did unsigned extension and that's plain
wrong.

> >Is ksymoops able to handle 64-bit addresses when running on a 32-bit host?
> >That is a common case for many people when decoding their MIPS oopses.
> 
> Yes and no.  The framework is there to handle 32/64 splits, sparc
> already uses it.  mips does not currently use the framework because the
> oops report does not identify the machine type 32/64, MSB/LSB.  We
> discussed this in January and I asked for a small change to mips64 oops
> output (below), was that ever done?

Nothing - ``Guilty as charged.  Filed in my "to do when I have time" folder,
which overflowed about 3 years ago :(.''

  Ralf
