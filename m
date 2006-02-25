Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Feb 2006 00:56:46 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:44444 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133777AbWBYA4h (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 25 Feb 2006 00:56:37 +0000
Received: (qmail 30467 invoked from network); 25 Feb 2006 11:03:51 +1000
Received: from beast.redhatters.home (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 25 Feb 2006 11:03:51 +1000
Message-ID: <43FFADF7.6040305@gentoo.org>
Date:	Sat, 25 Feb 2006 11:08:07 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	J S <js_proj@yahoo.com>
CC:	linux-mips@linux-mips.org
Subject: Re: adding HD video to a MIPS board
References: <20060224222531.70940.qmail@web37612.mail.mud.yahoo.com>
In-Reply-To: <20060224222531.70940.qmail@web37612.mail.mud.yahoo.com>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig069F408AE1EDFDFB669EF4FC"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10645
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig069F408AE1EDFDFB669EF4FC
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

J S wrote:
> I was wondering if anyone has ever attempted some
> version of the "MythTV" project (DIY Linux-based
> version of TIVO) with a basic MIPS board such as a
> MALTA (but something quicker would probably be needed)
> and an off-the-shelf PCI encoder/decoder card? What
> hardware did you use? 
> 
> Did you use this Linux distribution or another?  
> 
> Thanks for any help you can provide,

I'm tempted to try this with my SGI O2 and a Brooktree BT848 capture
card ... but to gain full benefit, it'd need to wait for the sound card
driver to get fixed, and for some VICE firmware to be written.

The thought I had, was to use VICE to do hardware Vorbis and perhaps
Theora compression (if there's sufficient grunt), and turn my O2 into a
small video capture box.  MythTV was an option there ... but as I say,
180MHz is a bit slow to do this without hardware acceleration, plus the
lack of a working sound card practically rules it out.

You could probably do it with a hardware-encoding MPEG TV card, and make
a decent MythTV backend.  Or if you look around, there are actual MIPS
boards with exactly this sort of functionality built in. :-)
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

International Asperger's Year (1906 ~ 2006)
http://dev.gentoo.org/~redhatter/iay

--------------enig069F408AE1EDFDFB669EF4FC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFD/636uarJ1mMmSrkRAhaGAJ9xYKj92ip5N2OOyUfRVJbAK6bENgCfQMLd
Ehqgni1KPZ2bSh3wTjbQIeI=
=XTlV
-----END PGP SIGNATURE-----

--------------enig069F408AE1EDFDFB669EF4FC--
