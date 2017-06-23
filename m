Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Jun 2017 17:15:20 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60849 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S23992974AbdFWPPNg3Yxp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Jun 2017 17:15:13 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id CEDB041F8EC3;
        Fri, 23 Jun 2017 17:24:57 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Fri, 23 Jun 2017 17:24:57 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Fri, 23 Jun 2017 17:24:57 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E2E251F0D67A6;
        Fri, 23 Jun 2017 16:15:03 +0100 (IST)
Received: from localhost (192.168.154.110) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 23 Jun
 2017 16:15:07 +0100
Date:   Fri, 23 Jun 2017 16:15:07 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V7 8/9] MIPS: Add __cpu_full_name[] to make CPU names
 more human-readable
Message-ID: <20170623151507.GC31455@jhogan-linux.le.imgtec.org>
References: <1498144016-9111-1-git-send-email-chenhc@lemote.com>
 <1498144016-9111-9-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="WfZ7S8PLGjBY9Voh"
Content-Disposition: inline
In-Reply-To: <1498144016-9111-9-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: 1b7d744b
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58764
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

--WfZ7S8PLGjBY9Voh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 22, 2017 at 11:06:55PM +0800, Huacai Chen wrote:
> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 4eff2ae..78db63a 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c

> @@ -62,6 +63,9 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	seq_printf(m, fmt, __cpu_name[n],
>  		      (version >> 4) & 0x0f, version & 0x0f,
>  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> +	if (__cpu_full_name[n])
> +		seq_printf(m, "model name\t\t: %s @ %uMHz\n",
> +		      __cpu_full_name[n], mips_hpt_frequency / 500000);

If the core frequency is useful (I can imagine it being useful for
humans), maybe it should be on a separate line.

This also assumes that the mips_hpt_frequency is half the core
frequency, which may not universally be the case. Perhaps that should be
abstracted too (at some point, I suppose it doesn't matter right away).

> diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/com=
mon/env.c
> index 1e8a955..9ee24ea 100644
> --- a/arch/mips/loongson64/common/env.c
> +++ b/arch/mips/loongson64/common/env.c
> @@ -25,6 +25,7 @@
> =20
>  u32 cpu_clock_freq;
>  EXPORT_SYMBOL(cpu_clock_freq);
> +static char cpu_full_name[64];
>  struct efi_memory_map_loongson *loongson_memmap;
>  struct loongson_system_configuration loongson_sysconf;
> =20
> @@ -151,6 +152,8 @@ void __init prom_init_env(void)
>  	loongson_sysconf.nr_nodes =3D (loongson_sysconf.nr_cpus +
>  		loongson_sysconf.cores_per_node - 1) /
>  		loongson_sysconf.cores_per_node;
> +	if (!strncmp(ecpu->cpuname, "Loongson", 8))
> +		strncpy(cpu_full_name, ecpu->cpuname, 64);

maybe sizeof(cpu_full_name) rather than 64.

> =20
>  	loongson_sysconf.pci_mem_start_addr =3D eirq_source->pci_mem_start_addr;
>  	loongson_sysconf.pci_mem_end_addr =3D eirq_source->pci_mem_end_addr;
> @@ -212,3 +215,18 @@ void __init prom_init_env(void)
>  	}
>  	pr_info("CpuClock =3D %u\n", cpu_clock_freq);
>  }
> +
> +static int __init overwrite_cpu_fullname(void)
> +{
> +	int cpu;
> +
> +	if (cpu_full_name[0] =3D=3D 0)
> +		return 0;
> +
> +	for(cpu =3D 0; cpu < NR_CPUS; cpu++)

space before open bracket please

> +		__cpu_full_name[cpu] =3D cpu_full_name;
> +
> +	return 0;
> +}
> +
> +core_initcall(overwrite_cpu_fullname);

Cheers
James

--WfZ7S8PLGjBY9Voh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAllNMHoACgkQbAtpk944
dnp5yhAAuJ5uXH4wR0ALH/BbI4eXArKtMMCQV6hzdSmz2w03zDNiZWcK45vQC8V0
oL30kt/wVJanY2XoIApiddPXQmvM5laMWS1WQrb8igOagU6L9Ob2OKdivGCakTGN
vhrJ5N8mZFzrfF7849vj2BxHSMQJ0jdAZKJrpVRUchxaZTKv3vATJ4hZBfaOu7E/
YyHv4SAM+CI4ZTXk1G6CpzFBXMaNEe1LbGA4FZH43BTEyj5uGDNQIfHRgoP658bD
lU1de2Fs6sPAISZ6mq4bzgXoVnILpWb5JsWeWP50XL3NZDeeHoF9eMfh39psfLIE
iEZZPuDyLFKiwkjVLzIwtKX8nm+N/2ydhL1yoBL3E7e/vZkBFHqXCFxLV/DWEslu
L2XC9wIX3ov/ypDDGgMlTmwe/ksTGE/9pjsz7Q7Urokbi4EUjnGrfcHDBztEnXPg
e25HFHH+e5qG9Uq7oNZm61gJP9YjUqRaCj+S8i4NaiC+ekQNGakuWBWfqyCufo+b
Xn+xDEt+6zIbMF+bsSAOIunll4g/hf5uk57OHlcKi3SvoQRxyv4x7bOtwXiPZvtw
cPxSgjUTQp3piMZeSOoQgznCyneUDKHHvSb7etMGfHSontlW+NM3xlVcfxSUQ5ji
rXU9SBjsNPRukohhPMySCDq0jXexWfSieKeDJaMR+M7ibAWvv/Y=
=hs9o
-----END PGP SIGNATURE-----

--WfZ7S8PLGjBY9Voh--
