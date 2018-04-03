Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Apr 2018 10:43:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:55468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993124AbeDCImyer0FO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 3 Apr 2018 10:42:54 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0BC2E214EE;
        Tue,  3 Apr 2018 08:42:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BC2E214EE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 3 Apr 2018 09:42:43 +0100
From:   James Hogan <jhogan@kernel.org>
To:     r@hev.cc
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Fix ejtag handler on SMP
Message-ID: <20180403084242.GA31222@saruman>
References: <20180330090515.11399-1-r@hev.cc>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
In-Reply-To: <20180330090515.11399-1-r@hev.cc>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63383
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


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 30, 2018 at 05:05:15PM +0800, r@hev.cc wrote:
> From: Heiher <r@hev.cc>

Please can you add a proper commit description, explaining the problem
and what your patch does to fix it.

>=20
> Signed-off-by: Heiher <r@hev.cc>
> ---
>  arch/mips/kernel/genex.S | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>=20
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 37b9383eacd3..9e0857fbe281 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -354,6 +354,17 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	sll	k0, k0, 30	# Check for SDBBP.
>  	bgez	k0, ejtag_return
> =20
> +#ifdef CONFIG_SMP
> +	PTR_LA	k0, ejtag_debug_buffer
> +1:	sync

Is the sync necessary? Or is that one of those platform specific
workarounds?

> +	ll	k0, LONGSIZE(k0)
> +	bnez	k0, 1b
> +	PTR_LA	k0, ejtag_debug_buffer
> +	sc	k0, LONGSIZE(k0)
> +	beqz	k0, 1b
> +	sync
> +#endif
> +
>  	PTR_LA	k0, ejtag_debug_buffer
>  	LONG_S	k1, 0(k0)
>  	SAVE_ALL
> @@ -363,6 +374,11 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	PTR_LA	k0, ejtag_debug_buffer
>  	LONG_L	k1, 0(k0)
> =20
> +#ifdef CONFIG_SMP
> +	sw	zero, LONGSIZE(k0)
> +	sync

Same question. Its about to deret anyway which should cover that I
think?

> +#endif
> +
>  ejtag_return:
>  	MFC0	k0, CP0_DESAVE

Not specific to your patch, but I wonder whether there should be a
back_to_back_c0_hazard (ehb on r2+) somewhere before this MFC0.

Cheers
James

--+QahgC5+KEYLbs62
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrDPnwACgkQbAtpk944
dnpNqxAArsXbeG5i7vsGe9gTtkq2vqRuSdUwIqDvXywUMMjej7NIvHl9nPOK5aap
b4expPctf+L1gDr+TwGQYRbGGGu2dkQPaF9fAJJY3RKR1VlJxLKlefnepnOqrPTT
0oaIzE+xoJ+DHMeWCykGHB5EWQBqdpzq3415Zt8yLNlgjtoIVyxxWt6VQyuVmawc
pjL/Gf0ciC8P5UmaT+QEzcRmjgWIK/4ICOX0t3z4y1izE4am05Gd2ojRm7YohhGr
quSPqeMnzfqCt0/snJF4un+p/dr9qu7G222F9MtDy6LxUbv4zCyvA+MC67ro1QxX
cCBpig8EQzwSrQ3+nlj4TM2bpwxI3GgDqpe8y83wQR6/PyNpD7RCy4G1c8bsnGBG
JORfL0mh8lvHWrNHp5ds07GHarvoj41YdoaX+6BXCb5ZoHyz6oAHWv0YT3lCdi8c
xRGOJThNftSXwwOOHnUPVmuCnbXoM4xjp3LNd/nV/PoJw5U+rds3zvWsuRLZ18B9
rYu7dPgjP2rBUoDSok7kZ33+iZuY0T8T/nAJwgFgYHmtsXFs2+kDCoC/QJ47J3Hr
Wl8oI5mu+mlK6JR6IJH4GC40yGnYPjDbYk4QOxq2nTbxlXywYYR33cwaouxdbe9j
ZQvkU1/qH020NmNiMye3jzZ6jqOIyFW4TQAN6xQ7N5vRoiDO/Zk=
=yGHj
-----END PGP SIGNATURE-----

--+QahgC5+KEYLbs62--
