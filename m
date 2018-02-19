Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 00:55:06 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:36468 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994664AbeBSXy5PXhja (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 00:54:57 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 643FB21716;
        Mon, 19 Feb 2018 23:54:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 643FB21716
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 19 Feb 2018 23:54:44 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 09/12] MIPS: Loongson: Add kexec/kdump support
Message-ID: <20180219235444.GD6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-1-git-send-email-chenhc@lemote.com>
 <1517023336-17575-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="9dgjiU4MmWPVapMU"
Content-Disposition: inline
In-Reply-To: <1517023336-17575-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62628
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


--9dgjiU4MmWPVapMU
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Jan 27, 2018 at 11:22:16AM +0800, Huacai Chen wrote:
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

Please add a commit message.

Worth Cc'ing kexec maintainers?

> ---
>  arch/mips/kernel/relocate_kernel.S    |  30 +++++++++
>  arch/mips/loongson64/common/env.c     |   8 +++
>  arch/mips/loongson64/common/reset.c   | 119 ++++++++++++++++++++++++++++=
++++++
>  arch/mips/loongson64/loongson-3/smp.c |   4 ++
>  4 files changed, 161 insertions(+)
>=20
> diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/reloca=
te_kernel.S
> index c6bbf21..e73edc7 100644
> --- a/arch/mips/kernel/relocate_kernel.S
> +++ b/arch/mips/kernel/relocate_kernel.S
> @@ -135,6 +135,36 @@ LEAF(kexec_smp_wait)
>  #else
>  	sync
>  #endif
> +
> +#ifdef CONFIG_CPU_LOONGSON3
> +	/* s0:prid s1:initfn */
> +	/* t0:base t1:cpuid t2:node t3:core t9:count */
> +	mfc0  t1, $15, 1

Can you use CP0_EBASE from mipsregs.h?

> +	andi  t1, 0x3ff

MIPS_EBASE_CPUNUM

> +	dli   t0, 0x900000003ff01000

Whats that?

> +	andi  t3, t1, 0x3
> +	sll   t3, 8               /* get core id */
> +	or    t0, t0, t3

Do you have the INS instruction on loongson? Does it make sense to do
this, even if only for readability?
	dins	t0, t1, 8, 2

> +	andi  t2, t1, 0xc
> +	dsll  t2, 42              /* get node id */
> +	or    t0, t0, t2

Does it make sense to do this, especially for readability (44 vs 42)?
	dext	t2, t1, 2, 2
	dins	t0, t2, 44, 2

> +	mfc0  s0, $15, 0

CP0_PRID

> +	andi  s0, s0, 0xf
> +	blt   s0, 0x6, 1f         /* Loongson-3A1000 */
> +	bgt   s0, 0x7, 1f         /* Loongson-3A2000/3A3000 */

> +	dsrl  t2, 30              /* Loongson-3B1000/3B1500 need bit15:14 */
> +	or    t0, t0, t2

maybe:
	dins	t0, t2, 14, 2

> +1:	li    t9, 0x100           /* wait for init loop */
> +2:	addiu t9, -1              /* limit mailbox access */
> +	bnez  t9, 2b
> +	ld    s1, 0x20(t0)        /* get PC via mailbox */
> +	beqz  s1, 1b
> +	ld    sp, 0x28(t0)        /* get SP via mailbox */
> +	ld    gp, 0x30(t0)        /* get GP via mailbox */
> +	ld    a1, 0x38(t0)
> +	jr    s1                  /* jump to initial PC */
> +#endif
> +
>  	j		s1
>  	END(kexec_smp_wait)
>  #endif
> diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/com=
mon/env.c
> index 2928ac5..990a2d69 100644
> --- a/arch/mips/loongson64/common/env.c
> +++ b/arch/mips/loongson64/common/env.c
> @@ -72,6 +72,7 @@ void __init prom_init_env(void)
> =20
>  	pr_info("memsize=3D%u, highmemsize=3D%u\n", memsize, highmemsize);
>  #else
> +	int i;
>  	struct boot_params *boot_p;
>  	struct loongson_params *loongson_p;
>  	struct system_loongson *esys;
> @@ -149,6 +150,13 @@ void __init prom_init_env(void)
>  	loongson_sysconf.nr_cpus =3D ecpu->nr_cpus;
>  	loongson_sysconf.boot_cpu_id =3D ecpu->cpu_startup_core_id;
>  	loongson_sysconf.reserved_cpus_mask =3D ecpu->reserved_cores_mask;
> +#ifdef CONFIG_KEXEC
> +	loongson_sysconf.boot_cpu_id =3D get_ebase_cpunum();
> +	for (i =3D 0; i < loongson_sysconf.boot_cpu_id; i++)
> +		loongson_sysconf.reserved_cpus_mask |=3D (1<<i);

