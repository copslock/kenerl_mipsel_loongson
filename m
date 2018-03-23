Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Mar 2018 22:08:32 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:46478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990757AbeCWVIZsoe01 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Mar 2018 22:08:25 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 005312168D;
        Fri, 23 Mar 2018 21:08:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 005312168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Mar 2018 21:08:12 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Huacai Chen <chenhc@lemote.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org, Russell King <linux@arm.linux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH V3] ZBOOT: fix stack protector in compressed boot phase
Message-ID: <20180323210811.GD11796@saruman>
References: <1521186916-13745-1-git-send-email-chenhc@lemote.com>
 <20180322222107.GJ13126@saruman>
 <1521777055.1510.9.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Content-Disposition: inline
In-Reply-To: <1521777055.1510.9.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63193
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jhogan@kernel.org
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 23, 2018 at 11:50:55AM +0800, Jiaxun Yang wrote:
> =E5=9C=A8 2018-03-22=E5=9B=9B=E7=9A=84 22:21 +0000=EF=BC=8CJames Hogan=E5=
=86=99=E9=81=93=EF=BC=9A
> > Also I think it worth mentioning in the commit message the MIPS
> > configuration you hit this with, presumably a Loongson one? For me
> > decompress_kernel() gets a stack guard on loongson3_defconfig, but
> > not
> > malta_defconfig or malta_defconfig + 64-bit. I presume its sensitive
> > to
> > the compiler inlining stuff into decompress_kernel() or something
> > such
> > that it suddenly qualifies for a stack guard.
>=20
> Have you tested with CONFIG_CC_STACKPROTECTOR_STRONG=3Dy ?

Yes. for malta_defconfig I could only reproduce by adding an array to
decompress_kernel() so that it would get the guard.

Cheers
James

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq1bLsACgkQbAtpk944
dnqRoRAAgQ9jkBNRCrcD5HNMyD7XNnyB4QBm9KgvsYASAFF2b9bzC1qaFsv7ogMe
+yUEgTbXYGvVyBKMRr/D0d0ndlTSPCwVJHwtwgBVp+PizfWmBTF6j1IvbQ1YnQfH
vYfFm72xW0L0awtmXV2tbo/Y/AQopzAaWL09sFhrqSt9tWRmPDnlx0r+DfPp3wVP
I5mA+BftMiVSjqOiwU5QAmj2JVFRpkfKCAftdjG6UFQE0l7aw+4EFHpYiI+8Ai6A
XiFyf+GQu6Bh0GK+mdTSa0pb+UMEhf1Q4Y5BlJca6zThYTdlZKJoAwIPjHh+Pn4M
hsKYqKczPJd0hlDSFG5/LC7tp5ySoRGTP/kFQoodjjOf774FkdTTY73/8JDcHc7n
Jb8UMrMiwWLOPwyqjS9SD2sBcnHVAUZvGhIS5pJHzEiAIKNVVeXpjWYTTwQ2nKiN
r240w2CjnH/l8C4iwUChu2xvoXV/3EYJLibTIaLbAyGu0TTeW8nGQR4m3wRIL3ig
Dg9C3tgQY4NJMaTXWRyJGEf58cezFSkDvHRAmNqO6r4IkXjJ4VXlqCvUj0p+KThw
2oKS6aDj7ZU25DrTAPmb24SCUS9A61Ktwo463YznQdv2WUppc++dRUoBnJ5j89iP
o4ngC6M2GKsRrL2SRphyLz4Pyi+alDWvXm+tQnKD7Uy940M8SF0=
=0EHR
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
