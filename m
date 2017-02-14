Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Feb 2017 10:08:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45152 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23990522AbdBNJIKqT6gD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Feb 2017 10:08:10 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 0358F41F8E96;
        Tue, 14 Feb 2017 10:12:02 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 14 Feb 2017 10:12:02 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 14 Feb 2017 10:12:02 +0000
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9C16965ED1F3D;
        Tue, 14 Feb 2017 09:08:02 +0000 (GMT)
Received: from localhost (192.168.154.110) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 14 Feb
 2017 09:08:04 +0000
Date:   Tue, 14 Feb 2017 09:08:04 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Purna Chandra Mandal <purna.mandal@microchip.com>
CC:     <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Harvey Hunt <harvey.hunt@imgtec.com>,
        Joshua Henderson <digitalpeer@digitalpeer.com>
Subject: Re: [PATCH v2] MIPS: pic32mzda: fix linker error for
 pic32_get_pbclk().
Message-ID: <20170214090804.GO24226@jhogan-linux.le.imgtec.org>
References: <1464859302-26537-1-git-send-email-purna.mandal@microchip.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0lsrIB+s628ok5gC"
Content-Disposition: inline
In-Reply-To: <1464859302-26537-1-git-send-email-purna.mandal@microchip.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56800
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

--0lsrIB+s628ok5gC
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 02, 2016 at 02:51:42PM +0530, Purna Chandra Mandal wrote:
> Early clock API pic32_get_pbclk() is defined in early_clk.c and
> used by time.c and early_console.c. When CONFIG_EARLY_PRINTK isn't
> set, early_clk.c isn't compiled and time.c fails to link.
>=20
> Fix it by compiling early_clk.c always. Also sort files in
> alphabetical order.
>=20
> Cc: Harvey Hunt <harvey.hunt@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: Joshua Henderson <digitalpeer@digitalpeer.com>
>=20
> Reported-by: Harvey Hunt <harvey.hunt@imgtec.com>
> Signed-off-by: Purna Chandra Mandal <purna.mandal@microchip.com>
> Reviewed-by: Harvey Hunt <harvey.hunt@imgtec.com>

Applied

Thanks
James

>=20
> ---
>=20
> Changes in v2:
> - update commit message
>=20
>  arch/mips/pic32/pic32mzda/Makefile | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/mips/pic32/pic32mzda/Makefile b/arch/mips/pic32/pic32mz=
da/Makefile
> index 4a4c272..c286496 100644
> --- a/arch/mips/pic32/pic32mzda/Makefile
> +++ b/arch/mips/pic32/pic32mzda/Makefile
> @@ -2,8 +2,7 @@
>  # Joshua Henderson, <joshua.henderson@microchip.com>
>  # Copyright (C) 2015 Microchip Technology, Inc.  All rights reserved.
>  #
> -obj-y			:=3D init.o time.o config.o
> +obj-y			:=3D config.o early_clk.o init.o time.o
> =20
>  obj-$(CONFIG_EARLY_PRINTK)	+=3D early_console.o      \
> -				   early_pin.o		\
> -				   early_clk.o
> +				   early_pin.o
> --=20
> 1.8.3.1
>=20
>=20

--0lsrIB+s628ok5gC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYosjtAAoJEGwLaZPeOHZ6VGsP/3kU+YWzbLWUM4+gC8DeHRy2
p538StI6XrDv+cvQP0et9dKMi1hMXk5Xx1gSZCn8yLYSLPPvLnKeJRBlwIjas2rh
SrZ2q0Ob5NPrfxZ77/m/CcqtMyorWDOlAUAHCP7mY+Cq/uDKqiPqMEER8ccNQs8n
931SbCGSRb6LOzshZlsRN6vRb1oirQqWKIZoyaoacaOat7/S1ig56ynv3rhnZODa
ZpzHrBS0CBcrPZUUw6qLYEZ2DWRwrMrwRNn7IxuVjZ1sQQN/kdDbeJO03VPYjxrq
pNBp62y6ZfN6lKqIq7Q1dPYm7oqWPycurrzt8Ua5UmDULUt2YHLsd54+earSo7wC
btyLyCPkTe/duoZd2USQMt2APUej3NiYBnZbrgvln7sJeCKLxbxd/9HOL60Bcs3N
0DCTPo+Ycg97JNUvqu9l9c9+XdOrMn8mY6FHmTJyhjsLhS9KLUpDfevtFxJi7OYu
OZ4hOyCTcqW0fPuA5D46sJ5LWaZ9rhMQBTuGORC16ca28RRHZXkr+edan/eUkgh6
l+h7kmeXCe92WrPsnzd4SZ5QFhOuHhOdNxLp4PEzA3XFS/+TgcRjY+B89Gvawcgm
cgZLizeTEmHeTY0MceJNCExNaN0UtcnSIzN5UYgHS8d+Yn6hL0WUbD37PEKKq+fL
PsChPiJ+IKKtpQ2jCyqK
=cIk7
-----END PGP SIGNATURE-----

--0lsrIB+s628ok5gC--
