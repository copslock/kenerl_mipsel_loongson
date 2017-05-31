Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 May 2017 18:48:10 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47990 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23993179AbdEaQsBCtelF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 May 2017 18:48:01 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 49E7141F8DA5;
        Wed, 31 May 2017 18:56:42 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Wed, 31 May 2017 18:56:42 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Wed, 31 May 2017 18:56:42 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 781772D1279B6;
        Wed, 31 May 2017 17:47:51 +0100 (IST)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Wed, 31 May
 2017 17:47:55 +0100
Date:   Wed, 31 May 2017 17:47:54 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     David Daney <ddaney.cavm@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
Subject: Re: [PATCH 4/4] MIPS: Branch straight to ll in mips_atomic_set()
Message-ID: <20170531164754.GM6973@jhogan-linux.le.imgtec.org>
References: <cover.5633df325dbcbc41dbf9cc60df22b38f7812e73a.1496240182.git-series.james.hogan@imgtec.com>
 <c17c30b035caec45c1de97f4d069ab31fec2067e.1496240182.git-series.james.hogan@imgtec.com>
 <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="GoZzJvFfKjxI3RhA"
Content-Disposition: inline
In-Reply-To: <580e1148-aaf9-895c-09ec-8b38772a9154@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

--GoZzJvFfKjxI3RhA
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi David,

On Wed, May 31, 2017 at 09:28:36AM -0700, David Daney wrote:
> On 05/31/2017 08:19 AM, James Hogan wrote:
> > Adjust the atomic loop in the MIPS_ATOMIC_SET operation of the sysmips
> > system call to branch straight back to the linked load rather than
> > jumping via a different subsection (whose purpose remains a mystery to
> > me).
>=20
> The subsection keeps the code for the (hopefully) cold path out of line=
=20
> which should result in a smaller cache footprint in the hot path.

Hmm, yes that would make sense if it did something useful there, but it
just immediately jumps back to the ll.

Cheers
James

>=20
>=20
> >=20
> > Signed-off-by: James Hogan <james.hogan@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: linux-mips@linux-mips.org
> > ---
> >   arch/mips/kernel/syscall.c | 6 +-----
> >   1 file changed, 1 insertion(+), 5 deletions(-)
> >=20
> > diff --git a/arch/mips/kernel/syscall.c b/arch/mips/kernel/syscall.c
> > index ca54ac40252b..6c6bf43d681b 100644
> > --- a/arch/mips/kernel/syscall.c
> > +++ b/arch/mips/kernel/syscall.c
> > @@ -137,13 +137,9 @@ static inline int mips_atomic_set(unsigned long ad=
dr, unsigned long new)
> >   		"	move	%[tmp], %[new]				\n"
> >   		"2:							\n"
> >   		user_sc("%[tmp]", "(%[addr])")
> > -		"	beqz	%[tmp], 4f				\n"
> > +		"	beqz	%[tmp], 1b				\n"
> >   		"3:							\n"
> >   		"	.insn						\n"
> > -		"	.subsection 2					\n"
> > -		"4:	b	1b					\n"
> > -		"	.previous					\n"
> > -		"							\n"
> >   		"	.section .fixup,\"ax\"				\n"
> >   		"5:	li	%[err], %[efault]			\n"
> >   		"	j	3b					\n"
> >=20
>=20

--GoZzJvFfKjxI3RhA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlku87EACgkQbAtpk944
dnpHfxAAsahMyzaM5e2kXLnKqP1rdgQv5nlhqqsD0WzpfTcCbNpkIFLF6BjC90TQ
/dTVe3DXhhn5k51BHA4w4yhBp0gaulFm6yohr00xawceKGUjpZhpTANIWk8dhGHS
DLfbvUMPpxFwpisOSVy47QMHpINdxJCD/gT3MyYS6GIY/xkhDSfspPW/nUE/4gZJ
5nVrGjKoCZ4YVd9zkHHif0uSJzGiOe5UKig0L2wFprt0NUgipyqd08PUGTEnKJQR
7/KFpEP1+KsP809kivV2Nu5bqzLl4h1WEzYrsb0OuAsrbpP1grCKqcrf+o824xH8
ZCcCmwNubTPzX1q7zLt3JHzMsrwztoubuFZDtBGaWBz6jwXUK7gR85TLO8x2k27k
5ykPbqIUzx9WT/jyn4tqoigVsvD47BqI3ARGENmlqP2MONoslJXj12oM8tHaG0bd
ArrD7X5Lef1KHtHYXFfjtlMaJK1ZHI0ZNAMqazgSL87BNceJ4Y+BiwQDk7FRkcwx
8CitxQ0OJdlPOcEM07P54Ps+8ZPEQn5zY8wCo3NeBH4o0WWi/7LQcZbwH8DD/XY2
vBvMX6f4JfzjG/ezRGfLIEAnceDllN3xeg2s70eqpUnQIRP+ZSeFqXnpi81Q88vv
B3qJr7qyHuOTVACnilKZw/1t7K4s2RmhMoAg8AfUn8ya4c3x54s=
=HJl6
-----END PGP SIGNATURE-----

--GoZzJvFfKjxI3RhA--
