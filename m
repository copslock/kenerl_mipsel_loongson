Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Mar 2005 13:20:51 +0000 (GMT)
Received: from 202-47-55-78.adsl.gil.com.au ([IPv6:::ffff:202.47.55.78]:59694
	"EHLO longlandclan.hopto.org") by linux-mips.org with ESMTP
	id <S8225739AbVCRNUf>; Fri, 18 Mar 2005 13:20:35 +0000
Received: (qmail 17079 invoked by uid 210); 18 Mar 2005 23:20:25 +1000
Received: from 10.0.0.251 by www (envelope-from <stuartl@longlandclan.hopto.org>, uid 201) with qmail-scanner-1.25st 
 (spamassassin: 3.0.2. perlscan: 1.25st.  
 Clear:RC:1(10.0.0.251):. 
 Processed in 0.090609 secs); 18 Mar 2005 13:20:25 -0000
Received: from unknown (HELO ?10.0.0.251?) (10.0.0.251)
  by 192.168.5.1 with SMTP; 18 Mar 2005 23:20:25 +1000
Message-ID: <423AD5A2.3060200@longlandclan.hopto.org>
Date:	Fri, 18 Mar 2005 23:20:34 +1000
From:	Stuart Longland <stuartl@longlandclan.hopto.org>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Netbooting CoLo on the Cobalt RaQ1
X-Enigmail-Version: 0.89.6.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig07E3C5EA696A7F17AA2A72F7"
Return-Path: <stuartl@longlandclan.hopto.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7463
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: stuartl@longlandclan.hopto.org
Precedence: bulk
X-list: linux-mips

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig07E3C5EA696A7F17AA2A72F7
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

	Recently I updated the Gentoo/MIPS Handbook -- in amongst the complete
rewrite, was shiny new instructions for how to install Gentoo on a
Cobalt server.

	Now... in the instructions, it asks to download CoLo, extract the
colo-chain.elf file, and gzip it up as vmlinux_raq-2800.gz and to put
that in /nfsroot on the server.

	It appears the RaQ1 is a special case, and does not look there to
download its kernel.  Does anyone know exactly where these boxes look
for the kernel image when netbooting?  That way, I can ammend[1] the
handbook with the new details.

Regards,
--
+-------------------------------------------------------------+
| Stuart Longland -oOo- http://stuartl.longlandclan.hopto.org |
| Atomic Linux Project     -oOo-    http://atomicl.berlios.de |
| - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - |
| I haven't lost my mind - it's backed up on a tape somewhere |
+-------------------------------------------------------------+
Footnotes:
1. http://bugs.gentoo.org/show_bug.cgi?id=85762

--------------enig07E3C5EA696A7F17AA2A72F7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://enigmail.mozdev.org

iD8DBQFCOtWluarJ1mMmSrkRAqCkAJ9Ky0jv19J3MkrBe0a2TM77XOSAoACcC3mw
xVqd71DRR+9eNg9DvB6p1Fc=
=cY0C
-----END PGP SIGNATURE-----

--------------enig07E3C5EA696A7F17AA2A72F7--
