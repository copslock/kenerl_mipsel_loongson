Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jan 2004 16:39:37 +0000 (GMT)
Received: from ns1.xeneris.net ([IPv6:::ffff:195.49.173.97]:50404 "HELO
	superfix.xeneris.net") by linux-mips.org with SMTP
	id <S8225198AbUAFQjd>; Tue, 6 Jan 2004 16:39:33 +0000
Received: (qmail 9609 invoked by uid 64014); 6 Jan 2004 16:39:35 -0000
Received: from joe@jorrit.de by superfix by uid 64011 with qmail-scanner-1.15 
 (clamscan: 0.54. spamassassin: 2.50-cvs.  Clear:. 
 Processed in 0.525807 secs); 06 Jan 2004 16:39:35 -0000
Received: from localhost (HELO jupiter.planets) (127.0.0.1)
  by localhost with SMTP; 6 Jan 2004 16:39:35 -0000
Received: from joe by jupiter.planets with local (Exim 3.36 #1 (Debian))
	id 1AduEn-0001ur-00; Tue, 06 Jan 2004 17:39:25 +0100
Date: Tue, 6 Jan 2004 17:39:25 +0100
From: =?iso-8859-1?Q?J=F6?= Fahlke <jorrit@jorrit.de>
To: Linux on Mips Mailinglist <linux-mips@linux-mips.org>
Subject: Assembler error in arch/mips/kernel/entry.S
Message-ID: <20040106163925.GA7342@fsk.uni-heidelberg.de>
Mail-Followup-To: =?iso-8859-1?Q?J=F6?= Fahlke <jorrit@jorrit.de>,
	Linux on Mips Mailinglist <linux-mips@linux-mips.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
User-Agent: Mutt/1.5.4i
Return-Path: <joe@jorrit.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jorrit@jorrit.de
Precedence: bulk
X-list: linux-mips


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[Please Cc me on replys]

Hi!

Trying to compile current cvs with CONFIG_PREEMT I get:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
  AS      arch/mips/kernel/entry.o
arch/mips/kernel/entry.S: Assembler messages:
arch/mips/kernel/entry.S:55: Error: illegal operands `beqz restore_all'
arch/mips/kernel/entry.S:56: Error: unrecognized opcode `if (in_exception_p=
ath)'
arch/mips/kernel/entry.S:57: Error: unrecognized opcode `goto restore_all'
arch/mips/kernel/entry.S:58: Error: absolute expression required `li'
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

The corresponding code looks like this:

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
        beqz    restore_all
        if (in_exception_path)
                goto restore_all;
        li      t0, PREEMPT_ACTIVE
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Can someone please fix this?  My very limitet assembler knowledge
gives me an idea whats wrong, but I don't know how to fix it.

Meanwhile I'll try compiling without CONFIG_PREEMT.

Thanks,
J=C3=B6.

--=20
Interpunktion, Orthographie und Grammatik der Email ist frei erfunden.
Eine =EF=BF=BDbereinstimmung mit aktuellen oder ehemaligen Regeln w=C3=A4re=
 rein
zuf=C3=A4llig und ist nicht beabsichtigt.

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQE/+uS89pw8d07v1OsRAmEdAJ0YBbOrGQoM82MlrHHUWGENRM24cQCfa7ju
R0KYVrEHuPzN2S7Uew2m/aM=
=iERP
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
