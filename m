Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Jun 2008 12:15:40 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:42976 "EHLO
	mail.dslab.lzu.edu.cn") by ftp.linux-mips.org with ESMTP
	id S20022083AbYFELPh (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 5 Jun 2008 12:15:37 +0100
Received: from [192.168.2.104] (unknown [202.201.14.140])
	(using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.dslab.lzu.edu.cn (Postfix) with ESMTP id 739CB84A;
	Thu,  5 Jun 2008 19:15:29 +0800 (CST)
Subject: Re: understanding head.S
From:	"Wang, Baojun" <wangbj@dslab.lzu.edu.cn>
Reply-To: wangbj@dslab.lzu.edu.cn
To:	Chetan Nanda <chetannanda@gmail.com>, linux-mips@linux-mips.org
In-Reply-To: <7f245da80806050302m6b449e6m1f84dc7ef7efff46@mail.gmail.com>
References: <7f245da80806050302m6b449e6m1f84dc7ef7efff46@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-csPKN7XTP6IfPmq+Hyyb"
Organization: DSLab, Lanzhou University
Date:	Thu, 05 Jun 2008 19:15:24 +0800
Message-Id: <1212664525.24330.22.camel@localhost.dslab>
Mime-Version: 1.0
X-Mailer: Evolution 2.22.2 
Return-Path: <wangbj@dslab.lzu.edu.cn>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19403
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wangbj@dslab.lzu.edu.cn
Precedence: bulk
X-list: linux-mips


--=-csPKN7XTP6IfPmq+Hyyb
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

=E5=9C=A8 2008-06-05=E5=9B=9B=E7=9A=84 15:32 +0530=EF=BC=8CChetan Nanda=E5=
=86=99=E9=81=93=EF=BC=9A
> Hi All,
> I was reading the boot code for MIPS.
> in head.S file before jumping to 'start_kernel' it calculate the stack
> pointer address as follow:
>=20
> "
> 	PTR_LA		$28, init_thread_union
> 	PTR_ADDIU	sp, $28, _THREAD_SIZE - 32
make sp point to the stack top so that we can allocate stack space
later, -32 is a reserved area for local variable, saved GPR, arguments
(function stack frame).. due to the abi
> 	set_saved_sp	sp, t0, t1
set_saved_sp is defined (as a assembler macro) in
include/asm-mips/stackframe.h (if you're using vim, I think it will be
easy to use vim with cscope..)
> 	PTR_SUBU	sp, 4 * SZREG		# init stack pointer
SZREG is defined to the general purpose register size, it is 32bit in
MIPS32 and 64bit in MIPS64, so the last line allocates 16/32 bytes to
build a stack frame.. You could refer to the MIPS ABI if you need
further information (the kernel don't follow the standard ABI all the
time though..)
>=20
> Can anyone please explains me this 4 lines of code?
> Why ' _THREAD_SIZE - 32' is added in 'sp' ?
> What 'set_saved_sp' will do ?
> and then why we subtract '4 * SZREG' from 'sp' ?
>=20
> Please hep me to understand this code better.
>=20
> Thanks,
> Chetan Nanda
>=20
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


--=-csPKN7XTP6IfPmq+Hyyb
Content-Type: application/pgp-signature; name=signature.asc
Content-Description:
	=?gb2312?Q?=D5=E2=CA=C7=D0=C5=BC=FE=B5=C4=CA=FD=D7=D6=C7=A9?=
	=?gb2312?Q?=C3=FB=B2=BF=B7=D6?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkhHyswACgkQIuIOr7tpgg3Y8ACfbwWAK3ZVgIuY7nBSYwTqWioE
0PkAoKkWiav4TVeEgmAIn8+s40/FIJi/
=ywvl
-----END PGP SIGNATURE-----

--=-csPKN7XTP6IfPmq+Hyyb--
