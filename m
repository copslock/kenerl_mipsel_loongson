Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Jan 2015 12:36:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:41782 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010935AbbAZLgvQW72G (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Jan 2015 12:36:51 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id C610541F8D91;
        Mon, 26 Jan 2015 11:36:45 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 26 Jan 2015 11:36:45 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 26 Jan 2015 11:36:45 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 860E03322E91B;
        Mon, 26 Jan 2015 11:36:43 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 26 Jan 2015 11:36:45 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 26 Jan
 2015 11:36:44 +0000
Message-ID: <54C626CC.2070104@imgtec.com>
Date:   Mon, 26 Jan 2015 11:36:44 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Markos Chandras <markos.chandras@imgtec.com>,
        <linux-mips@linux-mips.org>
CC:     <stable@vger.kernel.org>
Subject: Re: [PATCH 2/3] MIPS: HTW: Prevent accidental HTW start due to nested
 htw_{start,stop}
References: <1422265236-29290-1-git-send-email-markos.chandras@imgtec.com> <1422265236-29290-3-git-send-email-markos.chandras@imgtec.com>
In-Reply-To: <1422265236-29290-3-git-send-email-markos.chandras@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="mfbc3Lbkx828JggJCjS9xjkodifq1KcWl"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45477
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

--mfbc3Lbkx828JggJCjS9xjkodifq1KcWl
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Markos,

On 26/01/15 09:40, Markos Chandras wrote:
> activate_mm() and switch_mm() call get_new_mmu_context() which in turn
> can enable the HTW before the entryhi is changed with the new ASID.
> Since the latter will enable the HTW in local_flush_tlb_all(),
> then there is a small timing window where the HTW is running with the
> new ASID but with an old pgd since the TLBMISS_HANDLER_SETUP_PGD
> hasn't assigned a new one yet. In order to prevent that, we introduce a=

> simple htw counter to avoid starting HTW accidentally due to nested
> htw_{start,stop}() sequences. Moreover, since various IPI calls can
> enforce TLB flushing operations on a different core, such an operation
> may interrupt another htw_{stop,start} in progress leading inconsistent=

> updates of the htw_seq variable. In order to avoid that, we disable the=

> interrupts whenever we update that variable.
>=20
> Cc: <stable@vger.kernel.org> # 3.17+
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/include/asm/cpu-info.h    |  5 +++++
>  arch/mips/include/asm/mmu_context.h |  7 ++++++-
>  arch/mips/include/asm/pgtable.h     | 17 ++++++++++++++---
>  arch/mips/kernel/cpu-probe.c        |  4 +++-
>  4 files changed, 28 insertions(+), 5 deletions(-)
>=20
> diff --git a/arch/mips/include/asm/cpu-info.h b/arch/mips/include/asm/c=
pu-info.h
> index a6c9ccb33c5c..c3f4f2d2e108 100644
> --- a/arch/mips/include/asm/cpu-info.h
> +++ b/arch/mips/include/asm/cpu-info.h
> @@ -84,6 +84,11 @@ struct cpuinfo_mips {
>  	 * (shifted by _CACHE_SHIFT)
>  	 */
>  	unsigned int		writecombine;
> +	/*
> +	 * Simple counter to prevent enabling HTW in nested
> +	 * htw_start/htw_stop calls
> +	 */
> +	unsigned int		htw_seq;
>  } __attribute__((aligned(SMP_CACHE_BYTES)));
> =20
>  extern struct cpuinfo_mips cpu_data[];
> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/as=
m/mmu_context.h
> index 2f82568a3ee4..bc01579a907a 100644
> --- a/arch/mips/include/asm/mmu_context.h
> +++ b/arch/mips/include/asm/mmu_context.h
> @@ -25,7 +25,6 @@ do {									\
>  	if (cpu_has_htw) {						\
>  		write_c0_pwbase(pgd);					\
>  		back_to_back_c0_hazard();				\
> -		htw_reset();						\
>  	}								\
>  } while (0)
> =20
> @@ -142,6 +141,7 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
>  	unsigned long flags;
>  	local_irq_save(flags);
> =20
> +	htw_stop();
>  	/* Check if our ASID is of an older version and thus invalid */
>  	if ((cpu_context(cpu, next) ^ asid_cache(cpu)) & ASID_VERSION_MASK)
>  		get_new_mmu_context(next, cpu);
> @@ -154,6 +154,7 @@ static inline void switch_mm(struct mm_struct *prev=
, struct mm_struct *next,
>  	 */
>  	cpumask_clear_cpu(cpu, mm_cpumask(prev));
>  	cpumask_set_cpu(cpu, mm_cpumask(next));
> +	htw_start();
> =20
>  	local_irq_restore(flags);
>  }
> @@ -180,6 +181,7 @@ activate_mm(struct mm_struct *prev, struct mm_struc=
t *next)
> =20
>  	local_irq_save(flags);
> =20
> +	htw_stop();
>  	/* Unconditionally get a new ASID.  */
>  	get_new_mmu_context(next, cpu);
> =20
> @@ -189,6 +191,7 @@ activate_mm(struct mm_struct *prev, struct mm_struc=
t *next)
>  	/* mark mmu ownership change */
>  	cpumask_clear_cpu(cpu, mm_cpumask(prev));
>  	cpumask_set_cpu(cpu, mm_cpumask(next));
> +	htw_start();
> =20
>  	local_irq_restore(flags);
>  }
> @@ -203,6 +206,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned cpu=
)
>  	unsigned long flags;
> =20
>  	local_irq_save(flags);
> +	htw_stop();
> =20
>  	if (cpumask_test_cpu(cpu, mm_cpumask(mm)))  {
>  		get_new_mmu_context(mm, cpu);
> @@ -211,6 +215,7 @@ drop_mmu_context(struct mm_struct *mm, unsigned cpu=
)
>  		/* will get a new context next time */
>  		cpu_context(cpu, mm) =3D 0;
>  	}
> +	htw_start();
>  	local_irq_restore(flags);
>  }
> =20
> diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pg=
table.h
> index 7f7c558de9fc..d2c7e9e7447e 100644
> --- a/arch/mips/include/asm/pgtable.h
> +++ b/arch/mips/include/asm/pgtable.h
> @@ -99,19 +99,30 @@ extern void paging_init(void);
> =20
>  #define htw_stop()							\
>  do {									\
> +	unsigned long flags;						\
> +									\
>  	if (cpu_has_htw) {						\
> +		local_irq_save(flags);					\

duplicate?

> +		raw_current_cpu_data.htw_seq++;				\

not "if (!raw_current_cpu_data.htw_seq++)) {"?

>  		write_c0_pwctl(read_c0_pwctl() &			\
>  			       ~(1 << MIPS_PWCTL_PWEN_SHIFT));		\
>  		back_to_back_c0_hazard();				\
> +		local_irq_restore(flags);				\
>  	}								\
>  } while(0)
> =20
>  #define htw_start()							\
>  do {									\
> +	unsigned long flags;						\
> +									\
>  	if (cpu_has_htw) {						\
> -		write_c0_pwctl(read_c0_pwctl() |			\
> -			       (1 << MIPS_PWCTL_PWEN_SHIFT));		\
> -		back_to_back_c0_hazard();				\
> +		local_irq_save(flags);					\
> +		if (!--raw_current_cpu_data.htw_seq) {			\
> +			write_c0_pwctl(read_c0_pwctl() |		\
> +				       (1 << MIPS_PWCTL_PWEN_SHIFT));	\
> +			back_to_back_c0_hazard();			\
> +		}							\
> +		local_irq_restore(flags);				\
>  	}								\
>  } while(0)
> =20
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.=
c
> index dc49cf30c2db..5d6e59f20750 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -367,8 +367,10 @@ static inline unsigned int decode_config3(struct c=
puinfo_mips *c)
>  	if (config3 & MIPS_CONF3_MSA)
>  		c->ases |=3D MIPS_ASE_MSA;
>  	/* Only tested on 32-bit cores */
> -	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT))
> +	if ((config3 & MIPS_CONF3_PW) && config_enabled(CONFIG_32BIT)) {
> +		c->htw_seq =3D 0;

is that necessary, since cpu_data[] is global?

>  		c->options |=3D MIPS_CPU_HTW;
> +	}
> =20
>  	return config3 & MIPS_CONF_M;
>  }
>=20

