Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jul 2006 09:38:16 +0100 (BST)
Received: from smtp2.int-evry.fr ([157.159.10.45]:8623 "EHLO smtp2.int-evry.fr")
	by ftp.linux-mips.org with ESMTP id S8133529AbWGZIiF (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 26 Jul 2006 09:38:05 +0100
Received: from connect.int-evry.fr (connect.int-evry.fr [157.159.10.48])
	by smtp2.int-evry.fr (Postfix) with ESMTP id C84282FE6D
	for <linux-mips@linux-mips.org>; Wed, 26 Jul 2006 10:37:56 +0200 (CEST)
From:	Florian FAINELLI <florian.fainelli@int-evry.fr>
To:	linux-mips@linux-mips.org
Subject: YAMON and decompression from flash
Date:	Wed, 26 Jul 2006 10:37:53 +0200
User-Agent: KMail/1.9.1
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1797976.nX7Jklc9tA";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200607261037.55996.florian.fainelli@int-evry.fr>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-MCPCheck: 
X-INT-MailScanner-SpamCheck: 
X-MailScanner-From: florian.fainelli@int-evry.fr
Return-Path: <florian.fainelli@int-evry.fr>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12079
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@int-evry.fr
Precedence: bulk
X-list: linux-mips

--nextPart1797976.nX7Jklc9tA
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi all,

I want to use the generic LZMA decompressor we use in OpenWrt with an MTX-1=
=20
board. Currently, decompressing from RAM works fine. My problems are coming=
=20
from decompression from flash.

Basically, I used the same parameters for flash decompression as for RAM=20
decompression (kernel entry point, ram start address, ram size), except tha=
t=20
I ran an "--adjust-vma" with the same parameters as the zlib decompressor h=
as=20
in the Makefile (patch can be found here :=20
https://dev.openwrt.org/browser/branches/buildroot-ng/openwrt/target/linux/=
au1000-2.6/patches/003-zImage.patch).

I think I am missing some ideas/concepts, and don't know why it works for=20
zlib, and not for lzma (apart from the fact that the two decompressor may n=
ot=20
work the same way).

Thank you very much in advance for any suggestion. If it is relevant I will=
=20
post the exception handling YAMON generates while decompressing from flash.
=2D--
Cordialement, Florian Fainelli
=2D--------------------------------------------
5, rue Charles Fourier
Chambre 1511
91011 Evry
http://www.alphacore.net
(+33) 01 60 76 64 86
(+33) 06 09 02 64 95
=2D--------------------------------------------
Association MiNET
http://www.minet.net
=2D--------------------------------------------
Institut National des T=E9l=E9communications
http://www.int-evry.fr/telecomint
=2D--------------------------------------------

--nextPart1797976.nX7Jklc9tA
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBExynjQ/Yr6D8A81kRAtJ9AJ9IZCAwh2nd30iRtfnzVj22umdYYwCfYDRz
VS/zSdRFuLMnKB8TTdHiPMc=
=8+4n
-----END PGP SIGNATURE-----

--nextPart1797976.nX7Jklc9tA--
