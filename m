Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEL4Hw08843
	for linux-mips-outgoing; Fri, 14 Dec 2001 13:04:17 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEL49o08837
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 13:04:11 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa13675;
          14 Dec 2001 15:03 EST
Subject: Re: 2.4.16 on mips-malta, networking fails...
From: Justin Carlson <justincarlson@cmu.edu>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <25369470B6F0D41194820002B328BDD21423EC@ATLOPS>
References: <25369470B6F0D41194820002B328BDD21423EC@ATLOPS>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-ouRco7G2BSc6g6UBzKal"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Dec 2001 15:03:48 -0500
Message-Id: <1008360228.19224.18.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-ouRco7G2BSc6g6UBzKal
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-12-14 at 14:52, Dinesh Nagpure wrote:
> Hello,
> I am trying kernel v2.4.16 on mips-malta, but networking does not seem to=
 be
> working for me.
> ping errors out saying sendto: Network is unreachable.
> I have AMD PCNet32 PCI support enabled under Network device support-Ether=
net
> (10 or 100)- EISA, VLB, PCI and onboard controllers.=20
> Any ideas?
>=20

Is the network device being detected by the driver, e.g. do you see
any status messages from the driver on bootup?

What commands are you using to initialize the interface?  What
does ifconfig say?  How about route -n?

-Justin


--=-ouRco7G2BSc6g6UBzKal
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8Glsk47Lg4cGgb74RArH2AJ4+szAIm+I8aqXY7JXyG01w2vH+IACgpBgW
liJPF06XhjWUc5t6m5xC4Ak=
=OWGg
-----END PGP SIGNATURE-----

--=-ouRco7G2BSc6g6UBzKal--
