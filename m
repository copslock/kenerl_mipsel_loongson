Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g48EptwJ030158
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 8 May 2002 07:51:55 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g48EptUq030157
	for linux-mips-outgoing; Wed, 8 May 2002 07:51:55 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g48EpjwJ030154
	for <linux-mips@oss.sgi.com>; Wed, 8 May 2002 07:51:45 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id C3C1684D; Wed,  8 May 2002 16:53:10 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id C4A403711E; Wed,  8 May 2002 16:52:44 +0200 (CEST)
Date: Wed, 8 May 2002 16:52:44 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
   Szabo Attila <trial@ugyvitelszolgaltato.hu>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: indy scsi
Message-ID: <20020508145244.GB9959@paradigm.rfc822.org>
References: <E175RdX-0001aT-00@the-village.bc.nu> <Pine.GSO.4.21.0205081631510.20512-100000@vervain.sonytel.be>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EuxKj2iCbKjpUGkD"
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.21.0205081631510.20512-100000@vervain.sonytel.be>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EuxKj2iCbKjpUGkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 08, 2002 at 04:32:35PM +0200, Geert Uytterhoeven wrote:
> On Wed, 8 May 2002, Alan Cox wrote:
> > > Yes, I know all of that, and I've expected only max 3-5 MB/sec but not
> > > 1.7.
> > > The scsi bandwith on indy is 10MB/s, the disk is above 10 MB/s.
> > > Maybe I expect too much
> >=20
> > An old 2Gb 5400 RPM drive ought to deliver about 2Mbytes/second data ra=
tes.
> > The 1.7 sounds suprisingly low unless the driver code doesn't support=
=20
> > disconnect and scsi2 tagged stuff. For an old NCR538x/9x device without
> > those it sounds all too believable.
>=20
> Doesn't the Indy have a wd33c93, like the Amiga 3000? If yes, 1.7 MiB/s is
> indeed quite low.

It does have one of those. And it supports disconnect which was
the problem with the read corruption going on in former days.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--EuxKj2iCbKjpUGkD
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE82Tu8Uaz2rXW+gJcRAp8jAJ9oHVkF2Os5iBmWcLFnsmtYfw6ljQCgnRHd
qOdhazyqBtVmH24xnY/uFFU=
=I1JF
-----END PGP SIGNATURE-----

--EuxKj2iCbKjpUGkD--
