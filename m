Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2FCk5T26784
	for linux-mips-outgoing; Fri, 15 Mar 2002 04:46:05 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2FCju926780
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 04:45:56 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id B0A029EFE; Fri, 15 Mar 2002 13:47:23 +0100 (CET)
Date: Fri, 15 Mar 2002 13:47:23 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
Subject: Re: DECStation kernel boot failure
Message-ID: <20020315124723.GZ25044@lug-owl.de>
Mail-Followup-To: "linux-mips@oss.sgi.com" <linux-mips@oss.sgi.com>
References: <B1516392835@i01sv4138.ids1.intelonline.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JVVqWhpkAs5raV7A"
Content-Disposition: inline
In-Reply-To: <B1516392835@i01sv4138.ids1.intelonline.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--JVVqWhpkAs5raV7A
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-03-15 22:16:08 +1030, Guo-Rong Koh <grk@start.com.au>
wrote in message <B1516392835@i01sv4138.ids1.intelonline.com>:
> --kernel boot dump starts here--
> KN02-CA V2.0m  =20
> >>boot 3/rz0/vmlinux - root=3D/dev/nfs nfsroot=3D192.168.2.145:/mips
> ip=3Dbootp
>=20
> NetBSD/pmax 1.5.1 FFS Primary Bootstrap
>=20
> NetBSD/pmax 1.5.2 Secondary Bootstrap, Revision 1.3
> (root@medusa.thistledown.com.au, Aug 23 10:47:54 EST 2001)
>=20
> Boot: 3/rz0/vmlinux
> 2224128+172576 [186+159728+155633]=3D0x296614
> Starting at 0x80040464
>=20
> This DECstation is a Personal DS5000/xx
> CPU revision is: 00000230
> FPU revision is: 00000340
> Primary instruction cache 64kb, linesize 4 bytes
> Primary data cache 64kb, linesize 4 bytes
> Linux version 2.4.16 (root@elrond) (gcc version 2.96 20000731 (Red Hat
> Linux 7.1 2.96-96.1)) #7 Sun Dec 23 14:57:24 MET 2001
> Determined physical RAM map:
>  memory: 01000000 @ 00000000 (usable)
> On node 0 totalpages: 4096
> zone(0): 4096 pages.
> zone(1): 0 pages.
> zone(2): 0 pages.
> Kernel command line: root=3D/dev/nfs nfsroot=3D192.168.2.145:/mips
> ip=3Dbootp

Command line looks good to me.

> Calibrating delay loop... 24.87 BogoMIPS
> Memory: 13520k/16384k available (2007k kernel code, 2864k reserved,
> 87k data, 76k init)
> Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> Kernel panic: can't allocate root vfsmount
> In idle task - not syncing
> --kernel boot dump finishes here--

You attempt to do nfsroot, but I can't see that your network card
has been detected. Are you sure you've included it into kernel
compile? If not, do so...

MfG, JBG

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--JVVqWhpkAs5raV7A
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyR7VoACgkQHb1edYOZ4bsRvgCfUwvGZeHgB+EFhxwN7m0mp9pA
D1cAn3Yo8JsQJraE1PvVV52zefeKR0KU
=oAEn
-----END PGP SIGNATURE-----

--JVVqWhpkAs5raV7A--
