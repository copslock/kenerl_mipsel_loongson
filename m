Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Jun 2004 15:27:39 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:41138 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225534AbUFNO1e>; Mon, 14 Jun 2004 15:27:34 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 2AECA4B7CF; Mon, 14 Jun 2004 16:27:30 +0200 (CEST)
Date: Mon, 14 Jun 2004 16:27:30 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: "No such device" with PCI card
Message-ID: <20040614142730.GQ20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <20040614115631.17040.qmail@web16612.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="znSQlxigGrTagauB"
Content-Disposition: inline
In-Reply-To: <20040614115631.17040.qmail@web16612.mail.tpe.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5305
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--znSQlxigGrTagauB
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-06-14 19:56:31 +0800, jospehchan <jospehchan@yahoo.com.tw>
wrote in message <20040614115631.17040.qmail@web16612.mail.tpe.yahoo.com>:
> Hi all,
>   I'm new in MIPS.=20
>   Recently, I encountered a strange problem.=20
>   That is when I plugged in a USB1.1 PCI card on my
> MIPS machine.
>   When I load "usb-uhci" modules, the system returns
> "Init_modules: No such device".
>   But checking "lspci", I can see the device's ID of
> the USB PCI card.
>   Is there anything I missed? Any suggestion or advice
> is appreciated.=20

lspci tells you vendor and device id. These IDs need to be told to the
driver. Because the uhci driver uses:

static const struct pci_device_id uhci_pci_ids[] =3D { {
        /* handle any USB UHCI controller */
        PCI_DEVICE_CLASS(((PCI_CLASS_SERIAL_USB << 8) | 0x00), ~0),
        .driver_data =3D  (unsigned long) &uhci_driver,
        }, { /* end: all zeroes */ }
};

I think your device is just broken (and doesn't tell it's a USB host).
If you think it's really driven by uhci (and not by ohci), then stick
your device IDs into that table, or add those dynamically by echo'ing
them to /sys/bus/pci/drivers/uhci_hcd/new_id. You need sysfs mounted to
/sys, though.

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--znSQlxigGrTagauB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAzbXSHb1edYOZ4bsRAn9hAJ9oUiYsGsqAb2uUAqC/U7b+eQvpwwCfS2Z7
py25SbLG8WHzkBaoArjF7FU=
=KuIN
-----END PGP SIGNATURE-----

--znSQlxigGrTagauB--
