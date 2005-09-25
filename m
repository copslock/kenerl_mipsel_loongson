Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Sep 2005 15:10:52 +0100 (BST)
Received: from NAT.office.mind.be ([62.166.230.82]:21960 "EHLO
	NAT.office.mind.be") by ftp.linux-mips.org with ESMTP
	id S8133466AbVIYOKe (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 25 Sep 2005 15:10:34 +0100
Received: (qmail 28198 invoked from network); 25 Sep 2005 14:10:32 -0000
Received: from localhost (HELO codecarver) ([127.0.0.1])
          (envelope-sender <p2@debian.org>)
          by localhost (qmail-ldap-1.03) with SMTP
          for <linux-mips@linux-mips.org>; 25 Sep 2005 14:10:32 -0000
Received: from p2 by codecarver with local (Exim 3.36 #1 (Debian))
	id 1EJWp0-0006oz-00
	for <linux-mips@linux-mips.org>; Sun, 25 Sep 2005 15:45:38 +0200
Date:	Sun, 25 Sep 2005 15:45:38 +0200
To:	linux-mips@linux-mips.org
Subject: Re: Bus error on sb1250
Message-ID: <20050925134538.GA25829@codecarver>
Mail-Followup-To: peter.de.schrijver@mind.be, linux-mips@linux-mips.org
References: <20050924215710.GA6310@codecarver>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CblX+4bnyfN0pR09"
Content-Disposition: inline
In-Reply-To: <20050924215710.GA6310@codecarver>
X-Answer: 42
X-Operating-system: Debian GNU/Linux
X-Message-Flag:	Get yourself a real email client. http://www.mutt.org/
X-mate:	Mate, man gewoehnt sich an alles
User-Agent: Mutt/1.5.6+20040907i
From:	Peter 'p2' De Schrijver <p2@debian.org>
Return-Path: <p2@debian.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9035
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips


--CblX+4bnyfN0pR09
Content-Type: multipart/mixed; boundary="K8nIJk4ghYZn606h"
Content-Disposition: inline


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 24, 2005 at 11:57:10PM +0200, Peter 'p2' De Schrijver wrote:
> Hi,
>=20
> I'm seeing some strange bus errors when trying to get the Fore
> ForeRunner PCA-200EPC card to work on the sibyte swarm. The driver polls
> a register on this card for status information. This triggers a bus
> error once in a while. This happens regardless if the card is attached
> to the PCI bus of the sb1250 or to the PCI bus behind the Alliance HT -
> PCI bridge.=20
>=20

Thanks to Maciej, I found the problem. The device apparently does not
always react in time for the sb1250 PCI host. Changing TrdyTimeout to
0xff fixes the problem for the 32bit PCI slots. I need to find the
equivalent register on the SP1011 bridge to fix the problem for the
64bit PCI slots. Patch attached.

Cheers,

Peter (p2).

--
goa is a state of mind

--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-pci
Content-Transfer-Encoding: quoted-printable

--- linux/include/linux/pci_ids.h	2005-09-15 10:56:21.000000000 +0200
+++ linux-my/include/linux/pci_ids.h	2005-09-25 15:10:53.000000000 +0200
@@ -2192,6 +2192,7 @@
 #define PCI_DEVICE_ID_FARSITE_TE1C      0x1612
=20
 #define PCI_VENDOR_ID_SIBYTE		0x166d
+#define PCI_DEVICE_ID_BCM1250_PCI	0x0001
 #define PCI_DEVICE_ID_BCM1250_HT	0x0002
=20
 #define PCI_VENDOR_ID_NETCELL		0x169c
--- linux/arch/mips/pci/fixup-sb1250.c	2004-12-18 23:28:20.000000000 +0100
+++ linux-my/arch/mips/pci/fixup-sb1250.c	2005-09-25 15:25:02.000000000 +02=
00
@@ -20,5 +20,22 @@
 {
 	dev->class =3D PCI_CLASS_BRIDGE_PCI << 8;
 }
+
+/*
+ * Set PCI Trdy timeout to 0xff clock cycles
+ */
+static void __init quirk_sb1250_pci(struct pci_dev *dev)
+{
+	u32 pci_timeout;
+
+	pci_read_config_dword(dev, 0x40, &pci_timeout);
+	pci_timeout|=3D0xff;
+	pci_write_config_dword(dev,0x40,pci_timeout);
+}
+
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_HT,
 			quirk_sb1250_ht);
+
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_SIBYTE, PCI_DEVICE_ID_BCM1250_PCI,
+			quirk_sb1250_pci);
+

--K8nIJk4ghYZn606h--

--CblX+4bnyfN0pR09
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFDNqoBKLKVw/RurbsRAhUnAKCEqDbZG71FcEKFAmcKIbzGqF7lAACbB+3+
RvIBYfIm+mTtzWsOI0yHF0Q=
=tIJ3
-----END PGP SIGNATURE-----

--CblX+4bnyfN0pR09--
