Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Jun 2003 15:30:30 +0100 (BST)
Received: from 12-234-207-60.client.attbi.com ([IPv6:::ffff:12.234.207.60]:18310
	"HELO gateway.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225214AbTFBOa1>; Mon, 2 Jun 2003 15:30:27 +0100
Received: (qmail 1397 invoked by uid 502); 2 Jun 2003 14:30:23 -0000
Date: Mon, 2 Jun 2003 07:30:23 -0700
From: ilya@theIlya.com
To: Keith Owens <kaos@sgi.com>
Cc: linux-mips@linux-mips.org
Subject: Re: Yet another fix
Message-ID: <20030602143022.GK3035@gateway.total-knowledge.com>
References: <20030602045700.GI3035@gateway.total-knowledge.com> <5368.1054560466@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5mZBmBd1ZkdwT1ny"
Content-Disposition: inline
In-Reply-To: <5368.1054560466@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--5mZBmBd1ZkdwT1ny
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

For starters, I'm talking about 2.5.51 here.
Secondly, what does register_ioctl32_conversion have to do with
emulating 32bit modutils? Code in quesion is this:
int register_ioctl32_conversion(unsigned int cmd, int (*handler)(unsigned i=
nt, unsigned int, unsigned long, ...))
{
	int i;
	if (!additional_ioctls) {
		additional_ioctls =3D module_map(PAGE_SIZE);
		if (!additional_ioctls)
			return -ENOMEM;
		memset(additional_ioctls, 0, PAGE_SIZE);
	}
=2E....

As far as I can tell, There is nothing that prevents us from
replacing module_map with vmalloc, or even get_free_pages,
but I am not sure. There must be some reason, why it is there :)
Ralf, it's question for you.

	Ilya.


On Mon, Jun 02, 2003 at 11:27:46PM +1000, Keith Owens wrote:
> On Sun, 1 Jun 2003 21:57:00 -0700,=20
> ilya@theIlya.com wrote:
> >module_map is referenced in register_ioctl32_conversion in arch/mips64/i=
octl32.c
> >As far as I can see, it should simply be possible to replace module_map
> >with vmalloc in there, but I am not sure, as I don't know how exactly
> >ioctl translations work...
>=20
> Not in 2.4.20 nor 2.4.21-rc6 from Marcelo, must be a mips local change.
> I strongly suggest that you get rid of it, there is no good reason to
> emulate the 32 bit module syscalls on a 64 bit machine.  modutils is
> pure Linux and there is absolutely no justification for emulating 32
> bit versions of modutils when the user can install the 64 bit version
> of modutils instead.  32 bit emulation is a crutch to let binary only
> programs work when you do not have the source to rebuild to 64 bit, by
> definition we have the source to modutils.
>=20
> IA64 and x86_64 make no attempt to emulate 32 bit modutils.  sparc64,
> ppc64 and s390x all pass the data straight to the 64 bit kernel code,
> they require the user space modutils to supply 64 bit data.  Emulation
> is a waste of time.
>=20

--5mZBmBd1ZkdwT1ny
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE+219+7sVBmHZT8w8RAtElAKC8GqtzSuqCwi5aZ86+I7UtsX+ovgCghp64
dis1DUvLaTjnBLJDUaFEWwk=
=RIxu
-----END PGP SIGNATURE-----

--5mZBmBd1ZkdwT1ny--
