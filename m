Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Oct 2005 23:10:08 +0100 (BST)
Received: from hydra.gt.owl.de ([195.71.99.218]:20105 "EHLO hydra.gt.owl.de")
	by ftp.linux-mips.org with ESMTP id S3465606AbVJMWJr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 13 Oct 2005 23:09:47 +0100
Received: by hydra.gt.owl.de (Postfix, from userid 104)
	id EFE48199429; Fri, 14 Oct 2005 00:09:44 +0200 (CEST)
Received: by paradigm.rfc822.org (Postfix, from userid 1000)
	id 67755138014; Fri, 14 Oct 2005 00:09:36 +0200 (CEST)
Date:	Fri, 14 Oct 2005 00:09:36 +0200
From:	Florian Lohoff <flo@rfc822.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: Tftp problems with ARC firmware
Message-ID: <20051013220936.GA15668@paradigm.rfc822.org>
References: <20051013193225.GA3137@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
In-Reply-To: <20051013193225.GA3137@linux-mips.org>
Organization: rfc822 - pure communication
X-SpiderMe: mh-200510132349@listme.rfc822.org
User-Agent: Mutt/1.5.9i
Return-Path: <flo@rfc822.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9222
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: flo@rfc822.org
Precedence: bulk
X-list: linux-mips


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 13, 2005 at 08:32:25PM +0100, Ralf Baechle wrote:
> I'd like to point those who you need to use these crude workarounds:
>=20
>   echo 1 > /proc/sys/net/ipv4/ip_no_pmtu_disc
>   echo 4096 32767 > /proc/sys/net/ipv4/ip_local_port_range
>=20
> at a new version of tftp-hpa which solves the PMTU problem by disabling it
> only for the tftp client and introduces a new -R begin:end option which
> allows to limit the port number range.  The changes are about to become
> available in the tftp-hpa git repository at
> http://www.kernel.org/pub/scm/network/tftp/tftp-hpa.git; see also
> http://www.linux-mips.org/wiki/ARC#tftp-hpa.  Please send test reports to
> syslinux@zytor.com and linux-mips@linux-mips.org.

I made a patch against tftpd-hpa for disabling path MTU discovery - Its
in the Debian BTS:=20

http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D316616

It should already be merged upstream. User "-F" to disable PMTUd.

Flo
--=20
Florian Lohoff                  flo@rfc822.org             +49-171-2280134
                        Heisenberg may have been here.

--jRHKVT23PllUwdXP
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFDTtsgUaz2rXW+gJcRAof2AJ4jhJukStNBxI0+wqfyXYw949AmDACeLnjO
nvVgEBMw4ShjPVyjiSb/dgQ=
=NWdP
-----END PGP SIGNATURE-----

--jRHKVT23PllUwdXP--
