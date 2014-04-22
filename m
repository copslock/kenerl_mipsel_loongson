Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2014 12:07:28 +0200 (CEST)
Received: from [217.156.133.130] ([217.156.133.130]:16863 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-FAIL-FAIL-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S6815989AbaDVKHUT-vCY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Apr 2014 12:07:20 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 14A6341F8D8D;
        Tue, 22 Apr 2014 11:07:14 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 22 Apr 2014 11:07:14 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 22 Apr 2014 11:07:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 9BF53F54468F2;
        Tue, 22 Apr 2014 11:07:11 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 22 Apr 2014 11:07:13 +0100
Received: from localhost (192.168.154.79) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 22 Apr
 2014 11:07:13 +0100
Date:   Tue, 22 Apr 2014 11:07:13 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Malta: support powering down
Message-ID: <20140422100713.GC42386@pburton-linux.le.imgtec.org>
References: <1395415232-42288-1-git-send-email-paul.burton@imgtec.com>
 <1395415232-42288-2-git-send-email-paul.burton@imgtec.com>
 <alpine.LFD.2.11.1404191624180.11598@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="E/DnYTRukya0zdZ1"
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1404191624180.11598@eddie.linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.154.79]
X-ESG-ENCRYPT-TAG: 86d0bfe3
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39885
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

--E/DnYTRukya0zdZ1
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 19, 2014 at 04:39:10PM +0100, Maciej W. Rozycki wrote:
> On Fri, 21 Mar 2014, Paul Burton wrote:
>=20
> > This patch makes the mips_machine_halt function (used as _machine_halt &
> > pm_power_off) actually power down the Malta via the PIIX4. It may then
> > be powered back up by pressing the "ON/NMI" button (S4) on the board.
> >=20
> > Tested-by: James Hogan <james.hogan@imgtec.com>
> > Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> > ---
> [...]
> > diff --git a/arch/mips/mti-malta/malta-reset.c b/arch/mips/mti-malta/ma=
lta-reset.c
> > index d627d4b..ef04c8b 100644
> > --- a/arch/mips/mti-malta/malta-reset.c
> > +++ b/arch/mips/mti-malta/malta-reset.c
> > @@ -24,10 +27,72 @@ static void mips_machine_restart(char *command)
> > =20
> >  static void mips_machine_halt(void)
> >  {
>=20
>  First of all, shouldn't all of this stuff be wired into=20
> mips_machine_power_off rather than mips_machine_halt?  I would have=20
> thought mips_machine_halt is supposed to get back to the console monitor=
=20
> prompt (YAMON in this case) without restarting or powering off the system=
,=20
> and if that's impossible, then loop indefinitely (that's the -H vs -P=20
> action option to shutdown(8); see the details in the manual).
>=20

Perhaps. Currently there is no mips_machine_power_off - both
_machine_halt & pm_power_off point at mips_machine_halt and its existing
behaviour is to reset the system. That is, regardless of whether you
intend to halt, power off or reset you always get a reset. Returning to
the monitor/bootloader prompt (which may or may not be YAMON) is not
generally possible since the memory it was using has probably been
overwritten. It may make sense to separate halt & power off though, with
halt simply executing an infinite loop as you suggest.

> > -	unsigned int __iomem *softres_reg =3D
> > -		ioremap(SOFTRES_REG, sizeof(unsigned int));
> > +	struct pci_bus *bus;
> > +	struct pci_dev *dev;
> > +	int spec_devid, res;
> > +	int io_region =3D PCI_BRIDGE_RESOURCES;
> > +	resource_size_t io;
> > +	u16 sts;
> > =20
> > -	__raw_writel(GORESET, softres_reg);
> > +	/* Find the PIIX4 PM device */
> > +	dev =3D pci_get_subsys(PCI_VENDOR_ID_INTEL,
> > +			     PCI_DEVICE_ID_INTEL_82371AB_3, PCI_ANY_ID,
> > +			     PCI_ANY_ID, NULL);
> > +	if (!dev) {
> > +		printk("Failed to find PIIX4 PM\n");
> > +		goto fail;
> > +	}
> > +
> > +	/* Request access to the PIIX4 PM IO registers */
> > +	res =3D pci_request_region(dev, io_region, "PIIX4 PM IO registers");
> > +	if (res) {
> > +		printk("Failed to request PIIX4 PM IO registers (%d)\n", res);
> > +		goto fail_dev_put;
> > +	}
>=20
>  Shouldn't the handle on the device and the resource be requested early=
=20
> on, where mips_machine_halt (mips_machine_power_off) is installed as the=
=20
> halt (power-off) handler?  Especially requesting the resource here seems=
=20
> to make little sense to me -- we're about to kill the box, so why bother=
=20
> verifying whether it's going to interfere with a random driver?

