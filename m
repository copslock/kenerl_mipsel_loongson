Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 12:36:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56187 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27011860AbbD1KgGsSQSC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 12:36:06 +0200
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 1426241F8D82;
        Tue, 28 Apr 2015 11:36:03 +0100 (BST)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 28 Apr 2015 11:36:03 +0100
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 28 Apr 2015 11:36:03 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 924A1DBD9728F;
        Tue, 28 Apr 2015 11:36:00 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 28 Apr 2015 11:36:02 +0100
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 28 Apr
 2015 11:36:02 +0100
Message-ID: <553F6291.5070605@imgtec.com>
Date:   Tue, 28 Apr 2015 11:36:01 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>
CC:     Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mark Rutland <mark.rutland@arm.com>,
        Pawel Moll <pawel.moll@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v4 36/37] MIPS: ingenic: initial JZ4780 support
References: <1429881457-16016-1-git-send-email-paul.burton@imgtec.com> <1429881457-16016-37-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1429881457-16016-37-git-send-email-paul.burton@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="fUn7tfk0pI87QhIvV1DNRC7Wpu15XRq94"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47124
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

--fUn7tfk0pI87QhIvV1DNRC7Wpu15XRq94
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Paul,

On 24/04/15 14:17, Paul Burton wrote:
> Support the Ingenic JZ4780 SoC using the existing code under
> arch/mips/jz4740 now that it has been generalised sufficiently.
>=20
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ian Campbell <ijc+devicetree@hellion.org.uk>
> Cc: Kumar Gala <galak@codeaurora.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Pawel Moll <pawel.moll@arm.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-mips@linux-mips.org
> ---
> Changes in v4:
>   - None.
>=20
> Changes in v3:
>   - Rebase, dropping serial.h & relocating behind CONFIG_MACH_INGENIC.
>=20
> Changes in v2:
>   - None.
> ---
>  arch/mips/boot/dts/ingenic/jz4780.dtsi             | 101 +++++++++++++=
++++++++
>  arch/mips/include/asm/cpu-type.h                   |   2 +-
>  .../asm/mach-jz4740/cpu-feature-overrides.h        |   3 -
>  arch/mips/include/asm/mach-jz4740/irq.h            |   4 +
>  arch/mips/jz4740/Kconfig                           |   6 ++
>  arch/mips/jz4740/Makefile                          |   4 +-
>  arch/mips/jz4740/setup.c                           |   3 +
>  arch/mips/jz4740/time.c                            |   7 +-
>  8 files changed, 124 insertions(+), 6 deletions(-)
>  create mode 100644 arch/mips/boot/dts/ingenic/jz4780.dtsi
>=20
> diff --git a/arch/mips/boot/dts/ingenic/jz4780.dtsi b/arch/mips/boot/dt=
s/ingenic/jz4780.dtsi
> new file mode 100644
> index 0000000..5e44dd6
> --- /dev/null
> +++ b/arch/mips/boot/dts/ingenic/jz4780.dtsi
> @@ -0,0 +1,101 @@
> +#include <dt-bindings/clock/jz4780-cgu.h>
> +
> +/ {
> +	#address-cells =3D <1>;
> +	#size-cells =3D <1>;
> +	compatible =3D "ingenic,jz4780";
> +
> +	cpuintc: interrupt-controller {
> +		#address-cells =3D <0>;
> +		#interrupt-cells =3D <1>;
> +		interrupt-controller;
> +		compatible =3D "mti,cpu-interrupt-controller";
> +	};
> +
> +	intc: interrupt-controller@10001000 {
> +		compatible =3D "ingenic,jz4780-intc";
> +		reg =3D <0x10001000 0x50>;
> +
> +		interrupt-controller;
> +		#interrupt-cells =3D <1>;
> +
> +		interrupt-parent =3D <&cpuintc>;
> +		interrupts =3D <2>;
> +	};
> +
> +	ext: ext {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +	};
> +
> +	rtc: rtc {
> +		compatible =3D "fixed-clock";
> +		#clock-cells =3D <0>;
> +		clock-frequency =3D <32768>;
> +	};
> +
> +	cgu: jz4780-cgu@10000000 {
> +		compatible =3D "ingenic,jz4780-cgu";
> +		reg =3D <0x10000000 0x100>;
> +
> +		clocks =3D <&ext>, <&rtc>;
> +		clock-names =3D "ext", "rtc";
> +
> +		#clock-cells =3D <1>;
> +	};
> +
> +	uart0: serial@10030000 {
> +		compatible =3D "ingenic,jz4780-uart";
> +		reg =3D <0x10030000 0x100>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <51>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4780_CLK_UART0>;
> +		clock-names =3D "baud", "module";
> +	};
> +
> +	uart1: serial@10031000 {
> +		compatible =3D "ingenic,jz4780-uart";
> +		reg =3D <0x10031000 0x100>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <50>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4780_CLK_UART1>;
> +		clock-names =3D "baud", "module";
> +	};
> +
> +	uart2: serial@10032000 {
> +		compatible =3D "ingenic,jz4780-uart";
> +		reg =3D <0x10032000 0x100>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <49>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4780_CLK_UART2>;
> +		clock-names =3D "baud", "module";
> +	};
> +
> +	uart3: serial@10033000 {
> +		compatible =3D "ingenic,jz4780-uart";
> +		reg =3D <0x10033000 0x100>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <48>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4780_CLK_UART3>;
> +		clock-names =3D "baud", "module";
> +	};
> +
> +	uart4: serial@10034000 {
> +		compatible =3D "ingenic,jz4780-uart";
> +		reg =3D <0x10034000 0x100>;
> +
> +		interrupt-parent =3D <&intc>;
> +		interrupts =3D <34>;
> +
> +		clocks =3D <&ext>, <&cgu JZ4780_CLK_UART4>;
> +		clock-names =3D "baud", "module";
> +	};

Does it makes sense to have any peripherals requiring physical connects
on the board (i.e. uarts in this case) default to:
	status=3D"disabled";

in this file, and override the ones which are actually wired up to a
header or something in the board file?:

&uart4 {
	status=3D"okay";
}

E.g. on CI20 (based on pinouts), UART2 doesn't appear to be wired to
anything. That will prevent the driver being loaded for such peripherals
(you may need aliases to preserve numbering, assuming that works for
serial ports).

Cheers
James

> +};
> diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/c=
pu-type.h
> index 33f3cab..d41e8e2 100644
> --- a/arch/mips/include/asm/cpu-type.h
> +++ b/arch/mips/include/asm/cpu-type.h
> @@ -32,12 +32,12 @@ static inline int __pure __get_cpu_type(const int c=
pu_type)
>  	case CPU_4KC:
>  	case CPU_ALCHEMY:
>  	case CPU_PR4450:
> -	case CPU_JZRISC:
>  #endif
> =20
>  #if defined(CONFIG_SYS_HAS_CPU_MIPS32_R1) || \
>      defined(CONFIG_SYS_HAS_CPU_MIPS32_R2)
>  	case CPU_4KEC:
> +	case CPU_JZRISC:
>  #endif
> =20
>  #ifdef CONFIG_SYS_HAS_CPU_MIPS32_R2
> diff --git a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h =
b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
> index a225baa..0933f94 100644
> --- a/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
> +++ b/arch/mips/include/asm/mach-jz4740/cpu-feature-overrides.h
> @@ -12,8 +12,6 @@
>  #define cpu_has_3k_cache	0
>  #define cpu_has_4k_cache	1
>  #define cpu_has_tx39_cache	0
> -#define cpu_has_fpu		0
> -#define cpu_has_32fpr	0
>  #define cpu_has_counter		0
>  #define cpu_has_watch		1
>  #define cpu_has_divec		1
> @@ -34,7 +32,6 @@
>  #define cpu_has_ic_fills_f_dc	0
>  #define cpu_has_pindexed_dcache 0
>  #define cpu_has_mips32r1	1
> -#define cpu_has_mips32r2	0
>  #define cpu_has_mips64r1	0
>  #define cpu_has_mips64r2	0
>  #define cpu_has_dsp		0
> diff --git a/arch/mips/include/asm/mach-jz4740/irq.h b/arch/mips/includ=
e/asm/mach-jz4740/irq.h
> index b218f76..9b439fc 100644
> --- a/arch/mips/include/asm/mach-jz4740/irq.h
> +++ b/arch/mips/include/asm/mach-jz4740/irq.h
> @@ -21,6 +21,8 @@
> =20
>  #ifdef CONFIG_MACH_JZ4740
>  # define NR_INTC_IRQS	32
> +#else
> +# define NR_INTC_IRQS	64
>  #endif
> =20
>  /* 1st-level interrupts */
> @@ -48,6 +50,8 @@
>  #define JZ4740_IRQ_IPU		JZ4740_IRQ(29)
>  #define JZ4740_IRQ_LCD		JZ4740_IRQ(30)
> =20
> +#define JZ4780_IRQ_TCU2		JZ4740_IRQ(25)
> +
>  /* 2nd-level interrupts */
>  #define JZ4740_IRQ_DMA(x)	(JZ4740_IRQ(NR_INTC_IRQS) + (x))
> =20
> diff --git a/arch/mips/jz4740/Kconfig b/arch/mips/jz4740/Kconfig
> index dff0966..21adcea 100644
> --- a/arch/mips/jz4740/Kconfig
> +++ b/arch/mips/jz4740/Kconfig
> @@ -12,3 +12,9 @@ endchoice
>  config MACH_JZ4740
>  	bool
>  	select SYS_HAS_CPU_MIPS32_R1
> +
> +config MACH_JZ4780
> +	bool
> +	select MIPS_CPU_SCACHE
> +	select SYS_HAS_CPU_MIPS32_R2
> +	select SYS_SUPPORTS_HIGHMEM
> diff --git a/arch/mips/jz4740/Makefile b/arch/mips/jz4740/Makefile
> index 89ce401..39d70bd 100644
> --- a/arch/mips/jz4740/Makefile
> +++ b/arch/mips/jz4740/Makefile
> @@ -5,7 +5,9 @@
>  # Object file lists.
> =20
>  obj-y +=3D prom.o time.o reset.o setup.o \
> -	gpio.o platform.o timer.o
> +	platform.o timer.o
> +
> +obj-$(CONFIG_MACH_JZ4740) +=3D gpio.o
> =20
>  CFLAGS_setup.o =3D -I$(src)/../../../scripts/dtc/libfdt
> =20
> diff --git a/arch/mips/jz4740/setup.c b/arch/mips/jz4740/setup.c
> index 1bed3cb..510fc0d 100644
> --- a/arch/mips/jz4740/setup.c
> +++ b/arch/mips/jz4740/setup.c
> @@ -83,6 +83,9 @@ arch_initcall(populate_machine);
> =20
>  const char *get_system_type(void)
>  {
> +	if (config_enabled(CONFIG_MACH_JZ4780))
> +		return "JZ4780";
> +
>  	return "JZ4740";
>  }
> =20
> diff --git a/arch/mips/jz4740/time.c b/arch/mips/jz4740/time.c
> index 9172553..7ab47fe 100644
> --- a/arch/mips/jz4740/time.c
> +++ b/arch/mips/jz4740/time.c
> @@ -102,7 +102,12 @@ static struct clock_event_device jz4740_clockevent=
 =3D {
>  	.set_next_event =3D jz4740_clockevent_set_next,
>  	.set_mode =3D jz4740_clockevent_set_mode,
>  	.rating =3D 200,
> +#ifdef CONFIG_MACH_JZ4740
>  	.irq =3D JZ4740_IRQ_TCU0,
> +#endif
> +#ifdef CONFIG_MACH_JZ4780
> +	.irq =3D JZ4780_IRQ_TCU2,
> +#endif
>  };
> =20
>  static struct irqaction timer_irqaction =3D {
> @@ -144,7 +149,7 @@ void __init plat_time_init(void)
> =20
>  	sched_clock_register(jz4740_read_sched_clock, 16, clk_rate);
> =20
> -	setup_irq(JZ4740_IRQ_TCU0, &timer_irqaction);
> +	setup_irq(jz4740_clockevent.irq, &timer_irqaction);
> =20
>  	ctrl =3D JZ_TIMER_CTRL_PRESCALE_16 | JZ_TIMER_CTRL_SRC_EXT;
> =20
>=20


--fUn7tfk0pI87QhIvV1DNRC7Wpu15XRq94
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVP2KRAAoJEGwLaZPeOHZ6SRYQALkmaNIpe0sMJQ5QgleZfMbN
cwyYy3qrCw+76I5g9Je23t6UZ4NsFumIBeuBHwYAqdN/ZNeOtCf44i1LkB0y/eQI
rEHZCLRxVvg8W7qXHz6Fdr2tLjfZF+NBmxrq1t/0gwU02s//NxQXrNOzIiRPzvuK
OYvgouH9l64BaWLWl9p7HFisVbf4LC2rIK4GVGGlM8v8w3hPx28GO+NA8GHm227r
sGkpO/t25GCRYsC27I+Nm/KhLeAb11XrhcI0dBBU8+PeFMgZf+RezppBk/JEeKVA
e80hwzkwSBGC6eiBYsd0qNlRtxwHpHBMs1SDHuRo2uVz/IYLCfVE4UoPUNrzdLmf
tosGS+cKyCVlZjUeiTf2Tt5oWR9ei1Wz83Faq2TFz+zQ33q+6Nh2ctzoPj2iftFm
RSJiKMy7WwGnrufnKHOGND71mCBjGtPW0ujE6UUeUp6OjTeeB8khiiiJX3VqLC0x
EsuLCEoNnubGnV/NKGzJe7EuZANCvvcQ/69DW2q1epV9iW17GXfK/zZJaYLryqTV
0MRI8GDnGPgrEu+OH0steE8u8+WWva46Pi3mkPO4/mKExeBAKADHRQlibPsxK++h
w7iwZdSkYnHlDYlVkpeLVpuxpKzZsEL4l07ix+4hmSnoBc9PSKWQdTuOfKYsQzX/
i5FhOMA03hegBlhICIxn
=fxcQ
-----END PGP SIGNATURE-----

--fUn7tfk0pI87QhIvV1DNRC7Wpu15XRq94--
