Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g18MJ7q11874
	for linux-mips-outgoing; Fri, 8 Feb 2002 14:19:07 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g18MIxA11870
	for <linux-mips@oss.sgi.com>; Fri, 8 Feb 2002 14:18:59 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 9078B84B; Fri,  8 Feb 2002 23:18:39 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 93AA94162; Fri,  8 Feb 2002 23:18:49 +0100 (CET)
Date: Fri, 8 Feb 2002 23:18:49 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Daniel Jacobowitz <dan@debian.org>
Cc: linux-mips@oss.sgi.com
Subject: Re: gdb disassemble bug
Message-ID: <20020208221849.GA18922@paradigm.rfc822.org>
References: <20020208215851.GA18416@paradigm.rfc822.org> <20020208171051.A1829@nevyn.them.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Content-Disposition: inline
In-Reply-To: <20020208171051.A1829@nevyn.them.org>
User-Agent: Mutt/1.3.27i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 08, 2002 at 05:10:51PM -0500, Daniel Jacobowitz wrote:
> On Fri, Feb 08, 2002 at 10:58:51PM +0100, Florian Lohoff wrote:
> > 0x88166b58 <probe_scache+188>:	mtc0	zero,gp
> > 0x88166b5c <probe_scache+192>:	nop
> > 0x88166b60 <probe_scache+196>:	mtc0	zero,sp
> > 0x88166b64 <probe_scache+200>:	nop
> >=20
> > mtc0/mfc0 do not address cpu registers but CP0 registers. The decoding
> > as "gp" or "sp" is not correct. These are "TagLo" and "TagHi".
>=20
>   - what version of GDB?
>   - does objdump do the same thing?

reset:~# gdb --version
GNU gdb 5.1
Copyright 2001 Free Software Foundation, Inc.
GDB is free software, covered by the GNU General Public License, and you are
welcome to change it and/or distribute copies of it under certain condition=
s.
Type "show copying" to see the conditions.
There is absolutely no warranty for GDB.  Type "show warranty" for details.
This GDB was configured as "mips-linux".
reset:~# dpkg -l gdb
Desired=3DUnknown/Install/Remove/Purge/Hold
| Status=3DNot/Installed/Config-files/Unpacked/Failed-config/Half-installed
|/ Err?=3D(none)/Hold/Reinst-required/X=3Dboth-problems (Status,Err: upperc=
ase=3Dbad)
||/ Name           Version        Description
+++-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D-=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
ii  gdb            5.1-1          The GNU Debugger


Objdump does seem to get this right:

88166b58:	4080e000 	mtc0	zero,$28
88166b60:	4080e800 	mtc0	zero,$29

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8ZE7JUaz2rXW+gJcRAnBKAJ9j3mlpOklYr58fP56LiYK1CyL9CgCgo6OF
AQXHnjP5p1nwFl6Hc+3qdwg=
=DV4t
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
