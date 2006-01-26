Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Jan 2006 16:56:04 +0000 (GMT)
Received: from honk1.physik.uni-konstanz.de ([134.34.140.224]:19093 "EHLO
	honk1.physik.uni-konstanz.de") by ftp.linux-mips.org with ESMTP
	id S8133655AbWAZQzr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 26 Jan 2006 16:55:47 +0000
Received: from localhost (localhost.localnet [127.0.0.1])
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id E04002BBE3;
	Thu, 26 Jan 2006 18:00:10 +0100 (CET)
Received: from honk1.physik.uni-konstanz.de ([127.0.0.1])
	by localhost (honk [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 19939-47; Thu, 26 Jan 2006 18:00:05 +0100 (CET)
Received: from bogon.sigxcpu.org (unknown [62.157.100.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by honk1.physik.uni-konstanz.de (Postfix) with ESMTP id 5A0FC2BBE2;
	Thu, 26 Jan 2006 18:00:05 +0100 (CET)
Received: by bogon.sigxcpu.org (Postfix, from userid 1000)
	id C228211E575; Thu, 26 Jan 2006 17:45:53 +0100 (CET)
Date:	Thu, 26 Jan 2006 17:45:53 +0100
From:	Guido Guenther <agx@sigxcpu.org>
To:	Kumba <kumba@gentoo.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: [PATCH]: Add byteorder/endianess to /proc/cpuinfo
Message-ID: <20060126164553.GA6335@bogon.ms20.nix>
Mail-Followup-To: Guido Guenther <agx@sigxcpu.org>,
	Kumba <kumba@gentoo.org>, linux-mips@linux-mips.org
References: <20060124195419.GB24568@toucan.gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
In-Reply-To: <20060124195419.GB24568@toucan.gentoo.org>
User-Agent: Mutt/1.5.11
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at honk.physik.uni-konstanz.de
Return-Path: <agx@sigxcpu.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@sigxcpu.org
Precedence: bulk
X-list: linux-mips


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 24, 2006 at 07:54:19PM +0000, Kumba wrote:
> Adds an additional field to /proc/cpuinfo that states the byteorder
> of the system.  This has been floating around for some time on the
> list, so maybe this time is the charm.
This actually got removed from mainline ages ago. It's only being
carried around in distribution kernels for legacy reasons - we shouldn't
readd it.
Cheers,
 -- Guido
>=20
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>=20
>  proc.c |    5 +++++
>  1 file changed, 5 insertions(+)
>=20

> diff -Naurp mipslinux/arch/mips/kernel/proc.c mipslinux-byteorder/arch/mi=
ps/kernel/proc.c
> --- mipslinux/arch/mips/kernel/proc.c	2006-01-22 21:14:11.000000000 -0500
> +++ mipslinux-byteorder/arch/mips/kernel/proc.c	2006-01-24 13:39:47.00000=
0000 -0500
> @@ -114,6 +114,11 @@ static int show_cpuinfo(struct seq_file=20
>  	seq_printf(m, "BogoMIPS\t\t: %lu.%02lu\n",
>  	              cpu_data[n].udelay_val / (500000/HZ),
>  	              (cpu_data[n].udelay_val / (5000/HZ)) % 100);
> +#ifdef __MIPSEB__
> +	seq_printf(m, "byteorder\t\t: big endian\n");
> +#else
> +	seq_printf(m, "byteorder\t\t: little endian\n");
> +#endif
>  	seq_printf(m, "wait instruction\t: %s\n", cpu_wait ? "yes" : "no");
>  	seq_printf(m, "microsecond timers\t: %s\n",
>  	              cpu_has_counter ? "yes" : "no");


--mP3DRpeJDSE+ciuQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFD2PzBn88szT8+ZCYRAgoYAJ99bd48SD5Io70zyQVYmtn8s0vdnwCdEEtR
Obq2PIVz+tDKF6HI0TSQf9A=
=rcOx
-----END PGP SIGNATURE-----

--mP3DRpeJDSE+ciuQ--
