Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBELpGX10441
	for linux-mips-outgoing; Fri, 14 Dec 2001 13:51:16 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBELpBo10438
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 13:51:11 -0800
Received: from GS256.SP.CS.CMU.EDU by ux3.sp.cs.cmu.edu id aa14219;
          14 Dec 2001 15:50 EST
Subject: RE: 2.4.16 on mips-malta, networking fails...
From: Justin Carlson <justincarlson@cmu.edu>
To: Dinesh Nagpure <dinesh_nagpure@ivivity.com>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <25369470B6F0D41194820002B328BDD21423ED@ATLOPS>
References: <25369470B6F0D41194820002B328BDD21423ED@ATLOPS>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-vVCztX+7j+sZuOihht9R"
X-Mailer: Evolution/0.99.2 (Preview Release)
Date: 14 Dec 2001 15:50:27 -0500
Message-Id: <1008363027.19225.20.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-vVCztX+7j+sZuOihht9R
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Fri, 2001-12-14 at 15:25, Dinesh Nagpure wrote:

> Apparently the device is being detected.
> I am using ramdisk root which i created using busybox v0.60.1 and dont ha=
ve
> ifconfig or route built into it.
>=20

How are you setting the IP information for the NIC, then?  Are you
compiling a kernel with IP autoconfiguration and using a DHCP server? =20

If you're not configuring the NIC, then the OS doesn't consider it to be
a valid source/target of IP information, so when you try to ping from
the machine, Linux is telling you "I don't have any valid place to put
an ICMP packet to get to the place you want it to go". =20

-Justin


--=-vVCztX+7j+sZuOihht9R
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8GmYT47Lg4cGgb74RAma4AJ9CvmN81lXMlycv3kkg5X7B3lqF2wCeI2+k
tASQV8qIYF9L6lyZd11zW2s=
=VQKT
-----END PGP SIGNATURE-----

--=-vVCztX+7j+sZuOihht9R--
