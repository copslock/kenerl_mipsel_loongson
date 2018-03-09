Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Mar 2018 01:14:15 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:50384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994765AbeCIAOFT84MR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 9 Mar 2018 01:14:05 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A33F5206B2;
        Fri,  9 Mar 2018 00:13:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A33F5206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 9 Mar 2018 00:13:54 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 2/2] MIPS: Remove custom implementations CPU hang
 implementations
Message-ID: <20180309001353.GC24558@saruman>
References: <20170823205317.4828-1-paul.burton@imgtec.com>
 <20170823205317.4828-3-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <20170823205317.4828-3-paul.burton@imgtec.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62861
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


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 23, 2017 at 01:53:17PM -0700, Paul Burton wrote:
> Many platforms implement variations upon the same theme of hanging the
> CPU using an infinite loop in their _machine_halt, _machine_restart or
> pm_power_off callbacks. Our generic machine_halt(), machine_restart() &
> machine_power_off() functions will do this for us if the platform
> doesn't specify the appropriate callback or the callback function
> returns, so there's no need for each platform to implement the same
> thing.
>=20
> This patch removes many platforms implementations of this functionality,
> leaving it to the generic code to handle.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org

This doesn't apply cleanly due to removal of lantiq/xway/reset.c.

Any reason not to remove ip27_machine_power_off() also? I guess not the
noreturn in ip27_machine_halt() due to the SMP management it does.

Should stop_this_cpu() do something more efficient too?

We do have to be careful about these callbacks disabling IRQs and
returning, on SMP platforms at least. smp_call_function() says not to
call it with IRQs disabled. Perhaps generic code should warn in the SMP
#ifdef if interrupts have been disabled by the platform callbacks before
doing the SMP call, though of course for half of them it might never
reach that point.


> diff --git a/arch/mips/alchemy/board-gpr.c b/arch/mips/alchemy/board-gpr.c
> index 6fb6b3faa158..218d1255a4cb 100644
> --- a/arch/mips/alchemy/board-gpr.c
> +++ b/arch/mips/alchemy/board-gpr.c
> @@ -80,18 +80,10 @@ static void gpr_reset(char *c)
>  		cpu_wait();
>  }
> =20
> -static void gpr_power_off(void)
> -{
> -	while (1)
> -		cpu_wait();
> -}
> -

Presumably the loop in gpr_reset() could go too, so it falls back to
generic code? (I can't see any sign of SMP support for alchemy).

> diff --git a/arch/mips/ath79/setup.c b/arch/mips/ath79/setup.c
> index f206dafbb0a3..ce28428cf256 100644
> --- a/arch/mips/ath79/setup.c
> +++ b/arch/mips/ath79/setup.c
> @@ -46,12 +46,6 @@ static void ath79_restart(char *command)
>  			cpu_wait();
>  }
> =20
> -static void ath79_halt(void)
> -{
> -	while (1)
> -		cpu_wait();
> -}

The ath79_restart could presumably fall back to generic too?

> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 6054d49e608e..f7ab6b4085ad 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -77,8 +77,6 @@ static void bcm47xx_machine_restart(char *command)
>  		break;
>  #endif
>  	}
> -	while (1)
> -		cpu_relax();
>  }
> =20
>  static void bcm47xx_machine_halt(void)
> @@ -97,8 +95,6 @@ static void bcm47xx_machine_halt(void)
>  		break;
>  #endif
>  	}
> -	while (1)
> -		cpu_relax();
>  }

These do disable interrupts, but no SMP that I can see so I suppose its
safe.

> =20
>  #ifdef CONFIG_BCM47XX_SSB
> diff --git a/arch/mips/bcm63xx/setup.c b/arch/mips/bcm63xx/setup.c
> index 2be9caaa2085..43a9617a19af 100644
> --- a/arch/mips/bcm63xx/setup.c
> +++ b/arch/mips/bcm63xx/setup.c
> @@ -22,13 +22,6 @@
>  #include <bcm63xx_io.h>
>  #include <bcm63xx_gpio.h>
> =20
> -void bcm63xx_machine_halt(void)

There's a declaration of this in
arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h that can be removed
now too.

