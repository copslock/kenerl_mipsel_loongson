Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Sep 2007 18:39:16 +0100 (BST)
Received: from smtp1.int-evry.fr ([157.159.10.44]:51892 "EHLO
	smtp1.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20023359AbXIYRjN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 25 Sep 2007 18:39:13 +0100
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp1.int-evry.fr (Postfix) with ESMTP id 5CE458E63E7;
	Tue, 25 Sep 2007 19:37:48 +0200 (CEST)
Received: from [157.159.47.53] (unknown [157.159.47.53])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 3C6E8D0E315;
	Tue, 25 Sep 2007 19:37:48 +0200 (CEST)
From:	Florian Fainelli <florian.fainelli@telecomint.eu>
To:	linux-mips@linux-mips.org
Subject: [PATCH 2/3 take2] Au1000 : fix PCI controller registration
Date:	Tue, 25 Sep 2007 19:38:47 +0200
User-Agent: KMail/1.9.7
Cc:	blogic@openwrt.org, nbd@openwrt.org
References: <200709251707.29067.florian.fainelli@telecomint.eu>
In-Reply-To: <200709251707.29067.florian.fainelli@telecomint.eu>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart7310294.9iJhWgP9ri";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200709251938.48939.florian.fainelli@telecomint.eu>
X-int-MailScanner-Information: Please contact the ISP for more information
X-int-MailScanner: Found to be clean
X-int-MailScanner-SpamCheck: 
X-int-MailScanner-From:	florian.fainelli@telecomint.eu
Return-Path: <florian.fainelli@telecomint.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16671
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian.fainelli@telecomint.eu
Precedence: bulk
X-list: linux-mips

--nextPart7310294.9iJhWgP9ri
Content-Type: multipart/mixed;
  boundary="Boundary-01=_oeU+G0eLEftHjwW"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

--Boundary-01=_oeU+G0eLEftHjwW
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

The PCI controller fails to register, as PCI_MEM_END was greater than =A0
IOMEM_RESOURCE_END and Au1500_PCI_IO_END was greater than =A0
IOPORT_RESOURCE_END

IO{MEM,PORT}_RESOURCE_END value were adjust to represent the actual =A0
memory map of the au1x00.

The previous patch introduced a 64GB PCI adressing space, which is wrong.

Signed-off-by: Felix Fietkau <nbd@openwrt.org>
Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Florian Fainelli <florian.fainelli@telecomint.eu>
=2D-=20

--Boundary-01=_oeU+G0eLEftHjwW
Content-Type: text/plain;
  charset="iso-8859-1";
  name="io-resources.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="io-resources.patch"

diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-=
au1x00/au1000.h
index 58fca8a..d5dbe64 100644
=2D-- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
@@ -1680,9 +1680,9 @@ extern au1xxx_irq_map_t au1xxx_irq_map[];
 #define PCI_LAST_DEVFN  (19<<3)
=20
 #define IOPORT_RESOURCE_START 0x00001000 /* skip legacy probing */
=2D#define IOPORT_RESOURCE_END   0xffffffff
+#define IOPORT_RESOURCE_END   0xffffffffULL
 #define IOMEM_RESOURCE_START  0x10000000
=2D#define IOMEM_RESOURCE_END    0xffffffff
+#define IOMEM_RESOURCE_END    0xffffffffULL
=20
   /*
    * Borrowed from the PPC arch:

--Boundary-01=_oeU+G0eLEftHjwW--

--nextPart7310294.9iJhWgP9ri
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.7 (GNU/Linux)

iD8DBQBG+Ueomx9n1G/316sRAmJfAJ9PZCbBxIgomtC2XV/b3eMiOK5W8QCfZKzg
tVpa04oM4Z/hLlJbEnmZq20=
=YwMV
-----END PGP SIGNATURE-----

--nextPart7310294.9iJhWgP9ri--
