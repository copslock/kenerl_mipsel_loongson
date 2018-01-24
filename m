Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 12:59:12 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:40958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeAXL7GGTFi2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 12:59:06 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 011CB21778;
        Wed, 24 Jan 2018 11:58:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 011CB21778
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 11:58:34 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Huacai CHen <chenhc@lemote.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 2/4] MIPS: Loongson64: Yeeloong add platform driver
Message-ID: <20180124115833.GC5446@saruman>
References: <20171226032602.11417-1-jiaxun.yang@flygoat.com>
 <20171226032602.11417-3-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ghzN8eJ9Qlbqn3iT"
Content-Disposition: inline
In-Reply-To: <20171226032602.11417-3-jiaxun.yang@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62311
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


--ghzN8eJ9Qlbqn3iT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 11:26:00AM +0800, Jiaxun Yang wrote:
> diff --git a/drivers/platform/mips/yeeloong_laptop.c b/drivers/platform/m=
ips/yeeloong_laptop.c
> new file mode 100755

Checkpatch complains about having the execute permission set on this
file.

> +static int __init yeeloong_init(void)
> +{
> +	int ret;
> +
> +	if (mips_machtype !=3D MACH_LEMOTE_YL2F89) {
> +		pr_err("Unsupported system.\n");
> +		return -ENODEV;
> +	}
> +
> +	pr_info("Load YeeLoong Laptop Platform Specific Driver.\n");
> +
> +	/* Register platform stuff */
> +	ret =3D platform_driver_register(&platform_driver);
> +	if (ret) {
> +		pr_err("Fail to register yeeloong platform driver.\n");
> +		return ret;
> +	}
> +
> +	ret =3D yeeloong_backlight_init();
> +	if (ret) {
> +		pr_err("Fail to register yeeloong backlight driver.\n");
> +		yeeloong_backlight_exit();
> +		return ret;
> +	}
> +
> +	ret =3D yeeloong_bat_init();
> +	if (ret) {
> +		pr_err("Fail to register yeeloong battery driver.\n");
> +		yeeloong_bat_exit();
> +		return ret;
> +	}
> +
> +	ret =3D yeeloong_hwmon_init();
> +	if (ret) {
> +		pr_err("Fail to register yeeloong hwmon driver.\n");
> +		yeeloong_hwmon_exit();
> +		return ret;
> +	}
> +
> +	ret =3D yeeloong_hotkey_init();
> +	if (ret) {
> +		pr_err("Fail to register yeeloong hotkey driver.\n");
> +		yeeloong_hotkey_exit();
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static void __exit yeeloong_exit(void)
> +{
> +	yeeloong_hotkey_exit();
> +	yeeloong_hwmon_exit();
> +	yeeloong_bat_exit();
> +	yeeloong_backlight_exit();

I can't help thinking it would be better to separate this into separate
drivers for each part (backlight, power supply etc), and move them into
the appropriate driver directories (drivers/power/supply,
drivers/video/backlight etc). That way each part would get proper review
=66rom the appropriate maintainers (or at least they should be Cc'd).

Is there a particular reason for it to be a single driver?

Cheers
James

--ghzN8eJ9Qlbqn3iT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpodOkACgkQbAtpk944
dnoB9w//T+qJz5panBu4kxXfjC6aRQUMx2lhpR1zrBVMLfH9SaPGIDpGMVp2f+Ld
NcCcf9qQq5Bw3jOOG4ZDL5vNeZ5UMVxb6co7jc+yyAC2NJfVsxwrGyUHgVrMaNqq
Mma4VrshK9XhMmtOhLxnVg7+nLl3ghSJpAcwhT0l4xDnBiwsbv0/f85nzE1yWygQ
fPK2q/t3l0zlFls7z/x5lscTNiT4kTw5hymkpSbvu166b6wlQqPIJotsHGbGntCh
VQXwgBdcmDXW7dNNnu+ViVTsFu4HqzhZAjHlpqaQSvR83GTDmAUu0TNUZ1mjYkVH
MaU9jP5aC3uMLNI+wzxGR/gab4amgOND5dNGJUI/rz6XluOUJs0985DB6g84uLFf
5VGD8pcpoy8dcIb9Wh021e9A9RXnIaYQkIYe7TFPB1aPOLlUzxiReVX25PZtk4P/
gNGgwEuhFib1ROoQkzrsalhzwLuzxb3m0R5tNYmpSWEYMFmDBVIpCx2TPlfhiJcz
Mt5JoTmuHPILEgHBZeUCJbYRw0V8ZsthRMiC9Yy3q89YXfZzgmEgmYWHCp2xk6HA
kGJz4EtC9iLcnnmV/SdYLXQzqfqKLPCYMGV14cqPLtKT8x9+lYMXQGB5JS2z8IiV
+QZ8Kef3YQOu1dfj036mTXnYM/5H64b7g3natUgi+wJxqZr44H4=
=VKaJ
-----END PGP SIGNATURE-----

--ghzN8eJ9Qlbqn3iT--
