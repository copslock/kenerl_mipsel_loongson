Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f5DCJVt20599
	for linux-mips-outgoing; Wed, 13 Jun 2001 05:19:31 -0700
Received: from ocs4.ocs-net (firewall.ocs.com.au [203.34.97.9])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f5DCJGP20558;
	Wed, 13 Jun 2001 05:19:17 -0700
Received: from ocs4.ocs-net (kaos@localhost)
	by ocs4.ocs-net (8.11.2/8.11.2) with ESMTP id f5DCJER08466;
	Wed, 13 Jun 2001 22:19:14 +1000
X-Authentication-Warning: ocs4.ocs-net: kaos owned process doing -bs
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@melbourne.sgi.com>
To: Ralf Baechle <ralf@oss.sgi.com>
cc: Florian Lohoff <flo@rfc822.org>, Raoul Borenius <borenius@shuttle.de>,
   linux-mips@oss.sgi.com
Subject: ksymoops changes for mips (was Kernel crash on boot with current cvs)
In-reply-to: Your message of "Wed, 13 Jun 2001 14:05:51 +0200."
             <20010613140550.B31221@bacchus.dhis.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 13 Jun 2001 22:19:14 +1000
Message-ID: <8465.992434754@ocs4.ocs-net>
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, 13 Jun 2001 14:05:51 +0200, 
Ralf Baechle <ralf@oss.sgi.com> wrote:
>On Wed, Jun 13, 2001 at 09:34:18PM +1000, Keith Owens wrote:
>> Looks like I need to add a new option to ksymoops.  -T <bits>, truncate
>> all addresses to this bit size.  Added to my list for the next ksymoops
>> release.
>
>That can be done automatically.  For 32-bit ELF files mips*-linux binutils
>dump some of the addresses as 32-bit addresses, some as sign-extended (!)
>64-bit addresses.  So ksymops should just sign extend any 32-bit addresses
>to 64-bit and then work on full lenght addresses.

Some utilities extend with leading 0, some with leading 1, some with
special values (alpha).  It is safer to truncate everything to the
specified width instead of guessing what the extension value is.

>Is ksymoops able to handle 64-bit addresses when running on a 32-bit host?
>That is a common case for many people when decoding their MIPS oopses.

Yes and no.  The framework is there to handle 32/64 splits, sparc
already uses it.  mips does not currently use the framework because the
oops report does not identify the machine type 32/64, MSB/LSB.  We
discussed this in January and I asked for a small change to mips64 oops
output (below), was that ever done?

------

From: Keith Owens <kaos@ocs.com.au>
To: Ralf Baechle <ralf@uni-koblenz.de>
Subject: Re: ksymoops on origin 
Date: Sat, 06 Jan 2001 18:21:35 +1100

ksymoops is designed to run on any build arch and debug an oops report
from any other target arch, as long as binutils supports the target
arch.  The presence or absence of __MIPSEL__ or __MIPSEB__ on the build
system says nothing about the type of the failing target, ksymoops
relies on text in the oops report to determine special cases like 32
bit userland and 64 bit kernel.

The best option is for a mips64 kernel to indicate that it is 64 bit
and its endianess.  Instead of printing

  "epc     : %016lx\n"

print

  "epc     : %016lx (64 "
#ifdef __MIPSEL__
		"LSB"
#else
		"MSB"
#endif
		")\n"

If you make that change to arch/mips64/mm/andes.c,
arch/mips64/mm/r4xx0.c and any other places that print epc on mips64
then I will change ksymoops to look for (64 [LM]SB) on the epc line and
decode accordingly.

While we are on the topic of 32 bit userland and 64 bit kernel, how
does mips64 handle modules?  modutils 2.4.0 has no support for mips64,
do you have any code?  Also I assume that you will want the same
ability as sparc, to compile modutils as a 32 bit program which can
handle both 32 and 64 bit modules.
