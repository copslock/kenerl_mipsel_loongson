Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 May 2018 19:59:37 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:41042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993057AbeEPR7afXtz6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 May 2018 19:59:30 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7C93920834;
        Wed, 16 May 2018 17:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526493563;
        bh=UZrP2NC/Yldc/RAsN11ZCKPUvaO0eIevLZ4xzX9W2gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UekkozVlhgWIfuOnmny0xhwFgOtpCL8Lctk/DcSQrIKpqrVB7auJtoIrKjK0mHZUn
         uUEfAAxlsOH2iNuw4892YrohtzxwrVwCjQLeJ4EwtB7WgA/p2yukeSvMXeS/gFq1t+
         OhadAKIo0F6yJs3IrhFIa1a53KXR5jr4Nn1YLmxE=
Date:   Wed, 16 May 2018 18:59:18 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-mips@linux-mips.org, Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH v3 4/7] MIPS: perf: Fix perf with MT counting other
 threads
Message-ID: <20180516175916.GA12837@jamesdev>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
 <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="fUYQa+Pmc3FrFX/N"
Content-Disposition: inline
In-Reply-To: <1524219789-31241-5-git-send-email-matt.redfearn@mips.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63976
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


--fUYQa+Pmc3FrFX/N
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 20, 2018 at 11:23:06AM +0100, Matt Redfearn wrote:
> diff --git a/arch/mips/kernel/perf_event_mipsxx.c b/arch/mips/kernel/perf=
_event_mipsxx.c
> index 7e2b7d38a774..fe50986e83c6 100644
> --- a/arch/mips/kernel/perf_event_mipsxx.c
> +++ b/arch/mips/kernel/perf_event_mipsxx.c
> @@ -323,7 +323,11 @@ static int mipsxx_pmu_alloc_counter(struct cpu_hw_ev=
ents *cpuc,
> =20
>  static void mipsxx_pmu_enable_event(struct hw_perf_event *evt, int idx)
>  {
> +	struct perf_event *event =3D container_of(evt, struct perf_event, hw);
>  	struct cpu_hw_events *cpuc =3D this_cpu_ptr(&cpu_hw_events);
> +#ifdef CONFIG_MIPS_MT_SMP
> +	unsigned int range =3D evt->event_base >> 24;
> +#endif /* CONFIG_MIPS_MT_SMP */
> =20
>  	WARN_ON(idx < 0 || idx >=3D mipspmu.num_counters);
> =20
> @@ -331,11 +335,37 @@ static void mipsxx_pmu_enable_event(struct hw_perf_=
event *evt, int idx)
>  		(evt->config_base & M_PERFCTL_CONFIG_MASK) |
>  		/* Make sure interrupt enabled. */
>  		MIPS_PERFCTRL_IE;
> -	if (IS_ENABLED(CONFIG_CPU_BMIPS5000))
> +
> +#ifdef CONFIG_CPU_BMIPS5000
> +	{
>  		/* enable the counter for the calling thread */
>  		cpuc->saved_ctrl[idx] |=3D
>  			(1 << (12 + vpe_id())) | BRCM_PERFCTRL_TC;
> +	}
> +#else
> +#ifdef CONFIG_MIPS_MT_SMP
> +	if (range > V) {
> +		/* The counter is processor wide. Set it up to count all TCs. */
> +		pr_debug("Enabling perf counter for all TCs\n");
> +		cpuc->saved_ctrl[idx] |=3D M_TC_EN_ALL;
> +	} else
> +#endif /* CONFIG_MIPS_MT_SMP */
> +	{
> +		unsigned int cpu, ctrl;
> =20
> +		/*
> +		 * Set up the counter for a particular CPU when event->cpu is
> +		 * a valid CPU number. Otherwise set up the counter for the CPU
> +		 * scheduling this thread.
> +		 */
> +		cpu =3D (event->cpu >=3D 0) ? event->cpu : smp_processor_id();
> +
> +		ctrl =3D M_PERFCTL_VPEID(cpu_vpe_id(&cpu_data[cpu]));
> +		ctrl |=3D M_TC_EN_VPE;
> +		cpuc->saved_ctrl[idx] |=3D ctrl;
> +		pr_debug("Enabling perf counter for CPU%d\n", cpu);
> +	}
> +#endif /* CONFIG_CPU_BMIPS5000 */

I'm not a huge fan of the ifdefery tbh, I don't think it makes it very
easy to read having a combination of ifs and #ifdefs. I reckon
IF_ENABLED would be better, perhaps with having the BMIPS5000 case
return to avoid too much nesting.

Otherwise the patch looks okay to me.

Thanks
James

--fUYQa+Pmc3FrFX/N
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvxxcwAKCRA1zuSGKxAj
8kBCAP4sctSZ7Q6x87ZMki4qfpi/KV9WrytKPScE+HZ1vi4yIAEA7JVy8xtAxT5l
JtIM0hxrefKUgoOV+JDhwyIB7SKAgAM=
=EsA1
-----END PGP SIGNATURE-----

--fUYQa+Pmc3FrFX/N--
