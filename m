Received: from oss.sgi.com (localhost.localdomain [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g3ABAC8d007836
	for <linux-mips-outgoing@oss.sgi.com>; Wed, 10 Apr 2002 04:10:12 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g3ABACg1007835
	for linux-mips-outgoing; Wed, 10 Apr 2002 04:10:12 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from noose.gt.owl.de (noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g3ABA58d007830
	for <linux-mips@oss.sgi.com>; Wed, 10 Apr 2002 04:10:06 -0700
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 4AB68843; Wed, 10 Apr 2002 13:10:32 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 2A6033704F; Wed, 10 Apr 2002 13:10:14 +0200 (CEST)
Date: Wed, 10 Apr 2002 13:10:14 +0200
From: Florian Lohoff <flo@rfc822.org>
To: Rani Assaf <rani@paname.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: Question about r4k_clear_page_xxx()
Message-ID: <20020410111014.GI9514@paradigm.rfc822.org>
References: <20020410041408.G23127@paname.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="G3juXO9GfR42w+sw"
Content-Disposition: inline
In-Reply-To: <20020410041408.G23127@paname.org>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--G3juXO9GfR42w+sw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 10, 2002 at 04:14:08AM +0200, Rani Assaf wrote:
> Hi,
>=20
> I was cleaning  duplicate code between my port of  IDT RC32355 and the
> current tree. I want to use r4k_clear_page_d16() but the function uses
> store double (sd) which is not available on this processor.
>=20
> What's the reason for having r4k_clear_page_xxx() use store double and
> not r4k_copy_page_xxx()??

Just from my guess - r4k_copy_page will pollute the d-cache with the
empty page you are reading. You have twice as much instruction (load +
store) which effectively will give you half the performance.

If "sd" is not available you might want to implement your clear_page
with sw zero, x(a0) like the sd version.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--G3juXO9GfR42w+sw
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8tB2WUaz2rXW+gJcRApMOAJ4mnq4HS7XIa0Qyb2xtNj+PLX2BsACgk22Z
z1sa4VsYc3q8LrsdPJjqPgE=
=FMrc
-----END PGP SIGNATURE-----

--G3juXO9GfR42w+sw--
