Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Jun 2003 23:45:04 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:29570
	"HELO alpha.total-knowledge.com") by linux-mips.org with SMTP
	id <S8225212AbTF3WpC>; Mon, 30 Jun 2003 23:45:02 +0100
Received: (qmail 18200 invoked from network); 30 Jun 2003 15:37:48 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 30 Jun 2003 15:37:48 -0000
Received: (qmail 14547 invoked by uid 502); 30 Jun 2003 22:44:57 -0000
Date: Mon, 30 Jun 2003 15:44:57 -0700
From: ilya@theIlya.com
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: ip32 specific stuff
Message-ID: <20030630224457.GQ13617@gateway.total-knowledge.com>
References: <20030630003636.GI13617@gateway.total-knowledge.com> <20030630073928.GA31773@foobazco.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AwNVUpjOmSj7UnwZ"
Content-Disposition: inline
In-Reply-To: <20030630073928.GA31773@foobazco.org>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2734
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--AwNVUpjOmSj7UnwZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Thanks for comments. I am stopping being lazy right now :)


On Mon, Jun 30, 2003 at 12:39:28AM -0700, Keith M Wesolowski wrote:
> On Sun, Jun 29, 2003 at 05:36:36PM -0700, ilya@theIlya.com wrote:
>=20
> > This is the patch that includes most of things that I have in IP32-spec=
ific
> > parts of my tree.
>=20
> > 2. Propper memory detection pathc by Keith.
>=20
> Please don't apply this.  It's a mostly nice piece of code with one
> horrible hack, and we're better off for now staying with
> CONFIG_ARC_MEMORY until we decide how to best support >256MB of
> memory.
>=20
> The CRIME error handling part is golden however.
>=20
> > 3. Some other minor fixlets.
>=20
> >  void ip32_irq1(struct pt_regs *regs)
> > Index: arch/mips/sgi-ip32/ip32-setup.c
> > =20
> > +#ifdef CONFIG_FB_SGIO2
> > +#include "../../../drivers/video/sgio2fb.h"
> > +void *sgio2fb_mem;
> > +#endif
>=20
> You can't reference this because that driver doesn't exist yet.  And
> including that here is kind of ugly anyway.
>=20
> > -#ifdef CONFIG_SERIAL_CONSOLE
> > +#ifdef CONFIG_SERIAL_MACE_SGIO2
> > +#warning O2MACECONSOLE compiled in
> > +	o2serial_console_init();
> > +#endif
>=20
> Debugging snippet leaked in.
>=20
> > -}
> > -
> > -int __init page_is_ram (unsigned long pagenr)
> > -{
> > -	/* XXX: to do? */
> > -	return 1;
> >  }
>=20
> Yes, this appears to be unused.
>=20
> > Index: include/asm-mips64/ip32/crime.h
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > RCS file: /home/cvs/linux/include/asm-mips64/ip32/crime.h,v
> ...
> > -static inline u64 crime_read_64 (unsigned long __offset) {
> > -        return *((volatile u64 *) (CRIME_BASE + __offset));
> > -}
> > -static inline void crime_write_64 (unsigned long __offset, u64 __val) {
> > -        *((volatile u64 *) (CRIME_BASE + __offset)) =3D __val;
> > -}
> > +#define crime_read_64(__offset)		__in64(CRIME_BASE+(__offset))
> > +#define crime_write_64(__offset,__val)	__out64(__val,CRIME_BASE+(__off=
set))
>=20
> You can't do this yet because I just sent Ralf the patch to add those
> functions, and they're going to be named __raw_readq and __raw_writeq
> as well.  I'll take care of this as soon as that patch is approved.
>=20
> > --- /dev/null	Sun Jul 17 16:46:18 1994
> > +++ include/asm-mips/io64.h	Sun Jun 15 10:35:18 2003
>=20
> There will be no io64.h.
>=20
> --=20
> Keith M Wesolowski <wesolows@foobazco.org> http://foobazco.org/~wesolows
> ------(( Project Foobazco Coordinator and Network Administrator ))------
> 	"May Buddha bless all stubborn people!"
> 				-- Uliassutai Karakorum Blake
>=20

--AwNVUpjOmSj7UnwZ
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/AL1p7sVBmHZT8w8RAnrKAJ9EMsuKrMrrt+6qF5LBoPLX8Un2LwCgn0np
zqU/ruYN+JDjo6y/kaHTkUM=
=HHcC
-----END PGP SIGNATURE-----

--AwNVUpjOmSj7UnwZ--
