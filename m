Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 01:00:21 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:45230 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992866AbeAXAALuBIR0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 01:00:11 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A0A6721715;
        Tue, 23 Jan 2018 23:59:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A0A6721715
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 23 Jan 2018 23:59:35 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Serge Semin <fancer.lancer@gmail.com>
Cc:     ralf@linux-mips.org, miodrag.dinic@mips.com, goran.ferenc@mips.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        paul.burton@mips.com, alex.belits@cavium.com,
        Steven.Hill@cavium.com, alexander.sverdlin@nokia.com,
        matt.redfearn@mips.com, kumba@gentoo.org,
        marcin.nowakowski@mips.com, Peter.Wotton@mips.com,
        Sergey.Semin@t-platforms.ru, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 14/14] MIPS: memblock: Deactivate bootmem allocator
Message-ID: <20180123235934.GA5446@saruman>
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-15-fancer.lancer@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="TB36FDmn/VVEgNH/"
Content-Disposition: inline
In-Reply-To: <20180117222312.14763-15-fancer.lancer@gmail.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62290
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


--TB36FDmn/VVEgNH/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 18, 2018 at 01:23:12AM +0300, Serge Semin wrote:
> Memblock allocator can be successfully used from now for early
> memory management
>=20
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

Am I correct that intermediate commits in this patchset (i.e. bisection)
may not work correctly, since bootmem will have been stripped out but
NO_BOOTMEM=3Dn and memblock may not be properly operational yet?

If so, is there a way to switch without breaking bisection that doesn't
involve squashing most of the series into a single atomic commit?

Cheers
James

> ---
>  arch/mips/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 725b5ece7..a6c4fb6b6 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -4,7 +4,6 @@ config MIPS
>  	default y
>  	select ARCH_BINFMT_ELF_STATE
>  	select ARCH_CLOCKSOURCE_DATA
> -	select ARCH_DISCARD_MEMBLOCK
>  	select ARCH_HAS_ELF_RANDOMIZE
>  	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
>  	select ARCH_MIGHT_HAVE_PC_PARPORT
> @@ -57,6 +57,7 @@ config MIPS
>  	select HAVE_IRQ_TIME_ACCOUNTING
>  	select HAVE_KPROBES
>  	select HAVE_KRETPROBES
> +	select NO_BOOTMEM
>  	select HAVE_MEMBLOCK
>  	select HAVE_MEMBLOCK_NODE_MAP
>  	select HAVE_MOD_ARCH_SPECIFIC
> --=20
> 2.12.0
>=20

--TB36FDmn/VVEgNH/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpnzGYACgkQbAtpk944
dnr+oQ/9F5E9TnPGQ9SqXnOrWYvBM0KWGAig2x6tF4EVsWAdAanOVamebvKQJ0Rb
SyIOARAYRoG4+xRg5pypfj4QKgpKpwjOm9s5qQHRyC16D4LA5RAQ06EtDl0Icwpq
6ccELDsrS7kj2rC4518vSMs1WDUDLIxvvDgQo9xOsDFtsSftu+luE07NG0PacbgE
J4e46YxioK3vcyJ78z5nh0NiVBUub0UrNhGo2Q2kgg/en1Je3eXMAIcJ2ft2oDEv
PEiRUFcihSNezkoxIAJx1T5Jw5rZGewsn+r8rmHa2K6ErlbnZN2+5Cta5c8TcExV
3R/TjU4QlIUqywfGI+ObdywmCerTlZPOM9zlel6OaPnXJlMU4KyfysOftFKdqkY0
Wr8ZIsWApy1CNsja36ps0gqxpd9mAOHKiw13ts08a6LcnPtY8FJhkBP25A72EM7X
hgRjcRuylraOeGNCanYDTfYXa8h8CDcH4QYSSl9kvj2ooAC2hCYTxq3c/FO7zBqZ
6VIgKHhyqeNnvkgNuCN5vTQcU+cptuAhgMAJp1B3Xjx7KRRabvbluaIzjdnLqp/K
fofFLRgr5/BdNSA4Pk7WlDAgz9hcIFLKzf7jHvipdmmriOP0YjtAnrdDPLVLGr5C
TrdL0ZwCmoxB7pTjliTeP/PLdNXSV0gkHvvdiS0d9M2c6RTwR4s=
=cwSt
-----END PGP SIGNATURE-----

--TB36FDmn/VVEgNH/--
