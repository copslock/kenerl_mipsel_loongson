Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g260YIZ27744
	for linux-mips-outgoing; Tue, 5 Mar 2002 16:34:18 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g260YD927739
	for <linux-mips@oss.sgi.com>; Tue, 5 Mar 2002 16:34:13 -0800
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa23333; 5 Mar 2002 18:33 EST
Subject: Re: init_idle reaped before final call
From: Justin Carlson <justincarlson@cmu.edu>
To: Kip Walker <kwalker@broadcom.com>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, linux-kernel@vger.kernel.org,
   linux-mips@oss.sgi.com
In-Reply-To: <3C854399.2BE48DF2@broadcom.com>
References: <3C8522EA.2A00E880@broadcom.com> <292270000.1015365429@flay> 
	<3C854399.2BE48DF2@broadcom.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-3TVi76KKpsSwqmdDCj49"
X-Mailer: Evolution/1.0.2 
Date: 05 Mar 2002 18:33:08 -0500
Message-Id: <1015371192.11989.30.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-3TVi76KKpsSwqmdDCj49
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Tue, 2002-03-05 at 17:15, Kip Walker wrote:
>=20
> Maybe a better fix is to avoid this double calling of init_idle for the
> "master" CPU?  From my reading the code, x86 seems to behave the same.
>=20

Looks to me like the clean fix would be to call init_idle() from
rest_init() before the init() thread is spawned, and remove it from
cpu_idle().  It looks like a pretty straightforward race condition that
no one else has happened to trigger in a bad way.  I'm no scheduler pro,
but I don't see any problems with calling init_idle() earlier.

That fix assumes that bringup of non-primary cpus on other architectures
call init_idle() explicitly before allowing smp_init() to return; this
is true of mips, but I can't vouch for any other arch's.

I'd submit a patch, but I'm sadly lacking in SMP machines for testing.=20
Anyone who wants to rectify that, I'm open to charity.  :)

-Justin


--=-3TVi76KKpsSwqmdDCj49
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8hVW047Lg4cGgb74RAjL/AKCaC/5lAa3QQRZJFACqiKGP0YSRGQCfZHS+
4ihj5Ye/eFN+1FC0rLo+g7Q=
=fibh
-----END PGP SIGNATURE-----

--=-3TVi76KKpsSwqmdDCj49--
