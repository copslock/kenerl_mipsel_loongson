Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g2FDma528967
	for linux-mips-outgoing; Fri, 15 Mar 2002 05:48:36 -0800
Received: from dvmwest.gt.owl.de (dvmwest.gt.owl.de [62.52.24.140])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g2FDmQ928964
	for <linux-mips@oss.sgi.com>; Fri, 15 Mar 2002 05:48:26 -0800
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id 4B2B49EFE; Fri, 15 Mar 2002 14:49:54 +0100 (CET)
Date: Fri, 15 Mar 2002 14:49:54 +0100
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@oss.sgi.com
Subject: Re: DECStation kernel boot failure
Message-ID: <20020315134953.GB25044@lug-owl.de>
Mail-Followup-To: linux-mips@oss.sgi.com
References: <20020315124723.GZ25044@lug-owl.de> <200203151324.OAA18816@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="309evMHi/619oHyA"
Content-Disposition: inline
In-Reply-To: <200203151324.OAA18816@sparta.research.kpn.com>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux mail 2.4.15-pre2 
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--309evMHi/619oHyA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, 2002-03-15 14:24:30 +0100, Houten K.H.C. van (Karel) <vhouten@kpn.c=
om>
wrote in message <200203151324.OAA18816@sparta.research.kpn.com>:
> Jan-Benedict Glaw wrote:
> > On Fri, 2002-03-15 22:16:08 +1030, Guo-Rong Koh <grk@start.com.au>
> > wrote in message <B1516392835@i01sv4138.ids1.intelonline.com>:
> > > ....
> > > This DECstation is a Personal DS5000/xx
> > > CPU revision is: 00000230
> > > FPU revision is: 00000340
> > > Primary instruction cache 64kb, linesize 4 bytes
> > > Primary data cache 64kb, linesize 4 bytes
> > > Linux version 2.4.16 (root@elrond) (gcc version 2.96 20000731 (Red Hat
> > > Linux 7.1 2.96-96.1)) #7 Sun Dec 23 14:57:24 MET 2001
> > > Determined physical RAM map:
> > >  memory: 01000000 @ 00000000 (usable)
> > > On node 0 totalpages: 4096
> > > zone(0): 4096 pages.
> > > zone(1): 0 pages.
> > > zone(2): 0 pages.
> > > Kernel command line: root=3D/dev/nfs nfsroot=3D192.168.2.145:/mips
> > > ip=3Dbootp
> >=20
> > Command line looks good to me.
> >=20
> > > Calibrating delay loop... 24.87 BogoMIPS
> > > Memory: 13520k/16384k available (2007k kernel code, 2864k reserved,
> > > 87k data, 76k init)
> > > Dentry-cache hash table entries: 2048 (order: 2, 16384 bytes)
> > > Inode-cache hash table entries: 1024 (order: 1, 8192 bytes)
> > > Mount-cache hash table entries: 512 (order: 0, 4096 bytes)
> > > Kernel panic: can't allocate root vfsmount
> > > In idle task - not syncing
> > > --kernel boot dump finishes here--
> >=20
> > You attempt to do nfsroot, but I can't see that your network card
> > has been detected. Are you sure you've included it into kernel
> > compile? If not, do so...
>=20
> He uses my kernel image. I'm sure I've included the DECStation 5000
> ethernet card, because the same image works OK on other DECStations.
> I don't have access to a 5000/25 however.

=2E..but Linux doesn't recognize the NIC on this box. Karel, digging
unto deep layers of my bad memory I can remember that some DECstations
had a different NIC or different way to access it or so. I've got
some different DECstations, but there's one which I cannot really
use because of lacking support for the nic. The box was supported
at some time (there at least exists some old hacked network driver
for 2.1.53 or so), but I do no longer have access to the file (my
laptop was stolen this week and the driver was in my TODO directory,
not backup'ed:-(

MfG, JBG
PS: However, the NIC isn't found, so the kernel cannot boot off nfsroot.

--=20
Jan-Benedict Glaw   .   jbglaw@lug-owl.de   .   +49-172-7608481
	 -- New APT-Proxy written in shell script --
	   http://lug-owl.de/~jbglaw/software/ap2/

--309evMHi/619oHyA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iEYEARECAAYFAjyR/AEACgkQHb1edYOZ4buAxACeJzLarV/FFKkHSXfiZIBBoB3i
fcsAni0fjN+t2wzykcyoCks5iGDF1nwi
=83Jf
-----END PGP SIGNATURE-----

--309evMHi/619oHyA--
