Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEN3ms11501
	for linux-mips-outgoing; Fri, 14 Dec 2001 15:03:48 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEN3fo11498
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 15:03:42 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa14947;
          14 Dec 2001 17:02 EST
Subject: RE: 2.4.16 on mips-malta, networking fails...
From: Justin Carlson <justincarlson@cmu.edu>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <25369470B6F0D41194820002B328BDD21423F1@ATLOPS>
References: <25369470B6F0D41194820002B328BDD21423F1@ATLOPS>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-K2loZN6yJ1YLNus+dw0m"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Dec 2001 17:02:59 -0500
Message-Id: <1008367379.19225.25.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-K2loZN6yJ1YLNus+dw0m
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-12-14 at 16:49, Dinesh Nagpure wrote:
> Isn't passing ip=3D command line boot option sufficient for this?
> I mean I sure will have ifconfig and route in the root but for now all I
> want is to make things work.
>=20
> Dinesh
>=20

Passing ip=3D on the command line should work if you are giving it good
information, but the best way to really see what's going on will be to
use ifconfig and route.

In honesty, I'd not realized ip=3D existed until you mentioned it and I
looked at the code.  Learn something new every day.   :)

-Justin



--=-K2loZN6yJ1YLNus+dw0m
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8GncT47Lg4cGgb74RApw5AJ9dZLVcOENe2gavTyrSCWq7a7axpACfYypm
xxcOZQf3qtalW3ZX6GWfgUM=
=M3+e
-----END PGP SIGNATURE-----

--=-K2loZN6yJ1YLNus+dw0m--
