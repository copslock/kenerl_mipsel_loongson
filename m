Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Feb 2005 13:36:45 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:43051
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8224929AbVBJNg2>; Thu, 10 Feb 2005 13:36:28 +0000
Received: (qmail 14848 invoked by uid 210); 10 Feb 2005 23:36:17 +1000
Received: from 10.0.0.251 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.24st 
 (spamassassin: 2.64. perlscan: 1.24st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.115116 secs); 10 Feb 2005 13:36:17 -0000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 10 Feb 2005 23:36:17 +1000
Message-ID: <420B6359.7060502@longlandclan.hopto.org>
Date:	Thu, 10 Feb 2005 23:36:25 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Jim Gifford <maillist@jg555.com>
CC:	linux-mips@linux-mips.org
Subject: Re: Linux from Scratch
References: <420AE7B9.6070202@jg555.com>
In-Reply-To: <420AE7B9.6070202@jg555.com>
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEEA18C67FC9D311ECCC5B6F6"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEEA18C67FC9D311ECCC5B6F6
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jim Gifford wrote:
> I have updated my RaQ2 build for Linux from Scratch to most of the
> latest packages for the RaQ2. A question was raised by some other
> memebers of the Linux from Scratch group, that frankly I didn't have the
> answers for. I appreciate your feedback on these questions.
>
> 1 - Will the build method I have currently work with any MIPS processor
> based machine, with the exception of the bootloader?

The bulk of it would be largely the same -- however there would be a
difference in that endianness, ABIs and ISAs have to be considered.

e.g.
Cobalt Servers are Little Endian running RM523[01] CPUs (MIPS IV ISA).
All (MIPS-based) SGI machines are Big Endian, mainly with either MIPS
III or MIPS IV class CPUs.

Therefore you use mips-unknown-linux-gnu as the HOST on SGI boxes, and
mipsel-unknown-linux-gnu on Cobalts.  (Some even use
mips64-unknown-linux-gnu)

  > 2 - Is there a bootloader for MIPS that will work on every machine, or
> is different for every MIPS based machine's firmware? If so any examples
> out there how to implement?

Okay, a lot of MIPS machines implement the ARCs firmware, but still
there's a big variety of machines there -- so making one bootloader
support them all would be an outright nightmare.  Having said that,
there are several bootloaders that do get used across multiple machines.
  Some that come to mind:

- CoLo (the Cobalt Loader) for Cobalt servers
- ARCBoot for SGI machines
- U-Boot
- YAMON

and there are likely many more.  They've all got their own differences
-- just to give you an idea, have a look at my copy of the Gentoo/MIPS
handbook[2] -- specifically the bootloader section[3].  This version
covers setting up both Cobalt servers and SGI machines with Gentoo
Linux.  As you can see, there's a big difference between the machines.

Anyway, I hope that's answered some of your questions. :-)
--
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
Footnotes:
1. Note that the IP12 and it's R4k cousin, the IP20 are currently
unsupported in Linux at this time -- although people are working on that :-)
2. Got the clipboard applet ready?  This is a long one:
<http://www.longlandclan.hopto.org/~stuartl/gentoo/docs/index.php/gentoo-doc/en/handbook/handbook-mips.xml>
3. Configuring the Bootloader:
<http://www.longlandclan.hopto.org/~stuartl/gentoo/docs/index.php/gentoo-doc/en/handbook/handbook-mips.xml?part=1&chap=10>
... and yes, eventually this will be put on the main Gentoo site...
pending bug #81072: <http://bugs.gentoo.org/show_bug.cgi?id=81072>

--------------enigEEA18C67FC9D311ECCC5B6F6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCC2NduarJ1mMmSrkRAj8JAJ0cqh0gFfWn6T2xr4Gpi2ZnHCvoQgCgjhCL
hd85CHCQSY5LyIQfz+kXjj0=
=TCKh
-----END PGP SIGNATURE-----

--------------enigEEA18C67FC9D311ECCC5B6F6--
