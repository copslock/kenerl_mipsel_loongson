Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 May 2003 20:49:48 +0100 (BST)
Received: from dvmwest.gt.owl.de ([IPv6:::ffff:62.52.24.140]:22279 "EHLO
	dvmwest.gt.owl.de") by linux-mips.org with ESMTP
	id <S8225290AbTEJTtp>; Sat, 10 May 2003 20:49:45 +0100
Received: by dvmwest.gt.owl.de (Postfix, from userid 1001)
	id D89D04ABD1; Sat, 10 May 2003 21:49:42 +0200 (CEST)
Date: Sat, 10 May 2003 21:49:42 +0200
From: Jan-Benedict Glaw <jbglaw@lug-owl.de>
To: linux-mips@linux-mips.org
Subject: Re: Linux for MIPS Atlas 4Kc board
Message-ID: <20030510194942.GH27494@lug-owl.de>
Mail-Followup-To: linux-mips@linux-mips.org
References: <BAY1-F3AmEaJswFCHOz0000b1d9@hotmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="btZF9mwWYNBxqm8J"
Content-Disposition: inline
In-Reply-To: <BAY1-F3AmEaJswFCHOz0000b1d9@hotmail.com>
User-Agent: Mutt/1.4i
X-Operating-System: Linux mail 2.4.18
X-gpg-fingerprint: 250D 3BCF 7127 0D8C A444  A961 1DBD 5E75 8399 E1BB
X-gpg-key: wwwkeys.de.pgp.net
Return-Path: <jbglaw@dvmwest.gt.owl.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jbglaw@lug-owl.de
Precedence: bulk
X-list: linux-mips


--btZF9mwWYNBxqm8J
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, 2003-05-10 08:56:01 -0700, Michael Anburaj <michaelanburaj@hotmail.=
com>
wrote in message <BAY1-F3AmEaJswFCHOz0000b1d9@hotmail.com>:
> Hi,
>=20
> >"init" is another thing. Your NFS root should include a /sbin/init or
> >or /etc/init or /bin/init or /bin/sh. If none of those exists, you
> >loose.
>=20
>=20
> For setting up the NFS, I did the following:
> 1. exported the /export/RedHat7.1

That's okay.

> 2. downloaded MIPS_RedHat7.1_Release-02.00.tar from=20
> ftp://ftp.mips.com/pub/linux/mips/installation/redhat7.1/02.00
>=20
> this tar file has the following:
>=20
> linux\installation\RedHat7.1\RPMS\mips\ <contains a lot of rpms>
> linux\installation\RedHat7.1\RPMS\mipsel\ <contains a lot of rpms>
> linux\installation\RedHat7.1\RPMS\noarch\ <contains a lot of rpms>
> linux\installation\RedHat7.1\install\ <contains a Makefile, install.list,=
=20
> install.script>
> linux\installation\RedHat7.1\install\root\etc\ <contains inittab, securet=
ty>
> linux\installation\RedHat7.1\install\root\etc\sysconfig\ <contains networ=
k>
> linux\installation\RedHat7.1\install\root\etc\xinetd.d\ <contains telnet,=
=20
> rlogin, rsh,rexec, hosts>
>=20
> & some more files.
>=20
> Now tell me what should be extracted to my NFS export /export/RedHat7.1=
=20
> (along with their relative path info.).

Well, I think you should start reaing the files in the install path
(Makefile, install.list etc.). You should also notice that with Linux
you've got '/' as path separator, not DOSsish '\'.

Basically, I *think* your board is big endian, so you need to unpack
everything from the mips and the noarch directory.

After that, there should be:

/export/Redhat7.1/sbin/init
/export/Redhat7.1/bin/sh

=2E..and all the other files.

> Also let me know what path to be passed on to the kernel as parameter to=
=20
> nfsroot=3D
> Is it simply /export/Redhat7.1?

nfsroot=3Dser.ver.ip.addr:/export/Redhat7.1

> Another question: I don't see a init file in the tar. or is inittab=20
> similar? Is this "MIPS_RedHat7.1_Release-02.00.tar" tar file the right fi=
le=20

If you'd cared to look into that file, it's only a plain text file, no
executable file. So these are different things.

> & the only file that is needed for now; that has the right stuff in it? O=
r=20

Possibly. I've got no chance to look into it and to now you haven't
posted a URL from which I can get that file's contents...

> do I need to get the right file from a different tar file?

Maybe. Maybe not. Depends...

MfG, JBG

--=20
   Jan-Benedict Glaw       jbglaw@lug-owl.de    . +49-172-7608481
   "Eine Freie Meinung in  einem Freien Kopf    | Gegen Zensur | Gegen Krieg
    fuer einen Freien Staat voll Freier B=FCrger" | im Internet! |   im Ira=
k!
      ret =3D do_actions((curr | FREE_SPEECH) & ~(IRAQ_WAR_2 | DRM | TCPA));

--btZF9mwWYNBxqm8J
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.1 (GNU/Linux)

iD8DBQE+vVfWHb1edYOZ4bsRAjV4AKCNsZC/spycYWy7Mxc2lFwvhOhnQwCaAz5i
VJUEYljDKumBDi30j0llNrI=
=4aRu
-----END PGP SIGNATURE-----

--btZF9mwWYNBxqm8J--
