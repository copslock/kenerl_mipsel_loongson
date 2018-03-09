Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 14:56:12 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994803AbeCIN4BKuTcM (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2018 14:56:01 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D384120685;
        Fri,  9 Mar 2018 13:55:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D384120685
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 13:55:49 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Paul Burton <paul.burton@mips.com>,
        Dengcheng Zhu <dengcheng.zhu@mips.com>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v3] MIPS: pm-cps: Block system suspend when a JTAG probe
 is present
Message-ID: <20180309135548.GF24558@saruman>
References: <1519120696-30658-1-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="NQTVMVnDVuULnIzU"
Content-Disposition: inline
In-Reply-To: <1519120696-30658-1-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62864
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


--NQTVMVnDVuULnIzU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2018 at 09:58:16AM +0000, Matt Redfearn wrote:
> If a JTAG probe is connected to a MIPS cluster, then the CPC detects it
> and latches the CPC.STAT_CONF.EJTAG_PROBE bit to 1. While set,
> attempting to send a power-down command to a core will be blocked, and
> the CPC will instead send the core to clock-off state. This can
> interfere with systems fully entering a low power state where all
> cores, CM, GIC, etc are powered down.
>=20
> Detect that a JTAG probe is / has been connected to the cluster and
> block the suspend attempt.
>=20
> Attempting to suspend the system while a JTAG probe is connected now
> yields:
>  # echo mem > /sys/power/state
>  [   11.654000] PM: Syncing filesystems ... done.
>  [   11.658000] JTAG probe is connected - abort suspend
>  -sh: echo: write error: Operation not permitted
>  #
>=20
> To restore suspend, the JTAG probe should be disconnected or put into
> quiescent state. Platform code can then clear the
> CPC.STAT_CONF.EJTAG_PROBE bit.
>=20
> Reported-by: Ed Blake <ed.blake@sondrel.com>
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>

Thanks, applied for 4.17.

Cheers
James

--NQTVMVnDVuULnIzU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqikmQACgkQbAtpk944
dnoj5w//b2/C5942IMlU/7MwmyAJO/OGYb1Tl1zaom2GiEfWU8LtKMtUJWY95B6C
f0VWRrpSqB1yDi6Ipg89YtH0XuUG7P1VZ9OmWmwfnHI8NAF28l6Ypd6N2sDbHl/r
8yikABtHHRPgwcpBTGDD9ottgIrcgy6UaNatUTVY8n4cldIDOrDTxUk3Jd9/BRRJ
4b/SsLfewVMQb4oibuX134O5WxyWWLP/wfiLHs54dU61qOl4KvSmq8o42XKR3c2v
ZEiXjxHVU6FBP/+uTjXwF2uVXS58RUAm9BZAJhcg3RAPqbkq9v4ycQ6WgOOHw9Re
eutnwqjDoAEiLJX1vZ8v1MPyUZo4P59DBL9pSitqKUUpAS/ihNIIob7xXOT9I+4F
yYr4P7NcQiSGp8cg/6nsJY8DGh91dSSmclvso0ov32XYfhMfvjV50NdaSjbxyN4o
O6pkb05JeLGm3lLtcUAYBlfhql1TiO7lGnmjXNI4IU9+fTHZFA251qa84cXKU88U
hO/aJpJVy2qyoOprphNXHBCRfwdA2IrCoI0vCAn2spi+s3BCOS08OUC8o1UaDHcR
Q22RYCYaUVsABnvXGnGvs/g6lvFSMaLwH7bIv3t1OGR4hDhH4Tt4E78tFn36zceq
KhI2Ka2aXPSJ0jiEgtRV+XQPT6zlWPfYGWkSDlH6x2ck5b/xl5Q=
=bC1I
-----END PGP SIGNATURE-----

--NQTVMVnDVuULnIzU--