Well requesting the I/O region was more about sanity checking that it's
present. This could be done earlier I guess, it would just mean keeping
around the needed I/O & PCI bus pointers in globals and I don't see the
issue with just acquiring them when they're needed.

>=20
> > +
> > +	/* Find the offset to the PIIX4 PM IO registers */
> > +	io =3D pci_resource_start(dev, io_region);
> > +
> > +	/* Ensure the power button status is clear */
> > +	while (1) {
> > +		sts =3D inw(io + PIIX4_FUNC3IO_PMSTS);
> > +		if (!(sts & PIIX4_FUNC3IO_PMSTS_PWRBTN_STS))
> > +			break;
> > +		outw(sts, io + PIIX4_FUNC3IO_PMSTS);
> > +	}
> > +
> > +	/* Enable entry to suspend */
> > +	outw(PIIX4_FUNC3IO_PMCNTRL_SUS_EN, io + PIIX4_FUNC3IO_PMCNTRL);
> > +
> > +	/* If the special cycle occurs too soon this doesn't work... */
> > +	mdelay(10);
> > +
> > +	/* Find a reference to the PCI bus */
> > +	bus =3D pci_find_next_bus(NULL);
> > +	if (!bus) {
> > +		printk("Failed to find PCI bus\n");
> > +		goto fail_release_region;
> > +	}
> > +
> > +	/*
> > +	 * The PIIX4 will enter the suspend state only after seeing a special
> > +	 * cycle with the correct magic data on the PCI bus. Generate that
> > +	 * cycle now.
> > +	 */
> > +	spec_devid =3D PCI_DEVID(0, PCI_DEVFN(0x1f, 0x7));
> > +	pci_bus_write_config_dword(bus, spec_devid, 0, PIIX4_SUSPEND_MAGIC);
>=20
>  I know all the three of the GT-64120/64120A, Bonito and SOC-it system=20
> controllers support software generation of PCI special cycles, but is the=
=20
> method the same across them all?
>=20
>   Maciej

It's the same for the Galileo GT-64120 & the SOC-it/ROC-it/ROC-it2
system controllers. I'm unsure about Bonito, however there is the
fallback to the existing reset behaviour if it fails. Working on the
GT-64120 & SOC-it+derivatives covers the cases in wide use, ie current
physical Malta systems & QEMU (although QEMU doesn't seem to need the
special cycle anyway).

Paul

--E/DnYTRukya0zdZ1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJTVj9RAAoJEIIg2fppPBxly0sP/0nSUNDhID31CZmKlX3soE8p
qcHVcSiwcfNsfdD/DlcDlFM6SHQw7cbpqToLC8j2KDF8EjEw3OVsj2FXKnb5r5HA
yZit3jSHvxPS7xwD74PiO9meHph0f31zkOoy0SXxI3dcfrc7QzbG8GyhqpPHdhx8
HHje+s4fQQrSexjGcxMbf1Oq9ksQ0P8wEcJrZYOOj0ESavlHzsofFbtmFgP1dPN0
ecWpmG4xZYBDCEV1Hjqk5hj9uQcA9wgZCF/+jecQiPNCxUuA417UWMdtkPxqbiRT
E0KRxjIBo5CANyxcle5l/nwOQGCNyJLpVj6ufa5ctiaDzYZpIg87kQt/SN3BXI8i
sMSV+2/MEZuIXZUlcc4JVWgvlRZt2we9MHRUXO2Jh6XdjYrCfIndIjZqOdQh/G2C
alm3iTuh/d8jOeZ4w0XylNTBkIZ5z89jmPll7ZKbpCl9hw19sNQ6vUpWESDOc15b
/eh7dHYuDR+tw7NwWaVzVFlh6Odm1uWpd/2OZyxvvTsFyVK0PwgOt0YtueIZbHpJ
M5DVHtgn9ymxmpuNRQKJYtEBYV5ZSxqSNY0HC0VIlUMtPkccP5MnB0gLpC50EN3z
pfJ3h1tJLIFU9RUH1XTLm2azkyWsUtgNLhGh6eH0g++yWVbEf31w++sF4WJvjq0v
pf2iw5wF+QsCPW/gQLgN
=Uroe
-----END PGP SIGNATURE-----

--E/DnYTRukya0zdZ1--
