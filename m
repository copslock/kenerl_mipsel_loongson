Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 22:47:42 +0100 (BST)
Received: from alpha.total-knowledge.com ([IPv6:::ffff:209.157.135.102]:65511
	"EHLO alpha.total-knowledge.com") by linux-mips.org with ESMTP
	id <S8225633AbTJIVrK>; Thu, 9 Oct 2003 22:47:10 +0100
Received: (qmail 28610 invoked from network); 9 Oct 2003 21:47:06 -0000
Received: from unknown (HELO gateway.total-knowledge.com) (12.234.207.60)
  by alpha.total-knowledge.com with SMTP; 9 Oct 2003 21:47:06 -0000
Received: (qmail 19927 invoked by uid 502); 9 Oct 2003 21:47:06 -0000
Date: Thu, 9 Oct 2003 14:47:06 -0700
From: ilya@theIlya.com
To: Matthew Dharm <mdharm@momenco.com>
Cc: durai <durai@isofttech.com>, mips <linux-mips@linux-mips.org>
Subject: Re: how to include mips assembly in c code?
Message-ID: <20031009214706.GA19899@gateway.total-knowledge.com>
References: <007801c38e27$a1c81920$6b00a8c0@DURAI> <20031009010539.B3375@momenco.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MGYHOYXEY6WxJCY8"
Content-Disposition: inline
In-Reply-To: <20031009010539.B3375@momenco.com>
User-Agent: Mutt/1.4i
Return-Path: <ilya@gateway.total-knowledge.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3406
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ilya@theIlya.com
Precedence: bulk
X-list: linux-mips


--MGYHOYXEY6WxJCY8
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Here we go - whole six lines of code! What a terrible copyright infigement!

On Thu, Oct 09, 2003 at 01:05:39AM -0700, Matthew Dharm wrote:
> I feel compelled to point out that the source file you are quoting looks
> suspiciously like it came from VxWorks, which means it is likely copyright
> Wind River Systems.  Using their code without permission would be illegal.
>=20
> Matt
>=20
> On Thu, Oct 09, 2003 at 11:08:56AM +0530, durai wrote:
> > hello,
> > I am having the following assembly code and i wanted to call this funct=
ion from a c code.
> > can anybody tell me how to include this code in a c program?
> >=20
> > /**********************************************************************=
********
> > *
> > * sysWbFlush - flush the write buffer
> > *
> > * This routine flushes the write buffers, making certain all
> > * subsequent memory writes have occurred.  It is used during critical p=
eriods
> > * only, e.g., after memory-mapped I/O register access.
> > *
> > * RETURNS: N/A
> >=20
> > * sysWbFlush (void)
> >=20
> > */
> >         .ent    sysWbFlush
> > sysWbFlush:
> >         li      t0, K1BASE              /* load uncached address       =
 */
> >         lw      t0, 0(t0)               /* read in order to flush      =
 */
> >         j       ra                      /* return to caller            =
 */
> >         .end    sysWbFlush
> >=20
> >=20
> > regards
> > durai
> --=20
> Matthew Dharm                              Work: mdharm@momenco.com
> Senior Software Designer, Momentum Computer
>=20
>=20

--MGYHOYXEY6WxJCY8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.7 (GNU/Linux)

iD8DBQE/hddZ7sVBmHZT8w8RAu+ZAKCY0ivd8bPsH6WgaZkD0hkPeRESQgCfWFRq
W0O/YquO7eplzj0kIjTO0xM=
=ZHHF
-----END PGP SIGNATURE-----

--MGYHOYXEY6WxJCY8--
