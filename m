Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Apr 2003 17:44:12 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:42634
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225207AbTDVQoL>; Tue, 22 Apr 2003 17:44:11 +0100
Received: (qmail 22256 invoked by uid 502); 22 Apr 2003 16:44:09 -0000
Date: Tue, 22 Apr 2003 09:44:09 -0700
From: ilya@theIlya.com
To: Gilad Benjamini <gilad@riverhead.com>
Cc: Gilad Benjamini <yaelgilad@myrealbox.com>,
	kernelnewbies@nl.linux.org, linux-mips@linux-mips.org
Subject: Re: Crash on insmod
Message-ID: <20030422164409.GB22120@gateway.total-knowledge.com>
References: <328392AA673C0A49B54DABA457E37DAA15EEAA@exchange>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1UWUbFP1cBYEclgG"
Content-Disposition: inline
In-Reply-To: <328392AA673C0A49B54DABA457E37DAA15EEAA@exchange>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--1UWUbFP1cBYEclgG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 22, 2003 at 07:38:57PM +0200, Gilad Benjamini wrote:
> Sad to say that this IS the interesting part.
> The ksymoops data is very un-consistent. This is the only thing that is
> consistent.
Umm... Not having backtrace makes this information virtually useless.
You can reconstruct backtrace manually, by looking at call stack
addresses, and finding them in System.map.

>=20
> > -----Original Message-----
> > From: ilya@theIlya.com [mailto:ilya@theIlya.com]
> > Sent: Tuesday, April 22, 2003 6:27 PM
> > To: Gilad Benjamini
> > Cc: kernelnewbies@nl.linux.org; linux-mips@linux-mips.org
> > Subject: Re: Crash on insmod
> >=20
> >=20
> > I think this is not an interesting part.
> > run the whole thing through ksymoops, and send output here.
> > For mor information see linux/Documentation/OOPS-tracing
> >=20
> > 	Ilya
> >=20
> > On Tue, Apr 22, 2003 at 10:15:32AM +0000, Gilad Benjamini wrote:
> > > This is the interesting part from the oops message:
> > >=20
> > > Using /lib/modules/2.4.20-pre6-sb20021114 ...
> > > unable to handle kernel paging request at virtual address=20
> > 00006e76, epc =3D=3D c0005100, ra =3D=3D 80117e08
> > > Oops in fault.c::do_page_fault, line 224:
> > >=20
> > >=20
> > >=20
> > >=20
> > >=20
> >=20

--1UWUbFP1cBYEclgG
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+pXFZ7sVBmHZT8w8RAv1pAJ4zL8cwL7lgLSp+oBgYUXfCL0VZZACffqzp
u2fsXW42Lf2wxSkh0YpTOrc=
=BsZp
-----END PGP SIGNATURE-----

--1UWUbFP1cBYEclgG--
