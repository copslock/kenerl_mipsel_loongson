Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2BGkdj06275
	for linux-mips-outgoing; Mon, 11 Mar 2002 08:46:39 -0800
Received: from ux3.sp.cs.cmu.edu (UX3.SP.CS.CMU.EDU [128.2.198.103])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2BGkU906272
	for <linux-mips@oss.sgi.com>; Mon, 11 Mar 2002 08:46:31 -0800
Received: from GS256.SP.CS.CMU.EDU ([128.2.199.27]) by ux3.sp.cs.cmu.edu
          id aa11401; 11 Mar 2002 10:45 EST
Subject: Re: Linux-mips porting issues
From: Justin Carlson <justincarlson@cmu.edu>
To: santhosh <ps.santhosh@gdatech.co.in>
Cc: linux-mips@oss.sgi.com
In-Reply-To: <3C8CFB45.9E749117@gdatech.co.in>
References: <3C8CFB45.9E749117@gdatech.co.in>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature";
	boundary="=-mDyH/s9vLYj37utn03SB"
X-Mailer: Evolution/1.0.2 
Date: 11 Mar 2002 10:45:21 -0500
Message-Id: <1015861530.28663.38.camel@gs256.sp.cs.cmu.edu>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--=-mDyH/s9vLYj37utn03SB
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2002-03-11 at 13:45, santhosh=03 wrote:
>=20
> Hi All ...
>=20
>       Subj: Linux-Porting  issue
> Here I ported Linux -mips on  BCM1250 board(Broadcom)  had occurred
> some error which showed below
>=20
>=20
> CFE>Boot -z -elf 192.168.200.150:zimage
> andkishore_rane: Loader:elf Filesys:tftp Dev:eth0
> File:192.168.200.150:zimage Optionsnull)
> Loading: 0x80100000/1342312 0x80248000/2297856 0x80479000/343232 Entry
> at 0x8010
> 047c

You're trying to boot the kernel image directly from CFE?  I hope you've
embedded a ramdisk for your root filesystem...that or there must be some
spiffy new features in CFE that weren't there last I looked at it.

> Kernel command line: root=3D/dev/ram0

That looks good...

Does it work fine with CONFIG_SMP=3Dn?  Or have you not tried that?

-Justin


--=-mDyH/s9vLYj37utn03SB
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQA8jNER47Lg4cGgb74RAk6FAKDDurYRGrseI03cEQNDQrMJykl3kQCcCE7J
HamoH/PRVM2rdB3LjsBXKlg=
=MlFF
-----END PGP SIGNATURE-----

--=-mDyH/s9vLYj37utn03SB--
