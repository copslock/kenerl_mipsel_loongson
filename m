Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2004 13:18:01 +0000 (GMT)
Received: from the-doors.enix.org ([IPv6:::ffff:62.210.169.120]:11406 "EHLO
	the-doors.enix.org") by linux-mips.org with ESMTP
	id <S8225250AbUKDNR4>; Thu, 4 Nov 2004 13:17:56 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by the-doors.enix.org (Postfix) with ESMTP
	id 70C591EF67; Thu,  4 Nov 2004 14:17:49 +0100 (CET)
Message-ID: <418A2C6F.7010508@enix.org>
Date: Thu, 04 Nov 2004 14:19:43 +0100
From: Thomas Petazzoni <thomas.petazzoni@enix.org>
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: fr, en
MIME-Version: 1.0
To: Hannes Bischof <vergiss-es@gmx.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Compile Mips-Architecture on an i386?
References: <20244.1099567205@www38.gmx.net>
In-Reply-To: <20244.1099567205@www38.gmx.net>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9ABF694F6385F3598593A7E2"
Content-Transfer-Encoding: 8bit
Return-Path: <thomas.petazzoni@enix.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: thomas.petazzoni@enix.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9ABF694F6385F3598593A7E2
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Hello,

Hannes Bischof a écrit :

> What do I need to compile the software so that it runs under the linux
> system of the router??

You need a cross-compilation toolchain (that is a gcc, binutils and libc 
that runs on your i386, but that generates binaries for MIPS).

Different tools are available to do that :

  * Toolchain  : http://www.uclibc.org/toolchains.html
  * Crosstool  : http://kegel.com/crosstool/
  * Debian way : http://skaya.enix.org/wiki/ToolChain

Thomas
-- 
PETAZZONI Thomas - thomas.petazzoni@enix.org
http://thomas.enix.org - Jabber: kos_tom@sourcecode.de
KOS: http://kos.enix.org/ - Lolut: http://lolut.utbm.info
Fingerprint : 0BE1 4CF3 CEA4 AC9D CC6E  1624 F653 CB30 98D3 F7A7

--------------enig9ABF694F6385F3598593A7E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (MingW32)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFBiixx9lPLMJjT96cRAiwSAJ9DGh5xcbLzU1k57kHllJusPMrgxgCfVbJy
jfAHZuNcgr2KBEUrBZpgPMg=
=OTAU
-----END PGP SIGNATURE-----

--------------enig9ABF694F6385F3598593A7E2--
