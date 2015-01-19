Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 12:25:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:23224 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27010943AbbASLZupsWfs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 12:25:50 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id 3283641F8E54;
        Mon, 19 Jan 2015 11:25:45 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.242])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Mon, 19 Jan 2015 11:25:45 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Mon, 19 Jan 2015 11:25:45 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6BE5ACE94ADAB;
        Mon, 19 Jan 2015 11:25:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 11:25:44 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Mon, 19 Jan
 2015 11:25:43 +0000
Message-ID: <54BCE9B1.7060600@imgtec.com>
Date:   Mon, 19 Jan 2015 11:25:37 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        <linux-mips@linux-mips.org>
CC:     Qais Yousef <qais.yousef@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH] MIPS: cevt-r4k: Use Cause.TI for timer pending
References: <1420729599-22034-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1420729599-22034-1-git-send-email-james.hogan@imgtec.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="hckIqkbNjrh3KKfRTnVO1kGQlvganTRTx"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: b93fcccb
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45301
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

--hckIqkbNjrh3KKfRTnVO1kGQlvganTRTx
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 08/01/15 15:06, James Hogan wrote:
> The cevt-r4k driver used to call into the GIC driver to find whether th=
e
> timer was pending, but only with External Interrupt Controller (EIC)
> mode, where the Cause.IP bits can't be used as they encode the interrup=
t
> priority level (Cause.RIPL) instead.
>=20
> However commit e9de688dac65 ("irqchip: mips-gic: Support local
> interrupts") changed the condition from cpu_has_veic to gic_present.
> This fails on cores such as P5600 which have a GIC but the local
> interrupts aren't routable by the GIC, causing c0_compare_int_usable()
> to consider the interrupt unusable so r4k_clockevent_init() fails.
>=20
> The previous behaviour wasn't really correct either though since P5600
> apparently supports EIC mode too, so lets use the Cause.TI bit instead
> which should be present since release 2 of the MIPS32/MIPS64
> architecture. In fact multiple interrupts can be routed to that same CP=
U
> interrupt line (e.g. performance counter and fast debug channel
> interrupts), so lets use Cause.TI in preference to Cause.IP on all core=
s
> since release 2.
>=20
> Fixes: e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Andrew Bresticker <abrestic@chromium.org>
> Cc: Qais Yousef <qais.yousef@imgtec.com>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/kernel/cevt-r4k.c      | 20 +++++++++++++++-----
>  drivers/irqchip/irq-mips-gic.c   |  8 --------
>  include/linux/irqchip/mips-gic.h |  1 -
>  3 files changed, 15 insertions(+), 14 deletions(-)
>=20
> diff --git a/arch/mips/kernel/cevt-r4k.c b/arch/mips/kernel/cevt-r4k.c
> index 6acaad0480af..6747a2cbf662 100644
> --- a/arch/mips/kernel/cevt-r4k.c
> +++ b/arch/mips/kernel/cevt-r4k.c
> @@ -11,7 +11,6 @@
>  #include <linux/percpu.h>
>  #include <linux/smp.h>
>  #include <linux/irq.h>
> -#include <linux/irqchip/mips-gic.h>
> =20
>  #include <asm/time.h>
>  #include <asm/cevt-r4k.h>
> @@ -85,10 +84,21 @@ void mips_event_handler(struct clock_event_device *=
dev)
>   */
>  static int c0_compare_int_pending(void)
>  {
> -#ifdef CONFIG_MIPS_GIC
> -	if (gic_present)
> -		return gic_get_timer_pending();
> -#endif
> +	/*
> +	 * With External Interrupt Controller (EIC) mode (which may be presen=
t
> +	 * since release 2 of MIPS32/MIPS64) the interrupt pending bits
> +	 * (Cause.IP) are used for the interrupt priority level (Cause.RIPL) =
so
> +	 * we can't use it to determine whether the timer interrupt is pendin=
g.
> +	 *
> +	 * Instead lets use the timer pending bit (Cause.TI) which is present=

> +	 * since release 2, and lets use it even without EIC mode since it
> +	 * unambigously specifies whether the timer interrupt is pending
> +	 * regardless of what other internal or external interrupts are wired=
 to
> +	 * the same CPU IRQ line.
> +	 */
> +	if (cpu_has_mips_r2)
> +		return read_c0_cause() & CAUSEF_TI;

Hmm, just realised that the code below already handles this case
equivalently thanks to per_cpu_trap_init doing the slightly sneaky:
if (cpu_has_mips_r2)
	cp0_compare_irq_shift =3D CAUSEB_TI - CAUSEB_IP;

I'll drop the cpu_has_mips_r2 conditional here, add a comment, and repost=
=2E

Cheers
James

> +
>  	return (read_c0_cause() >> cp0_compare_irq_shift) & (1ul << CAUSEB_IP=
);
>  }
> =20
> diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-=
gic.c
> index 2b0468e3df6a..e58600b1de28 100644
> --- a/drivers/irqchip/irq-mips-gic.c
> +++ b/drivers/irqchip/irq-mips-gic.c
> @@ -191,14 +191,6 @@ static bool gic_local_irq_is_routable(int intr)
>  	}
>  }
> =20
> -unsigned int gic_get_timer_pending(void)
> -{
> -	unsigned int vpe_pending;
> -
> -	vpe_pending =3D gic_read(GIC_REG(VPE_LOCAL, GIC_VPE_PEND));
> -	return vpe_pending & GIC_VPE_PEND_TIMER_MSK;
> -}
> -
>  static void gic_bind_eic_interrupt(int irq, int set)
>  {
>  	/* Convert irq vector # to hw int # */
> diff --git a/include/linux/irqchip/mips-gic.h b/include/linux/irqchip/m=
ips-gic.h
> index 420f77b34d02..e6a6aac451db 100644
> --- a/include/linux/irqchip/mips-gic.h
> +++ b/include/linux/irqchip/mips-gic.h
> @@ -243,7 +243,6 @@ extern void gic_write_cpu_compare(cycle_t cnt, int =
cpu);
>  extern void gic_send_ipi(unsigned int intr);
>  extern unsigned int plat_ipi_call_int_xlate(unsigned int);
>  extern unsigned int plat_ipi_resched_int_xlate(unsigned int);
> -extern unsigned int gic_get_timer_pending(void);
>  extern int gic_get_c0_compare_int(void);
>  extern int gic_get_c0_perfcount_int(void);
>  #endif /* __LINUX_IRQCHIP_MIPS_GIC_H */
>=20


--hckIqkbNjrh3KKfRTnVO1kGQlvganTRTx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJUvOm3AAoJEGwLaZPeOHZ6AQYP/RsYm9KVcXJqYB/Fis6HZPlw
gB/2+dHnHmWG4bQ7AZHyXPAsM7OUXWlSgmHK11A/teQvUhLsVSIvkXavTGogYxaN
v03n/ocBsF8XStYk0xq5B3WMahzXQMXTWJbipXgZhGtvwjYGqAHuyyePHa0EzlED
rftJNic1S+lJOJHxS8clg/syfLZTuoS98Yi8MlWmH/7kAv94FIOfsUeQsWrHTOXm
UgmkWBJ0tVgadIahTDtazTnZzFVpZr+yORDWajv1t7EexxlKIAo2kbOIebImIjoM
NmZcTfCqPg1jd9Yp4vCBgg5h850VWahCOsd6jVl70M2ys8xG9r1uXuE7zYmpLDmr
yiJ3nlNqdNCsI6w1x1Q85j/8mS3s2Y9w374gxDXmN1ZnBmCOuSzcQ7zj293uIKjE
+dJw8vDlOY/alLJ4wdaZmGCiEws1u+Nk1QHh0GlVCG44KKGZXzmGs/1dR+IEqx8B
15XixruGIlXMQ1jtrcJxF9kYYYoBKAn2whAxTesBtlSRLUjhOqOSgKRbsnsWzq2E
075a7iKqwVCApdiavqY/dyQqDh4+fMfUC6vFiQGIKMJief8Vt5okSLtCh4dPrNnw
HD+Jh1j7Bfkr1U0o8MErL7qDARQPOp0eKzZLVIfOAiL57wk7rz9ORm61VxumKJpZ
81bKsGVzM8Q3el40CMd2
=8n5r
-----END PGP SIGNATURE-----

--hckIqkbNjrh3KKfRTnVO1kGQlvganTRTx--