> -{
> -	pr_info("System halted\n");
> -	while (1)
> -		;
> -}
> -
>  static void bcm6348_a1_reboot(void)
>  {
>  	u32 reg;
> @@ -148,9 +141,7 @@ void __init plat_mem_setup(void)
>  {
>  	add_memory_region(0, bcm63xx_get_memory_size(), BOOT_MEM_RAM);
> =20
> -	_machine_halt =3D bcm63xx_machine_halt;
>  	_machine_restart =3D __bcm63xx_machine_reboot;

Worth bcm63xx_machine_reboot()'s fallback loop falling back to generic?
It seems to support SMP, but it doesn't disable IRQs.

> diff --git a/arch/mips/cobalt/reset.c b/arch/mips/cobalt/reset.c
> index 4eedd481dd00..727f139ed460 100644
> --- a/arch/mips/cobalt/reset.c
> +++ b/arch/mips/cobalt/reset.c
> @@ -37,10 +37,6 @@ void cobalt_machine_halt(void)
>  	led_trigger_event(power_off_led_trigger, LED_FULL);
> =20
>  	local_irq_disable();
> -	while (1) {
> -		if (cpu_wait)
> -			cpu_wait();
> -	}

The local_irq_disable() could be dropped to.

> diff --git a/arch/mips/lasat/reset.c b/arch/mips/lasat/reset.c
> index e21f0b9a586e..d4a5d5b787a9 100644
> --- a/arch/mips/lasat/reset.c
> +++ b/arch/mips/lasat/reset.c
> @@ -49,7 +49,6 @@ static void lasat_machine_halt(void)
>  	local_irq_disable();
> =20
>  	prom_monitor();
> -	for (;;) ;

same for lasat_machine_restart?

(no SMP here either AFAICT)

> diff --git a/arch/mips/loongson64/common/reset.c b/arch/mips/loongson64/c=
ommon/reset.c
> index a60715e11306..ec290392c175 100644
> --- a/arch/mips/loongson64/common/reset.c
> +++ b/arch/mips/loongson64/common/reset.c
> @@ -48,10 +48,6 @@ static void loongson_restart(char *command)
>  	void (*fw_restart)(void) =3D (void *)loongson_sysconf.restart_addr;
> =20
>  	fw_restart();
> -	while (1) {
> -		if (cpu_wait)
> -			cpu_wait();
> -	}

Loongson64 does support SMP. If fw_restart() disabled IRQs before
returning that could be a problem?

But maybe it'd be a problem for it to return at all...

> @@ -64,26 +60,12 @@ static void loongson_poweroff(void)
>  	void (*fw_poweroff)(void) =3D (void *)loongson_sysconf.poweroff_addr;
> =20
>  	fw_poweroff();
> -	while (1) {
> -		if (cpu_wait)
> -			cpu_wait();
> -	}

same?

> diff --git a/arch/mips/sgi-ip22/ip22-reset.c b/arch/mips/sgi-ip22/ip22-re=
set.c
> index 03a39ac5ead9..ce1f435f31de 100644
> --- a/arch/mips/sgi-ip22/ip22-reset.c
> +++ b/arch/mips/sgi-ip22/ip22-reset.c
> @@ -71,7 +71,6 @@ static void __noreturn sgi_machine_restart(char *comman=
d)
>  	if (machine_state & MACHINE_SHUTTING_DOWN)
>  		sgi_machine_power_off();
>  	sgimc->cpuctrl0 |=3D SGIMC_CCTRL0_SYSINIT;
> -	while (1);

Don't forget to drop the __noreturn (I haven't checked this on other
paths).

> diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setu=
p.c
> index 1791a44ee570..c58ab1bdd3e5 100644
> --- a/arch/mips/txx9/generic/setup.c
> +++ b/arch/mips/txx9/generic/setup.c
> @@ -370,25 +370,6 @@ const char *__init prom_getenv(const char *name)
>  	return NULL;
>  }
> =20
> -static void __noreturn txx9_machine_halt(void)
> -{
> -	local_irq_disable();
> -	clear_c0_status(ST0_IM);
> -	while (1) {
> -		if (cpu_wait) {
> -			(*cpu_wait)();
> -			if (cpu_has_counter) {
> -				/*
> -				 * Clear counter interrupt while it
> -				 * breaks WAIT instruction even if
> -				 * masked.
> -				 */
> -				write_c0_compare(0);
> -			}
> -		}
> -	}
> -}

I think this was used indirectly (via _machine_halt) by
tx4927_machine_restart(), tx4938_machine_restart(),
tx4939_machine_restart(), jmr3927_machine_restart(),
toshiba_rbtx4927_restart(), and rbtx4938_machine_restart() as a fallback
if restart doesn't work.

I suppose those fallbacks should be dropped to avoid calling NULL and it
should just fall through to the generic halt code?

There's also a while loop in rbtx4939_machine_restart(). No SMP here
either apparently.

> diff --git a/arch/mips/vr41xx/common/pmu.c b/arch/mips/vr41xx/common/pmu.c
> index 39a0db3e2b34..65157b686b5c 100644
> --- a/arch/mips/vr41xx/common/pmu.c
> +++ b/arch/mips/vr41xx/common/pmu.c
> @@ -84,7 +84,6 @@ static void vr41xx_restart(char *command)
>  {
>  	local_irq_disable();
>  	software_reset();
> -	while (1) ;

No SMP, so I suppose its fine.

Cheers
James

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqh0bsACgkQbAtpk944
dnrN4Q//bZPz0FIoj0hdCP7xyG1h8ExN/xGgEVwVtUVKVnZsOocHWAp1ptK/zQ//
UmwPnnihAX/WfRbc2JKQrRtJ+wlqxPFvcVF/WTSmKkqQIDovGnTcnGnvS197ptzb
7nhSQhPoP/+WJGPNRUF8jEu87b10wmwMvsksgBRzJhgI11YtFv+KI8Kg02gpaysQ
5B033EnsZpsEjXlLamkteZ2X202yb2G+7amuvqExbkZs+1NmdIIX5/GGnuqttBOC
l3vf9Bz28/hqdlLhKnUWzweFeNX/WlGji5R15Y645IQpACmXhywYW1b/A4YpIck0
P0yYIVkrka1yJZbqlzSLOEjkDtTtpjEU4igtjCesXuKQd4hRcF5+za+IXytYNB5C
ZLbjOMDF5M/LersnTvkGUI3SW6dBfzH4WRxXpK6jvsSof3nT/+CMnLc35vSX8XHq
EvWbjIDh6QQRjCJFFKKz4b1KkkuUhK4DG2Gj4gcvPiQj+RcksnhW43/YVx0CLvqM
7v5vbTmjhBT4WTPBgT7CAYTroT0Yj3MFc5bKg1EVvDZZVuittR27yXxdQmUFKbHy
5fEqOCmpMbRXHUWBjXugf9v5UqLeOeOCYEzUjM/eafHYXlNtG9jXsYhOOPjG1t3Q
EvJBMAVS3duBwKPLWaLPNjyuiB+nO/l8Obe8jfiULmcynXBJlJ4=
=stk0
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
