Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2004 20:11:59 +0000 (GMT)
Received: from grey.subnet.at ([IPv6:::ffff:193.170.141.20]:33289 "EHLO
	grey.subnet.at") by linux-mips.org with ESMTP id <S8225202AbUKYULy>;
	Thu, 25 Nov 2004 20:11:54 +0000
Received: from ip6-localhost ([193.170.141.4]) by grey.subnet.at ; Thu, 25 Nov 2004 21:11:48 +0100
From: Bruno Randolf <bruno.randolf@4g-systems.biz>
To: linux-mips@linux-mips.org
Subject: au1500 cache coherency PCI and USB
Date: Thu, 25 Nov 2004 21:04:17 +0100
User-Agent: KMail/1.7.1
Organization: 4G Systems
Cc: Pete Popov <ppopov@embeddedalley.com>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1307190.UQNUJM4k3B";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <200411252104.22591.bruno.randolf@4g-systems.biz>
Return-Path: <bruno.randolf@4g-systems.biz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6467
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bruno.randolf@4g-systems.biz
Precedence: bulk
X-list: linux-mips

--nextPart1307190.UQNUJM4k3B
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hello!

i have previously reported on the problems we have using CONFIG_NONCOHERENT=
_IO=20
on Au1500 AD stepping systems (mtx-1):
* USB host only works reliably if we set CONFIG_NONCOHERENT_IO=3Dy.
* the prims54 wlan driver on PCI only works when we have
  CONFIG_NONCOHERENT_IO=3Dn.
so up to now prism54 and USB were mutually exclusive.=20

i have now found a way to use both USB host and a prism54 card at the same=
=20
time with the modifications in the patch at the end of this mail. it sets t=
he=20
"NC" bit for PCI only on pre-AC silicon stepping CPUs, as it was already=20
mentioned in the comment. but, actually i have to commit, that i'm not=20
totally sure of what i am doing and if this would be the right way to do it=
=2E=20
but it seems to work well...

greetings,
bruno

=2D-- linux/arch/mips/au1000/common/pci_fixup.c.orig      2004-11-25=20
20:14:24.907902616 +0100
+++ linux/arch/mips/au1000/common/pci_fixup.c   2004-11-25 20:27:08.8427668=
64=20
+0100
@@ -75,10 +75,13 @@

 #ifdef CONFIG_NONCOHERENT_IO
        /*
=2D        *  Set the NC bit in controller for pre-AC silicon
+        *  Set the NC bit in controller for Au1500 pre-AC silicon
         */
=2D       au_writel( 1<<16 | au_readl(Au1500_PCI_CFG), Au1500_PCI_CFG);
=2D       printk("Non-coherent PCI accesses enabled\n");
+       u32 prid =3D read_c0_prid();
+       if ( (prid & 0xFF000000) =3D=3D 0x01000000 && prid < 0x01030202) {
+               au_writel( 1<<16 | au_readl(Au1500_PCI_CFG), Au1500_PCI_CFG=
);
+               printk("Non-coherent PCI accesses enabled\n");
+       }
 #endif

        set_io_port_base(virt_io_addr);

--nextPart1307190.UQNUJM4k3B
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBpjrGfg2jtUL97G4RAlgSAJ48OwflhMG5UC5NbMmByxzhErEs+ACfQQrO
cRqt1ohqYCFrWVuA7mp95R8=
=Jjbx
-----END PGP SIGNATURE-----

--nextPart1307190.UQNUJM4k3B--