Cheers
James


--mfbc3Lbkx828JggJCjS9xjkodifq1KcWl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUxibNAAoJEGwLaZPeOHZ6rt0QAJwr9mfo2BcaeITkGTWIy1DQ
LM0hZmePNvym3nH6WhFLy98BN7kszcHvOebmdqKdg/L2t34Z4STVJLMU0c1JCMO7
pBjhNj8vEa3oBOxPH6KWmO5G4lLIttuRteurZXWNiDm2EHfNkmvHVmPZ2gIfnAzz
agAqlWRi+m26s7Tkuo1xGabkIMnA6FE/tKeP8LUQkzZi+Qdy09tLSeoA3zSQfhBo
FFF8cC4ZJJ8zyd5/EAHpgkCaj9m1Dna5qRtMHvRVXa5/7qosWAgAbYzg93Dclp5y
9fNduE/MiUTtn03P2Wgrs+HEYSpk4NQeWokgTJ9iIbje61pS0HjePEOO7dAh91k+
cxmkZB02Sd8Zcftal2tCdhK2+tVq12lVzC6+dybAzlnQMORJPPq/ogNfgnV/gR/e
si6QF84T5fHb0CRsMezNF/lvgUDF1LXQKzhwW095hg1cKNog37iKRCsHpd7bltl8
RtD0ebnZ/cz+zy5ugdIVDk6rbVC/jNXpUhORb4cxBAnvxaPyRR241jD3L7Bzv/ht
YhdB5dfic2qm9gTsCc7RYyQTpT8/ai6VmRdbND37j4v4mm+IOTvdBOM9w6M+39LP
TKy8v+HpKu57eRFyRVu5soby+ikfhzBLvWT9OAGh90zl/LjoRM6dCq0rGoqRxvR+
cJKfhzOXpvr493fUwxAy
=CUWk
-----END PGP SIGNATURE-----

--mfbc3Lbkx828JggJCjS9xjkodifq1KcWl--
