Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DC6nR18573
	for linux-mips-outgoing; Wed, 13 Jun 2001 05:06:49 -0700
Received: from dea.waldorf-gmbh.de (u-115-20.karlsruhe.ipdial.viaginterkom.de [62.180.20.115])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DC6hP18551
	for <linux-mips@oss.sgi.com>; Wed, 13 Jun 2001 05:06:43 -0700
Received: (from ralf@localhost)
	by dea.waldorf-gmbh.de (8.11.1/8.11.1) id f5DC5ph31911;
	Wed, 13 Jun 2001 14:05:51 +0200
Date: Wed, 13 Jun 2001 14:05:51 +0200
From: Ralf Baechle <ralf@oss.sgi.com>
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Florian Lohoff <flo@rfc822.org>, Raoul Borenius <borenius@shuttle.de>,
   linux-mips@oss.sgi.com
Subject: Re: Kernel crash on boot with current cvs (todays)
Message-ID: <20010613140550.B31221@bacchus.dhis.org>
References: <20010613125610.A18235@paradigm.rfc822.org> <7964.992432058@ocs4.ocs-net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <7964.992432058@ocs4.ocs-net>; from kaos@melbourne.sgi.com on Wed, Jun 13, 2001 at 09:34:18PM +1000
X-Accept-Language: de,en,fr
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Jun 13, 2001 at 09:34:18PM +1000, Keith Owens wrote:

> On Wed, 13 Jun 2001 12:56:10 +0200, 
> Florian Lohoff <flo@rfc822.org> wrote:
> >> Using ksymoops gave a lot of warnings this time. Don't know why, the
> >> System.map should be the right one (it's out of
> >> kernel-image-2.4.3-ip22-r4k.tgz).
> >
> >This is because the system map has been generated with newer binutils
> >which always dump the addresses as 64Bit addresses.
> 
> Looks like I need to add a new option to ksymoops.  -T <bits>, truncate
> all addresses to this bit size.  Added to my list for the next ksymoops
> release.

That can be done automatically.  For 32-bit ELF files mips*-linux binutils
dump some of the addresses as 32-bit addresses, some as sign-extended (!)
64-bit addresses.  So ksymops should just sign extend any 32-bit addresses
to 64-bit and then work on full lenght addresses.

Is ksymoops able to handle 64-bit addresses when running on a 32-bit host?
That is a common case for many people when decoding their MIPS oopses.

  Ralf
