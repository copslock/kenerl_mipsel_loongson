Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jun 2008 10:43:11 +0100 (BST)
Received: from mail2.lzu.edu.cn ([202.201.0.158]:25322 "HELO lzu.edu.cn")
	by ftp.linux-mips.org with SMTP id S28578173AbYFLJnI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 12 Jun 2008 10:43:08 +0100
Received: from [192.168.2.104] (unknown [202.201.14.140])
	by mail1.lzu.edu.cn (Coremail) with SMTP id AQAAf7Dr8wuX51BIDqAzAA==.4517S2;
	Thu, 12 Jun 2008 17:08:39 +0800 (CST)
Subject: irq hande default_startup qestion
From:	"Wang, Baojun" <wangbj@lzu.edu.cn>
Reply-To: wangbj@dslab.lzu.edu.cn
To:	linux-mips@linux-mips.org
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-EmmDG8reDwVQPiA2VVlj"
Organization: DSLab, Lanzhou University
Date:	Thu, 12 Jun 2008 17:42:54 +0800
Message-Id: <1213263774.31495.9.camel@localhost.dslab>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
X-Coremail-Antispam: 1U3129KBjvJXoW7Gw1xAw17uFykJw1DJr4fKrg_yoW8JF1DpF
	4rGwnYvFW3Xay0grWUCw40kr1ftwsxJry8Ar1rK343Zayq93yvv3Wvqrs7Ar1UGr9Fqr47
	AF4SvFWIva13A3DanT9S1TB71UUUUUUv73VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjLIb7
	Iv0xC_Jr1l5I8CrVACY4xI64kE6c02F40Ex7xfM7kC6x804xWl14x267AKxVWUJVW8JwAF
	xVCF77xC6IxKo4kEV4yl1I0EscIYIxCEI4klw4CSwwAFIxvE14AKwVWUJVWUGwASzI0EjI
	02j7AqF2xKxwAq048E620vw7xCY7CE4x8GYI0EYx1lYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4l
	Yx0Ex4A2jsIE14v26r1j6r4UMx02cVAKzwCY0x0Ix7I2Y4AK64vIr41l4x8a64kEw24lx4
	CE17CEb7AF67AKxVWUJVWUXjIFyTuYvjxUYmiiDUUUU
Return-Path: <wangbj@lzu.edu.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19496
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangbj@lzu.edu.cn
Precedence: bulk
X-list: linux-mips


--=-EmmDG8reDwVQPiA2VVlj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

hi, list:

I have a question about default_startup() in kernel/irq/chip.c:

/*
 * default startup function
 */
static unsigned int default_startup(unsigned int irq)
{
        irq_desc[irq].chip->enable(irq);

        return 0;
}

By default, default_startup will call irq_chip->enable(), but some
drivers like i8259A, in arch/mips/kenrel/i8259.c:

static struct irq_chip i8259A_chip =3D {
        .name           =3D "XT-PIC",
        .mask           =3D disable_8259A_irq,
        .disable        =3D disable_8259A_irq,
        .unmask         =3D enable_8259A_irq,
        .mask_ack       =3D mask_and_ack_8259A,
#ifdef CONFIG_MIPS_MT_SMTC_IRQAFF
        .set_affinity   =3D plat_set_irq_affinity,
#endif /* CONFIG_MIPS_MT_SMTC_IRQAFF */
};

which don't initialize irq_chip->enable, in some (probably rare) case
when irq_chip->startup() get called, it will cause NULL pointer
reference. is it OK to change i8259A_chip (add .enable =3D
xxx_unmask, .disable =3D xxx_mask) or just change default_startup()
function? (irq_desc[irq].chip->unmask() or so?)

  Regards,
Wang

--=20
Wang, Baojun                                                Lanzhou Univers=
ity
Distributed & Embedded System Lab                      http://dslab.lzu.edu=
.cn
School of Information Science and Engeneering          wangbj@dslab.lzu.edu=
.cn
Tianshui South Road 222. Lanzhou 730000                             .P.R.Ch=
ina
Tel: +86-931-8912025                                      Fax: +86-931-8912=
022


--=-EmmDG8reDwVQPiA2VVlj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description:
	=?gb2312?Q?=D5=E2=CA=C7=D0=C5=BC=FE=B5=C4=CA=FD=D7=D6=C7=A9?=
	=?gb2312?Q?=C3=FB=B2=BF=B7=D6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhQ754ACgkQIuIOr7tpgg09kwCfTgreFvQ9DSZEsDpJ5tcZK3tx
X14AnRc9fzTdjAsSx5OMi7Bpm2yzB69w
=CXtX
-----END PGP SIGNATURE-----

--=-EmmDG8reDwVQPiA2VVlj--
