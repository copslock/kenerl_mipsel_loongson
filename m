Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Feb 2003 17:05:30 +0000 (GMT)
Received: from noose.gt.owl.de ([IPv6:::ffff:62.52.19.4]:51464 "EHLO
	noose.gt.owl.de") by linux-mips.org with ESMTP id <S8225207AbTBLRF3>;
	Wed, 12 Feb 2003 17:05:29 +0000
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id A5C2625DB2; Wed, 12 Feb 2003 18:05:28 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id ABF48B2AB; Wed, 12 Feb 2003 16:26:20 +0100 (CET)
Date: Wed, 12 Feb 2003 16:26:20 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030212152620.GB7934@paradigm.rfc822.org>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com> <20030210100319.GA30624@merry> <20030210223955.GF8408@pureza.melbourne.sgi.com> <20030211224622.GC1186@paradigm.rfc822.org> <20030212050341.GI8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="E39vaYmALEf/7YXx"
Content-Disposition: inline
In-Reply-To: <20030212050341.GI8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Organization: rfc822 - pure communication
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--E39vaYmALEf/7YXx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 12, 2003 at 04:03:41PM +1100, Andrew Clausen wrote:
> On Tue, Feb 11, 2003 at 11:46:22PM +0100, Florian Lohoff wrote:
> > You dont need e2fsprogs
>=20
> Right, just they seem so coupled...
>=20
> > - Just certain parts of the libe2fs which itself
> > just uses some very basic libc functions like malloc/free/str* which
> > we all have within arcboot.
>=20
> I disagree.
>=20
> libe2fs includes lots of headers:
>=20
> 	pureza:~/e2fsprogs-1.32/lib$ find . | grep '\.[ch]$' | xargs grep -h "#i=
nclude <" | sort | uniq | wc -l
> 	     77
>=20
> Also, running nm gives libc calls that invoke syscalls galore.
> For example:
>=20
> 	open64, close, ioctl, opendir, fprintf, getmntent, lseek64, time
>=20
> I got these names from:
>=20
> 	pureza:~/e2fsprogs-1.32/lib$ nm libext2fs.a | grep '^ *U' | less
>=20
> Am I missing something?

Yes - That you dont need all those objects in that archive.=20

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
                        Heisenberg may have been here.

--E39vaYmALEf/7YXx
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE+SmecUaz2rXW+gJcRAgODAKDMmQguHevZRvCl2l+83LlsOfC0oQCfWd1J
FfnWsKReCvFHaKRD5KSLq9s=
=UtZR
-----END PGP SIGNATURE-----

--E39vaYmALEf/7YXx--