maybe this?
	loongson_sysconf.reserved_cpus_mask |=3D
		(1 << loongson_sysconf.boot_cpu_id) - 1;

> +	pr_info("Boot CPU ID is being fixed from %d to %d\n",
> +		ecpu->cpu_startup_core_id, loongson_sysconf.boot_cpu_id);
> +#endif
>  	if (ecpu->nr_cpus > NR_CPUS || ecpu->nr_cpus =3D=3D 0)
>  		loongson_sysconf.nr_cpus =3D NR_CPUS;
>  	loongson_sysconf.nr_nodes =3D (loongson_sysconf.nr_cpus +
> diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/c=
ommon/reset.c
> index a60715e..5f65a4e 100644
> --- a/arch/mips/loongson64/common/reset.c
> +++ b/arch/mips/loongson64/common/reset.c
> @@ -11,9 +11,14 @@
>   */
>  #include <linux/init.h>
>  #include <linux/pm.h>
> +#include <linux/cpu.h>
> +#include <linux/slab.h>
> +#include <linux/delay.h>
> +#include <linux/kexec.h>
> =20
>  #include <asm/idle.h>
>  #include <asm/reboot.h>
> +#include <asm/bootinfo.h>

alphabetical ordering wherever possible please.

> =20
>  #include <loongson.h>
>  #include <boot_param.h>
> @@ -80,12 +85,126 @@ static void loongson_halt(void)
>  	}
>  }
> =20
> +#ifdef CONFIG_KEXEC
> +
> +/* 0X80000000~0X80200000 is safe */
> +#define MAX_ARGS	64
> +#define KEXEC_CTRL_CODE	0XFFFFFFFF80100000UL
> +#define KEXEC_ARGV_ADDR	0XFFFFFFFF80108000UL

lower case 0x please.

> +#define KEXEC_ARGV_SIZE	3060
> +#define KEXEC_ENVP_SIZE	4500
> +
> +void *kexec_argv;
> +void *kexec_envp;
> +extern const size_t relocate_new_kernel_size;

A couple of other architectures have moved this declaration to
asm/kexec.h.

> +
> +static int loongson_kexec_prepare(struct kimage *image)
> +{
> +	int i, argc =3D 0;
> +	unsigned int *argv;
> +	char *str, *ptr, *bootloader =3D "kexec";
> +
> +	/* argv at offset 0, argv[] at offset KEXEC_ARGV_SIZE/2 */
> +	argv =3D (unsigned int *)kexec_argv;

the cast is redundant as kexec_argv is void *.

> +	argv[argc++] =3D (unsigned int)(KEXEC_ARGV_ADDR + KEXEC_ARGV_SIZE/2);
> +
> +	for (i =3D 0; i < image->nr_segments; i++) {
> +		if (!strncmp(bootloader, (char *)image->segment[i].buf,
> +				strlen(bootloader))) {
> +			/*
> +			 * convert command line string to array
> +			 * of parameters (as bootloader does).
> +			 */
> +			int offt;
> +			memcpy(kexec_argv + KEXEC_ARGV_SIZE/2, image->segment[i].buf, KEXEC_A=
RGV_SIZE/2);
> +			str =3D (char *)kexec_argv + KEXEC_ARGV_SIZE/2;
> +			ptr =3D strchr(str, ' ');
> +
> +			while (ptr && (argc < MAX_ARGS)) {
> +				*ptr =3D '\0';
> +				if (ptr[1] !=3D ' ') {
> +					offt =3D (int)(ptr - str + 1);
> +					argv[argc] =3D KEXEC_ARGV_ADDR + KEXEC_ARGV_SIZE/2 + offt;
> +					argc++;
> +				}
> +				ptr =3D strchr(ptr + 1, ' ');
> +			}
> +			break;
> +		}
> +	}
> +
> +	kexec_args[0] =3D argc;
> +	kexec_args[1] =3D fw_arg1;
> +	kexec_args[2] =3D fw_arg2;
> +	image->control_code_page =3D virt_to_page((void *)KEXEC_CTRL_CODE);
> +
> +	return 0;
> +}
> +
> +#ifdef CONFIG_SMP
> +static void kexec_smp_down(void *ignored)
> +{
> +	int cpu =3D smp_processor_id();
> +
> +	local_irq_disable();
> +	set_cpu_online(cpu, false);
> +	while (!atomic_read(&kexec_ready_to_reboot))
> +		cpu_relax();
> +
> +	asm volatile (
> +	"	sync					\n"
> +	"	synci	($0)				\n");

The intermediate assembly looks nicer, and you'd get fewer checkpatch
complaints, if you do something more like this:
	asm volatile ("sync\n\t"
		      "synci ($0)");

> +
> +	relocated_kexec_smp_wait(NULL);
> +}
> +#endif
> +
> +static void loongson_kexec_shutdown(void)
> +{
> +#ifdef CONFIG_SMP
> +	int cpu;
> +
> +	for_each_possible_cpu(cpu)
> +		if (!cpu_online(cpu))
> +			cpu_up(cpu); /* Everyone should go to reboot_code_buffer */

long line=20

> +
> +	smp_call_function(kexec_smp_down, NULL, 0);
> +	smp_wmb();

This probably needs a comment to explain what smp_rmb() it pairs with,
or what writes need a barrier between them and why. It certainly isn't
clear from reading the code.

> +	while (num_online_cpus() > 1) {
> +		mdelay(1);
> +		cpu_relax();
> +	}
> +#endif
> +	memcpy((void *)fw_arg1, kexec_argv, KEXEC_ARGV_SIZE);
> +	memcpy((void *)fw_arg2, kexec_envp, KEXEC_ENVP_SIZE);
> +}

