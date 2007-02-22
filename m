Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 11:11:55 +0000 (GMT)
Received: from smtp-vbr3.xs4all.nl ([194.109.24.23]:64271 "EHLO
	smtp-vbr3.xs4all.nl") by ftp.linux-mips.org with ESMTP
	id S20037794AbXBVLLu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 11:11:50 +0000
Received: from gateway.home (a82-92-155-199.adsl.xs4all.nl [82.92.155.199])
	by smtp-vbr3.xs4all.nl (8.13.8/8.13.8) with ESMTP id l1MBBFuE072441;
	Thu, 22 Feb 2007 12:11:15 +0100 (CET)
	(envelope-from mouw@nl.linux.org)
Received: from erik by gateway.home with local (Exim 3.36 #1 (Debian))
	id 1HKBr1-0000Un-00; Thu, 22 Feb 2007 12:11:15 +0100
Date:	Thu, 22 Feb 2007 12:11:15 +0100
From:	Erik Mouw <mouw@nl.linux.org>
To:	Raseel Bhagat <raseelbhagat@gmail.com>
Cc:	kernelnewbies <kernelnewbies@nl.linux.org>,
	newbie <linux-newbie@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: not getting command prompt at the console
Message-ID: <20070222111115.GC31252@gateway.home>
References: <b115cb5f0702220149wfbfc051qc8d0106b9e4ed98d@mail.gmail.com> <20070222102540.GB31252@gateway.home> <f68850780702220250x57f4f678re104caecfeec6ef2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="kVXhAStRUZ/+rrGn"
Content-Disposition: inline
In-Reply-To: <f68850780702220250x57f4f678re104caecfeec6ef2@mail.gmail.com>
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Virus-Scanned: by XS4ALL Virus Scanner
Return-Path: <mouw@nl.linux.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mouw@nl.linux.org
Precedence: bulk
X-list: linux-mips


--kVXhAStRUZ/+rrGn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2007 at 04:20:08PM +0530, Raseel Bhagat wrote:
> On 2/22/07, Erik Mouw <mouw@nl.linux.org> wrote:
> >Run a getty on the serial device (I suppose you're using a serial
> >port).
> >Could be that the serial driver changed or that you forgot to compile a
> >driver for the serial device.
> >
>=20
> Also , assuming you are using a serial console , check your entries in
> the inittab file .
> It should look  something like :
> ttyS0::respawn:/sbin/getty ttyS0 115200 linux

If the device is indeed called "ttyS0". Remember it's a MIPS board, not
a peecee. For example, on StrongARM SA11x0 you need to use ttySA0
instead of ttyS0.

Erik

--=20
They're all fools. Don't worry. Darwin may be slow, but he'll
eventually get them. -- Matthew Lammers in alt.sysadmin.recovery

--kVXhAStRUZ/+rrGn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFF3XpS/PlVHJtIto0RAhBJAKCHMQo2h9vHdq8sSTSzb3O8uwmLzgCfTWXh
9P2DzHQLsDvZQShNgq3vvb4=
=8U7o
-----END PGP SIGNATURE-----

--kVXhAStRUZ/+rrGn--
