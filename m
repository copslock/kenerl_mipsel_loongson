Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jun 2004 07:19:36 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:16331 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8224986AbUFRGTb>; Fri, 18 Jun 2004 07:19:31 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 683F84B7C1; Fri, 18 Jun 2004 08:19:28 +0200 (CEST)
Date: Fri, 18 Jun 2004 08:19:28 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: "No such device" with PCI card
Message-ID: <20040618061927.GU20632@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <40CEBB36.1030707@kilimandjaro.dyndns.org> <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a6tHM5hUJNv0E1sG"
Content-Disposition: inline
In-Reply-To: <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com>
X-Operating-System: Linux mail 2.4.18 
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
User-Agent: Mutt/1.5.6i
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5331
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--a6tHM5hUJNv0E1sG
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2004-06-18 10:41:55 +0800, jospehchan <jospehchan@yahoo.com.tw>
wrote in message <20040618024155.35970.qmail@web16605.mail.tpe.yahoo.com>:
> Hi Jan-Benedict,
>  Thanks. Please refer to the follownig replies.=20

(By the way, think about changing you email client's configuration...)

> - What kind of MIPS system do you use *exactly*? What
> board? Which
>   kernel version? From where did you get your sources.
>=20
> >>>The MIPS system is R3000 and uses an ADI Media
> Adapter MB.
> The kernel is 2.4.16 from the vendor and plus an USB
> patch which backported from kernel 2.4.26.

First off, I didn't easily find information for that board...

Then, porting direction was wrong. You want to diff out vendor's changes
ontop vanilla 2.4.16 (probably they've started off the mvista or the
linux-mips.org kernel) and port *those* to current 2.4.x (of same
vendor, preferring linux-mips.org ...). If they only added drivers and
bootup-code for that board, just port that over to 2.6.x.

Sounds like the vendor did make linux waddle on that board and never
cared for it again :(

> - A USB2.0 card is IMHO driven by the ehci driver, but
> I may be wrong.
>   I'm not exactly a regular USB user...
>=20
> >>>Yes, you're right. But the USB2.0 card also can be
> driven by usb-uhci if ehci-hcd is not loaded.
> In the my problem, I can load the usbcore, but both of
> usb-uhci and ehci-hcd can not be loaded.=20

I'd guess usb-core has nothing else to do than to accept loaded host and
client drivers, so it should just load and do nothing. I guess they just
broke the whole PCI interface in some way or another (weren't there
general MIPS bugs at that time in 2.4.x? Even with endianess? It's so
long ago...)

> - Do you have output of "lspci", "lspci -v", "lspci
> -n", "lspci -vn" and
>   "lspci -nxxx" at your hand, once from your i386 test
> machine, once
>   from the MIPS board? Right, those commands mostly
> give the same
>   output, but each style eases reading for specific
> values:)
>=20
> >>> MIPS
> # lspci
> 00:00.0 Class 0c03: 1106:3038 (rev 61)

Only *one* PCI device? I'm shocked...

	1106:	VIA
	3038:	USB

> # lspci -v
> 00:00.0 Class 0c03: 1106:3038 (rev 61)
>         Subsystem: 1106:3038
>         Flags: bus master, medium devsel, latency 22, IRQ 4
>         I/O ports at <ignored>
>         Capabilities: [80] Power Management version 2

Seems the device didn't get any I/O assigned. Of course, that won't
fly. Depending on what's expected, either Linux' PCI core should assign
I/O for devices, or the board's firmware.

> # lspci -n

> >>> i386 (RH7.2, kernel 2.4.16 plus USB patch from kernel 2.4.26)

Dito, quite outdated:)

> #lspci=20
> 00:14.0 USB Controller: VIA Technologies, Inc. UHCI USB (rev 61)
> 00:14.1 USB Controller: VIA Technologies, Inc. UHCI USB (rev 61)
> 00:14.2 USB Controller: VIA Technologies, Inc.: Unknown device 3104 (rev =
62)

So on the MIPS board, there's only *one* single device, but on your
i386 machine, this board registers as three separate subdevices? Sounds
there's something seriously broken in the MIPS PCI code as of 2.4.16...

But *that* doesn't make me wonder:)


> #lspci -v
> 00:14.0 USB Controller: VIA Technologies, Inc. UHCI
> USB (rev 61) (prog-if 00 [UHCI])
> 	Subsystem: VIA Technologies, Inc. UHCI USB
> 	Flags: bus master, medium devsel, latency 32, IRQ 11
> 	I/O ports at e400 [size=3D32]
> 	Capabilities: [80] Power Management version 2
>=20
> 00:14.1 USB Controller: VIA Technologies, Inc. UHCI
> USB (rev 61) (prog-if 00 [UHCI])
> 	Subsystem: VIA Technologies, Inc. UHCI USB
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	I/O ports at e800 [size=3D32]
> 	Capabilities: [80] Power Management version 2
>=20
> 00:14.2 USB Controller: VIA Technologies, Inc.:
> Unknown device 3104 (rev 62) (prog-if 20)
> 	Subsystem: VIA Technologies, Inc.: Unknown device 3104
> 	Flags: bus master, medium devsel, latency 32, IRQ 5
> 	Memory at ee003000 (32-bit, non-prefetchable) [size=3D256]
> 	Capabilities: [80] Power Management version 2

Also, if you're asked for output, please don't cut it down to what you
think is useful or related. For sure, your i386 PC as well as your MIPS
box *does* indeed have more PCI devices than only the USB card.

> #lspci -vn
> 00:14.0 Class 0c03: 1106:3038 (rev 61)
> 	Subsystem: 1106:3038
> 	Flags: bus master, medium devsel, latency 32, IRQ 11
> 	I/O ports at e400 [size=3D32]
> 	Capabilities: [80] Power Management version 2

See? On your PeeCee, it got I/O resources assigned.

>=20
> - Does your MOPS board have working on-board PCI
> devices? These don't
>   neccessarily have a PCI plug as you know them from
> add-on cards,
>   because they're directly built into the chipset. For
> instance, does
>   your board have onboard IDE interfaces?
>  =20
>   >>>No, the PCI device can not work, such as (Realtek
> 8139 LAN card, Philips and VIA USB 2.0 card)
>   But there is a mini-PCI device seems workable,
> because it's driver can be loaded.

Does it have any PCI attached devices (modulo the USB card)?

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
   ret =3D do_actions((curr | FREE_SPEECH) & ~(NEW_COPYRIGHT_LAW | DRM | TC=
PA));

--a6tHM5hUJNv0E1sG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA0olvHb1edYOZ4bsRAv7GAJ9Swqo77Xs1+l2dINR4og1R1uBSnwCcDtB5
gKi3+JlzaUxllUUDlc812JI=
=yGN1
-----END PGP SIGNATURE-----

--a6tHM5hUJNv0E1sG--