> diff --git a/arch/mips/loongson64/loongson-3/smp.c b/arch/mips/loongson64=
/loongson-3/smp.c
> index 470e9c1..1e21ac4 100644
> --- a/arch/mips/loongson64/loongson-3/smp.c
> +++ b/arch/mips/loongson64/loongson-3/smp.c
> @@ -387,6 +387,10 @@ static void __init loongson3_smp_setup(void)
>  	ipi_status0_regs_init();
>  	ipi_en0_regs_init();
>  	ipi_mailbox_buf_init();
> +
> +	for (i =3D 0; i < loongson_sysconf.nr_cpus; i++)
> +		loongson3_ipi_write64(0, (void *)(ipi_mailbox_buf[i]+0x0));

what does that do? Please consider adding a comment.

Cheers
James

--9dgjiU4MmWPVapMU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqLY8QACgkQbAtpk944
dnpOEQ/8Djzf8dKj4FDr41710i1c17GPhx407bLUu9g6RA0GEOptIJUvlRnrsMG9
zeUOmFWwgfh1XB5/tjYksKjj/tC798F+lmRyVHRe1/cJxtvfCDoMkq5n4Oh0Nb6/
0NJOSP/lijwLyX9YigbbYkHmrxp8XpjHS4CxC1y5LpKQ3VouMGftMFoRkd/1PX1H
l2dkMcu/dYRT5tdehQ0MrW8Bm9aXIzNPh7QSJZ694SAiTQoiDXA611qgNQymktih
kD1sOoDg7WrNL5M6ULKFzun9dSvGBPvOAPuLd7xNwEqnj0n/t9pLsC/m8ldBBpFk
g44wQQK/hF17A4MqcrMsHVGMcYuF3LhRo0+q/40q2WyPXA5mM5zNF4ZEPPD8ysWI
/WDpqdgofDfEybS7HB5WBFXQF6YBywTPPFTXxrkEkXj6J5HPX4EWznx5UFjcQrJ0
vqFFX9/uQ6XgmVSNDsIeB75KJB7RDvHVnnxn47YS1UgaAR3uhfLa6udbUY4FZGv6
b3USex0Mbqm8ntwEv1WNj1OugtADlMc7eVTA77C+9i0T4V2FHtTyj0OXR83agvD0
QsE+CzKFQZZ2Ed09YXZ40qkeYHTThzNA4E+2kUIr5Q9QhOwKelR7AEfateU7CRql
NTCzQuY00X//DJiwR7Wv+fu4ju0pGXnXg3DD/XjXjxpZgOvki+c=
=vZn4
-----END PGP SIGNATURE-----

--9dgjiU4MmWPVapMU--
