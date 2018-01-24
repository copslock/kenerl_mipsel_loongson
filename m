Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 23:14:47 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56668 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbeAXWOkuXy7i (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 23:14:40 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9AC4521778;
        Wed, 24 Jan 2018 22:14:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AC4521778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 22:14:09 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 4/8] MIPS: Add __cpu_full_name[] to make CPU names more
 human-readable
Message-ID: <20180124221408.GK5446@saruman>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-3-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pWJxWxNlJUNgDlXi"
Content-Disposition: inline
In-Reply-To: <1502330682-16812-3-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62322
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


--pWJxWxNlJUNgDlXi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 10:04:38AM +0800, Huacai Chen wrote:
> In /proc/cpuinfo, we keep "cpu model" as is, since GCC should use it
> for -march=3Dnative. Besides, we add __cpu_full_name[] to describe the
> processor in a more human-readable manner. The full name is displayed
> as "model name" in cpuinfo, which is needed by some userspace tools
> such as gnome-system-monitor.
>=20
> The CPU frequency in "model name" is the default value (highest), and
> there is also a "CPU MHz" whose value can be changed by cpufreq.
>=20
> This is only used by Loongson now (ICT is dropped in cpu name, and cpu
> name can be overwritten by BIOS).
>=20
> Signed-off-by: Huacai Chen <chenhc@lemote.com>

> diff --git a/arch/mips/kernel/proc.c b/arch/mips/kernel/proc.c
> index 70604c7..3200c0e 100644
> --- a/arch/mips/kernel/proc.c
> +++ b/arch/mips/kernel/proc.c

> @@ -62,6 +63,11 @@ static int show_cpuinfo(struct seq_file *m, void *v)
>  	seq_printf(m, fmt, __cpu_name[n],
>  		      (version >> 4) & 0x0f, version & 0x0f,
>  		      (fp_vers >> 4) & 0x0f, fp_vers & 0x0f);
> +	if (__cpu_full_name[n])
> +		seq_printf(m, "model name\t\t: %s\n", __cpu_full_name[n]);
> +	if (mips_cpu_frequency)
> +		seq_printf(m, "CPU MHz\t\t\t: %u.%02u\n",
> +		      mips_cpu_frequency / 1000000, (mips_cpu_frequency / 10000) % 100=
);

long line

> diff --git a/arch/mips/loongson64/common/env.c b/arch/mips/loongson64/com=
mon/env.c
> index 1e8a955..6891780 100644
> --- a/arch/mips/loongson64/common/env.c
> +++ b/arch/mips/loongson64/common/env.c

> @@ -151,6 +154,10 @@ void __init prom_init_env(void)
>  	loongson_sysconf.nr_nodes =3D (loongson_sysconf.nr_cpus +
>  		loongson_sysconf.cores_per_node - 1) /
>  		loongson_sysconf.cores_per_node;
> +	if (!strncmp(ecpu->cpuname, "Loongson", 8))
> +		strncpy(cpu_full_name, ecpu->cpuname, sizeof(cpu_full_name));
> +	if (cpu_full_name[0] =3D=3D 0)
> +		strncpy(cpu_full_name, __cpu_full_name[0], sizeof(cpu_full_name));

long line

Otherwise this looks reasonable I think:
Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--pWJxWxNlJUNgDlXi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlppBTAACgkQbAtpk944
dnplExAArB5INPKS7Kc3WP+Hgo1BzaWWaVrxpRtBLtufYNXBMRbabKjW5AdTtF9O
W6GJ1zBUQ5jIfWljYIPr/82HtxBou/QRuZ3mHq2bhrr/SZQQsBUTM9lhqgazE+I8
Ioykb2S1pS+n4G13OvO8bBBsM9sAnPBOLf9x7k7+ubtamg/2PohC7C5DfHOy+K9l
mLvpoqCuUFpLqEa77QHi7h/m2pzbM929j0uh5gmGOWSFjvOL4zGismznvV1BUcwW
sGTao8GSnwKnN8c4sI8Urmz3paSfurbqNHBDhZzih/6hvQxu5wv/oxcSezQqHhlX
Zsmw15qFTGrr7VNzxW8McdM3v3q8JsRFuCTFKYbgwXKWggjAJe2bBhpVzwX5t/z6
ld7kwUyCHT/tVzfkxLjnORi9WJ92XK+PcOwJcq/dlHw5XkS7nUkH+TbUXlyfsLC/
un4qIEQPRG2QaYSH3JPWJZklAjFwRA46cllG1tkJKLjpaqzGwqyRc32xxlg0P3L5
oHq7JyKn7jOQGkvEdloYMy88P3yJKD8i6EcqIJAXeyzDc+GyNSbaE4FJP0WRkCaH
EVQpU+rG+nzhUQHur7dQXkRbOMT8M8T3ZQrvY6/h1iF/NTY7/ztdlHZRGkc4ksjq
SJSl90pJ8mwBF+Y0YrJhS4QnW7I/3qlPGOEnbKO6Yl8Tu3tFq/g=
=CGo8
-----END PGP SIGNATURE-----

--pWJxWxNlJUNgDlXi--
