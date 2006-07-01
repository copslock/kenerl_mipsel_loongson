Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 01 Jul 2006 14:45:58 +0100 (BST)
Received: from 202-47-55-78.adsl.gil.com.au ([202.47.55.78]:38569 "EHLO
	longlandclan.hopto.org") by ftp.linux-mips.org with ESMTP
	id S8133402AbWGANps (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 1 Jul 2006 14:45:48 +0100
Received: (qmail 28996 invoked from network); 1 Jul 2006 23:45:38 +1000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 1 Jul 2006 23:45:38 +1000
Message-ID: <44A67C84.5050702@gentoo.org>
Date:	Sat, 01 Jul 2006 23:45:40 +1000
From:	Stuart Longland <redhatter@gentoo.org>
Organization: Gentoo Foundation
User-Agent: Thunderbird 1.5.0.4 (X11/20060623)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: The puzzle that is IP32 audio
X-Enigmail-Version: 0.94.0.0
OpenPGP: id=63264AB9;
	url=http://dev.gentoo.org/~redhatter/gpgkey.asc
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF6C534AD88672EA71FEAE45A"
Return-Path: <redhatter@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11896
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: redhatter@gentoo.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF6C534AD88672EA71FEAE45A
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi All...

	I've just been tinkering with my O2's audio... and whilst looking
around at OpenBSD... it seems I might have some pieces to the puzzle
which may explain the rather poor audio quality one gets under Linux.

	The sound board is based around an Analogue Devices AD1843 codec
(datasheet here[1]), which is a 16-bit device.  The interesting note,
was in the OpenBSD source code for their mavb[2] driver... The mabv.c
file[3] contains this comment:

> /*
>  * For some reason SGI has decided to standardize their sound hardware
>  * interfaces on 24-bit PCM even though the AD1843 codec used in the
>  * Moosehead A/V Board only supports 16-bit and 8-bit formats.
>  * Therefore we must convert everything to 24-bit samples only to have
>  * the MACE hardware convert them back into 16-bit samples again.  To
>  * complicate matters further, the 24-bit samples are embedded 32-bit
>  * integers.  The 8-bit and 16-bit samples are first converted into
>  * 24-bit samples by padding them to the right with zeroes.  Then they
>  * are sign-extended into 32-bit integers.  This conversion is
>  * conveniently done through the software encoding layer of the high
>  * level audio driver by using the functions below.  Conversion of
>  * mu-law and A-law formats is done by the hardware.
>  */

	I'm wondering... I don't see any logic that does this in the ALSA
code... Could this be the reason we get such craptastic audio from this
device?

	I'll have a tinker, and see if I can use my limited coding skills to
fix up the current IP32 driver to the point the sound at least works...
without sounding terrible. :-)

Regards,
--=20
Stuart Longland (aka Redhatter)              .'''.
Gentoo Linux/MIPS Cobalt and Docs Developer  '.'` :
=2E . . . . . . . . . . . . . . . . . . . . .   .'.'
http://dev.gentoo.org/~redhatter             :.'

International Asperger's Year (1906 ~ 2006)
http://dev.gentoo.org/~redhatter/iay

Footnotes:
1. http://www.analog.com/UploadedFiles/Data_Sheets/314303384ad1843.pdf
2. http://www.openbsd.org/cgi-bin/man.cgi?query=3Dmavb&sektion=3D4&arch=3D=
sgi
3.
http://www.openbsd.org/cgi-bin/cvsweb/~checkout~/src/sys/arch/sgi/dev/mav=
b.c?rev=3D1.6&content-type=3Dtext/plain


--------------enigF6C534AD88672EA71FEAE45A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iD8DBQFEpnyIuarJ1mMmSrkRAuycAJ4vHvrYBPHcPS9f3MRjmsfBrJsU4QCgi07C
EDyQ6YMEHKL4vi2Gp+7SRR0=
=OH1R
-----END PGP SIGNATURE-----

--------------enigF6C534AD88672EA71FEAE45A--
