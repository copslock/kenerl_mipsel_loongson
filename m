Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Apr 2018 23:46:59 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:39604 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994661AbeDRVqvHdQ47 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 18 Apr 2018 23:46:51 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C48B32175C;
        Wed, 18 Apr 2018 21:46:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C48B32175C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 18 Apr 2018 22:46:38 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, Namhyung Kim <namhyung@kernel.org>,
        "Maciej W. Rozycki" <macro@mips.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v2 1/6] MIPS: perf: More robustly probe for the presence
 of per-tc counters
Message-ID: <20180418214637.GB16439@saruman>
References: <1523525786-29153-1-git-send-email-matt.redfearn@mips.com>
 <1523525786-29153-2-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lEGEL1/lMxI0MVQ2"
Content-Disposition: inline
In-Reply-To: <1523525786-29153-2-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63600
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


--lEGEL1/lMxI0MVQ2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 12, 2018 at 10:36:21AM +0100, Matt Redfearn wrote:
> Processors implementing the MIPS MT ASE may have performance counters
> implemented per core or per TC. Processors implemented by MIPS
> Technologies signify presence per TC through a bit in the implementation
> specific Config7 register. Currently the code which probes for their
> presence blindly reads a magic number corresponding to this bit, despite
> it potentially having a different meaning in the CPU implementation.
>=20
> The test of Config7.PTC was previously enabled when CONFIG_BMIPS5000 was
> enabled. However, according to [florian], the BMIPS5000 manual does not
> define this bit, so we can assume it is 0 and the feature is not
> supported.
>=20
> Introduce probe_mipsmt_pertccounters() to probe for the presence of per
> TC counters. This detects the ases implemented in the CPU, and reads any
> implementation specific bit flagging their presence. In the case of MIPS
> implementations, this bit is Config7.PTC. A definition of this bit is
> added in mipsregs.h for MIPS Technologies. No other implementations
> support this feature.
>=20
> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
> ---
>=20
> Changes in v2: None
>=20
>  arch/mips/include/asm/mipsregs.h     |  5 +++++
>  arch/mips/kernel/perf_event_mipsxx.c | 29 ++++++++++++++++++++++++++++-
>  2 files changed, 33 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mip=
sregs.h
> index 858752dac337..a4baaaa02bc8 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -684,6 +684,11 @@
>  #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
>  #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
> =20
> +/* Config7 Bits specific to MIPS Technologies. */
> +
> +/* Performance counters implemented Per TC */
> +#define MTI_CONF7_PTC		(_ULCAST_(1) << 19)
> +
>  /* WatchLo* register definitions */
>  #define MIPS_WATCHLO_IRW	(_ULCAST_(0x7) << 0)
> =20
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 6668f67a61c3..f3ec4a36921d 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -1708,6 +1708,33 @@ static const struct mips_perf_event *xlp_pmu_map_r=
aw_event(u64 config)
>  	return &raw_event;
>  }
> =20
> +#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
> +/*
> + * The MIPS MT ASE specifies that performance counters may be implemented
> + * per core or per TC. If implemented per TC then all Linux CPUs have th=
eir
> + * own unique counters. If implemented per core, then VPEs in the core m=
ust
> + * treat the counters as a shared resource.
> + * Probe for the presence of per-TC counters
> + */
> +static int probe_mipsmt_pertccounters(void)
> +{
> +	struct cpuinfo_mips *c =3D &current_cpu_data;
> +
> +	/* Non-MT cores by definition cannot implement per-TC counters */
> +	if (!cpu_has_mipsmt)
> +		return 0;
> +
> +	switch (c->processor_id & PRID_COMP_MASK) {
> +	case PRID_COMP_MIPS:
> +		/* MTI implementations use CONFIG7.PTC to signify presence */
> +		return read_c0_config7() & MTI_CONF7_PTC;
> +	default:
> +		break;
> +	}
> +	return 0;
> +}
> +#endif /* CONFIG_MIPS_PERF_SHARED_TC_COUNTERS */
> +
>  static int __init
>  init_hw_perf_events(void)
>  {
> @@ -1723,7 +1750,7 @@ init_hw_perf_events(void)
>  	}
> =20
>  #ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS
> -	cpu_has_mipsmt_pertccounters =3D read_c0_config7() & (1<<19);
> +	cpu_has_mipsmt_pertccounters =3D probe_mipsmt_pertccounters();

Similar code also exists in arch/mips/oprofile/op_model_mipsxx.c.
Perhaps it is time to unify it into more standard places, i.e.
asm/cpu-features.h and cpu-probe.c.

Cheers
James

--lEGEL1/lMxI0MVQ2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrXvL0ACgkQbAtpk944
dnoEchAAs/Wvsj9CcOyu5VFABli3Noxu0unPVHgaPcX/yUE1orPBClDTZ3haDlgi
KBb8nZlaOWT3zw4ShM6KYGG3ektcSttmFR/fO+dFuNnqeIbsKFb4fn0QqBFzosv1
ilHJZrNiwv4CsM7t8KAGbTRsItAlRhHvq40NC2Sq0/V+KUC0ExSPHKS0nnJWiddG
FA+Sfc7gWGRtKNWsJOg9vpNS/cAzfYdqKYSsDR94v8ieGAP9zkCkkJV8mEd+7yLZ
vMVSmSFOY+8PeyXnr6sYvY+FplaYGMXeBg98pQQloUwxEBLCxMOAvKToRBLpcsza
+Kl/hPOMZpa2+ZlIDVWXRyElRWP45TTMn76yJjWpPUMkIL2shqIzPROm79k3zrqX
DFXEAT4hhRYeL5i4QssLTdzUOU/AC6hMZ392DU7bs+45baiBiHRnQ5io0jSab01X
n7vp8k1BfhcBROVp9qVrFf/ojA/fL/AGvPqy+AUqT9M9u0JwtlXpg5tqo3/xuvrb
8gvmytEveB4eSFtn6/tlG7pnYZ/8VkguZTFw9mnRCummXqsb3ZAkuUSpJ/MKPWfZ
rL8F5qWWbOlAbkxxOMx2tGvWOc9khnz/O1U+M29nHsxvyB9it0dfY+BzKOq5wDkj
pUBRORa4aTsRuuG0oLBre60FN1UY118ri6NB7CF5YTjfx62hv90=
=MMGa
-----END PGP SIGNATURE-----

--lEGEL1/lMxI0MVQ2--
