Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 19:21:17 +0000 (GMT)
Received: from ns1.xeneris.net ([IPv6:::ffff:195.49.173.97]:31106 "HELO
	superfix.xeneris.net") by linux-mips.org with SMTP
	id <S8224954AbUAFTVQ>; Tue, 6 Jan 2004 19:21:16 +0000
Received: (qmail 684 invoked by uid 64014); 6 Jan 2004 19:21:19 -0000
Received: from joe@jorrit.de by superfix by uid 64011 with qmail-scanner-1.15 
 (clamscan: 0.54. spamassassin: 2.50-cvs.  Clear:. 
 Processed in 0.58116 secs); 06 Jan 2004 19:21:19 -0000
Received: from localhost (HELO jupiter.planets) (127.0.0.1)
  by localhost with SMTP; 6 Jan 2004 19:21:18 -0000
Received: from joe by jupiter.planets with local (Exim 3.36 #1 (Debian))
	id 1AdwlI-00024J-00; Tue, 06 Jan 2004 20:21:08 +0100
Date: Tue, 6 Jan 2004 20:21:08 +0100
From: =?iso-8859-1?Q?J=F6?= Fahlke <jorrit@jorrit.de>
To: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Cc: Linux on Mips Mailinglist <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Subject: Re: Assembler error in arch/mips/kernel/entry.S
Message-ID: <20040106192107.GB7342@fsk.uni-heidelberg.de>
Mail-Followup-To: =?iso-8859-1?Q?J=F6?= Fahlke <jorrit@jorrit.de>,
	Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>,
	Linux on Mips Mailinglist <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
References: <20040106163925.GA7342@fsk.uni-heidelberg.de> <20040106181456.GH13721@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TakKZr9L6Hm6aLOc"
Content-Disposition: inline
In-Reply-To: <20040106181456.GH13721@rembrandt.csv.ica.uni-stuttgart.de>
User-Agent: Mutt/1.5.4i
Return-Path: <joe@jorrit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jorrit@jorrit.de
Precedence: bulk
X-list: linux-mips


--TakKZr9L6Hm6aLOc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Am Di,  6. Jan 2004, 19:14:56 +0100 schrieb Thiemo Seufer:
> -       beqz    restore_all
> -       if (in_exception_path)
> -               goto restore_all;
> +       beqz    t1, restore_all
>         li      t0, PREEMPT_ACTIVE

Thanks, that helped a bit, but still I get:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  AS      arch/mips/kernel/entry.o
arch/mips/kernel/entry.S: Assembler messages:
arch/mips/kernel/entry.S:56: Error: absolute expression required `li'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

J=F6.

--=20
oil -- operation iraqi liberation
http://www.mo.tecsamples.de/mahnwache/index.html

--TakKZr9L6Hm6aLOc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+wqj9pw8d07v1OsRAsoAAKCtaeZyi0oqRVp+XyqAKOwwq1KYAgCggu4Y
VJTwZfQe5NoJpH50faPfhcs=
=b+0/
-----END PGP SIGNATURE-----

--TakKZr9L6Hm6aLOc--
