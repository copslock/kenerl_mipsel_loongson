Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBFDlgF19674
	for linux-mips-outgoing; Sat, 15 Dec 2001 05:47:42 -0800
Received: from noose.gt.owl.de (postfix@noose.gt.owl.de [62.52.19.4])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBFDlao19667
	for <linux-mips@oss.sgi.com>; Sat, 15 Dec 2001 05:47:36 -0800
Received: by noose.gt.owl.de (Postfix, from userid 10)
	id 0BC72853; Sat, 15 Dec 2001 13:47:25 +0100 (CET)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 86DAB4242; Sat, 15 Dec 2001 13:46:04 +0100 (CET)
Date: Sat, 15 Dec 2001 13:46:04 +0100
From: Florian Lohoff <flo@rfc822.org>
To: Keith Owens <kaos@melbourne.sgi.com>
Cc: Karsten Merker <karsten@excalibur.cologne.de>, linux-mips@oss.sgi.com
Subject: Re: No bzImage target for MIPS
Message-ID: <20011215124604.GE23167@paradigm.rfc822.org>
References: <20011215093101.A256@excalibur.cologne.de> <20472.1008407699@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9l24NVCWtSuIVIod"
Content-Disposition: inline
In-Reply-To: <20472.1008407699@ocs3.intra.ocs.com.au>
User-Agent: Mutt/1.3.24i
Organization: rfc822 - pure communication
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


--9l24NVCWtSuIVIod
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 15, 2001 at 08:14:59PM +1100, Keith Owens wrote:

> target, like elf, srec and bin.  To that end, I looked at moving
> elf2ecoff and addinitrd to an arch independent directory so everybody
> could use those tools, alas both contain mips specific code.  Any idea
> how much work is required to make elf2ecoff and addinitrd into generic
> utilities?  Is it worth the effort or should they stay as mips only?

Last i had a look elf2ecoff and addinitrd were not really nice
recovering from toolchain problems like pages of null between sections
which was a common fault a couple months back. This lead to addinitrd
not beeing able to attach a ramdisk that the kernel would be able to
find it.=20

BTW: Shouldn't objcopy be able to convert an ELF into an ECOFF ?

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-5201-669912
Nine nineth on september the 9th              Welcome to the new billenium

--9l24NVCWtSuIVIod
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.0.6 (GNU/Linux)
Comment: For info see http://www.gnupg.org

iD8DBQE8G0YMUaz2rXW+gJcRAtRVAKCj8Jnd1W57LaHsT1tWCwgh/iOE5wCgpihP
Jj5eLbAM4ELyAVbSycp5RRY=
=P+Ak
-----END PGP SIGNATURE-----

--9l24NVCWtSuIVIod--
