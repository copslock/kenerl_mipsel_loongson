Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Mar 2015 15:22:30 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28212 "EHLO
        imgpgp01.kl.imgtec.org" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27014511AbbCXOW2lJqQ3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Mar 2015 15:22:28 +0100
Received: from imgpgp01.kl.imgtec.org (imgpgp01.kl.imgtec.org [127.0.0.1])
        by imgpgp01.kl.imgtec.org (PGP Universal) with ESMTP id DACC141F8DC6;
        Tue, 24 Mar 2015 14:22:23 +0000 (GMT)
Received: from mailapp01.imgtec.com ([10.100.180.241])
  by imgpgp01.kl.imgtec.org (PGP Universal service);
  Tue, 24 Mar 2015 14:22:23 +0000
X-PGP-Universal: processed;
        by imgpgp01.kl.imgtec.org on Tue, 24 Mar 2015 14:22:23 +0000
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id D37DE9EE381C8;
        Tue, 24 Mar 2015 14:22:20 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 24 Mar 2015 14:22:23 +0000
Received: from [192.168.154.110] (192.168.154.110) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Tue, 24 Mar
 2015 14:22:23 +0000
Message-ID: <5511731E.5000901@imgtec.com>
Date:   Tue, 24 Mar 2015 14:22:22 +0000
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] MIPS: Provide fallback reboot/poweroff/halt implementations
References: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
In-Reply-To: <1425513563-9897-1-git-send-email-abrestic@chromium.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="8DqxaToav45FrAW4OdvQ9cfRoeuXLw8gA"
X-Originating-IP: [192.168.154.110]
X-ESG-ENCRYPT-TAG: da4c5968
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46506
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

--8DqxaToav45FrAW4OdvQ9cfRoeuXLw8gA
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On 04/03/15 23:59, Andrew Bresticker wrote:
> If a machine-specific hook is not implemented for restart, poweroff,
> or halt, fall back to halting secondary CPUs, disabling interrupts,
> and spinning.  In the case of restart, attempt to restart the system
> via do_kernel_restart() (which will call any registered restart
> handlers) before halting.
>=20
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> ---
>  arch/mips/kernel/reset.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>=20
> diff --git a/arch/mips/kernel/reset.c b/arch/mips/kernel/reset.c
> index 07fc524..87b1f08 100644
> --- a/arch/mips/kernel/reset.c
> +++ b/arch/mips/kernel/reset.c
> @@ -29,16 +29,36 @@ void machine_restart(char *command)
>  {
>  	if (_machine_restart)
>  		_machine_restart(command);
> +
> +#ifdef CONFIG_SMP
> +	smp_send_stop();

Maybe local_irq_disable should be before smp_send_stop() to avoid
deadlocks (same below)?

See for example commit 44424c34049f41123a3a8b4853822f47f4ff03a2 ("ARM:
7803/1: Fix deadlock scenario with smp_send_stop()").

> +#endif
> +	do_kernel_restart(command);
> +	pr_emerg("Reboot failed -- System halted\n");

Perhaps we could have a grace period like ARM does here:

> /* Give a grace period for failure to restart of 1s */
> mdelay(1000);

Otherwise with this patch a reboot on Malta usually shows some/all of
this pr_emerg message prior to actually restarting. (Arguably thats a
failing of Malta's _machine_restart not to have a delay... thoughts?).

Cheers
James

> +	local_irq_disable();
> +	while (1);
>  }
> =20
>  void machine_halt(void)
>  {
>  	if (_machine_halt)
>  		_machine_halt();
> +
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif
> +	local_irq_disable();
> +	while (1);
>  }
> =20
>  void machine_power_off(void)
>  {
>  	if (pm_power_off)
>  		pm_power_off();
> +
> +#ifdef CONFIG_SMP
> +	smp_send_stop();
> +#endif
> +	local_irq_disable();
> +	while (1);
>  }
>=20


--8DqxaToav45FrAW4OdvQ9cfRoeuXLw8gA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBAgAGBQJVEXMfAAoJEGwLaZPeOHZ6PqAP/Rxq1S6l8nVG53O4RUoYxzyO
UNzZBUvG8nguTPMmdV4+Ss9DlWY1FrNZtA+tIXd4RRlGU/ShjFEJbKLYvUBctp6p
OevQNSkZF24LrHTTlrVP9v8OCEcR1UXGDs83N/batLGTMI7vSqO+McmR/Bzg5/P9
TyX3p9KO6deBLNlOCMt7b6bU/jV9xvYuZ3e4WJMreXCcGXYSJ/osV2aaXZnlZNNq
u8dq4TeYI/tfqGnJzBcA5psoAEyIhG0K2JRu4UuWfDOVvaEBPXRvehkmj/sPfGjY
qL6jVNJ0hAyoG0gnqoLjf4zp4wG0S/60h7MHADGycyKizoS/NnH8WXa3V4drrWly
6BbZoMZfiSw5NYZHtPUEuEX53nySqd4RfM7kqXY/4K2huoiSxqGDAlbchoFZiGqh
Ac0dva/eQByduM9+KwaNwInLCsVDFeNfvbn0uXLNdFSSED1wH6OxoYvK+C0UU0i9
GZGN9QhIb0UIui18JODhe0nBryFd62g4wnom7hn+kt7U7YEtkD8BjyzusaO6Ypkw
53MHR5wbxAonJBKdhN6pWA9ljAOV+cC+CJIfLWqwI7f6BKNYNUEV7Vd8apYEO3Bm
A8U/B69ybk+FKsMq1o2NtTl68on2OnsZ/3Zqh5+PgVR83EE/3Wxc0lFaTsmxwoFp
aUGG5wQdsEwbtKJnPeoA
=KVJ7
-----END PGP SIGNATURE-----

--8DqxaToav45FrAW4OdvQ9cfRoeuXLw8gA--
