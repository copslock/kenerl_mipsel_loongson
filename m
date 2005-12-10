Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2005 11:52:34 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:62692 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133714AbVLJLwP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 10 Dec 2005 11:52:15 +0000
Received: (qmail 1026 invoked from network); 10 Dec 2005 21:51:22 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 10 Dec 2005 21:51:22 +1000
Message-ID: <439AC10C.7060308@gentoo.org>
Date:	Sat, 10 Dec 2005 21:50:36 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051029)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	pf@net.alphadv.de
CC:	linux-mips@linux-mips.org
Subject: Re: SGI IP28 Kernels... anyone had any luck lately?
References: <Pine.LNX.4.21.0512091803080.1379-100000@Opal.Peter>
In-Reply-To: <Pine.LNX.4.21.0512091803080.1379-100000@Opal.Peter>
X-Enigmail-Version: 0.93.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig398EF8F0A927FFF921AD8C44"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9653
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig398EF8F0A927FFF921AD8C44
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

peter fuerst wrote:
> sorry, obviously forgot to "tar" with the "-h" option.  The kernel patch-set
> is now repackaged with README and .config (same location).  I wonder, why no
> one noticed their missing since Oct 17...

Heh, I wondered that myself... Anyways, it's fixed now. :-)

> For exactness' sake: the patches are based on linux-2.6.14-rc2-mipscvs-20050925
> Maybe .config will enable compiling, the error-messages seem to point
> to a misconfiguration, since the compiler didn't touch any of the patched
> files yet.

I did try using the linux-2.6.14-rc2 tag out of git (repository as of
20051204; I didn't bother going to bleeding edge), but found I got the
same errors.

The problems disappeared, however, when I tried 2.6.14-rc1... this seems
to work just fine.

> indigo ~ # uname -a
> Linux indigo 2.6.14-rc1-ip28 #4 Sat Dec 10 18:26:46 EST 2005 mips64 R10000 V2.5  FPU V0.0 SGI Indigo2 GNU/Linux
> indigo ~ # uptime
>  21:49:13 up  3:21,  3 users,  load average: 2.63, 1.38, 0.71

The only glitch I've hit so far, is that booting via the local
framebuffer (okay, I know it isn't a true "framebuffer") causes a fatal
oops.  However, if I specify console=ttyS0,9600, I see a flashing cursor
on the framebuffer, and the bootup proceeds to completion on the serial
console.  Which is good news... it wasn't long ago when I recall merely
sneezing in front of the machine was enough to send it spiralling into a
fatal oops.

> There's still a problem with the Xserver: often, when starting up the Xserver
> first after a cold boot, it likes to hang (in a loop, waiting for "dmabusy"
> to settle down, either in the kernel-driver or the Xserver itself, when
> re-mmapping the dma-buffer). Usually, after a reset the Xserver works okay.
> I couldn't find a solution for this yet, but otherwise (;-) i easily (can) use
> the machine for regular work (no more hangs after the Xserver started up once).

As I say... this Linux port has really bounded ahead in the time I've
had this IP28 of mine... considering the hardware issues that have to be
worked around. :-)

X is my next step... for the moment though, I'm happy to be able to use
a real monitor, and not a serial console. :-)
-- 
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
. . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

--------------enig398EF8F0A927FFF921AD8C44
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFDmsEPuarJ1mMmSrkRArWRAJ4kSLth9j/A/RV4iCWgcGvFm+n1WwCeNqsE
yEd9vGwN4uv68gD1zLXc/rQ=
=L5aZ
-----END PGP SIGNATURE-----

--------------enig398EF8F0A927FFF921AD8C44--
