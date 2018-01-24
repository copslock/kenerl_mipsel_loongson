Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Jan 2018 22:48:24 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:55034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990474AbeAXVsQPUwPi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Jan 2018 22:48:16 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D182B21717;
        Wed, 24 Jan 2018 21:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D182B21717
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 24 Jan 2018 21:47:43 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>, stable@vger.kernel.org
Subject: Re: [PATCH 3/8] MIPS: Ensure pmd_present() returns false after
 pmd_mknotpresent()
Message-ID: <20180124214742.GJ5446@saruman>
References: <1502330433-16670-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-1-git-send-email-chenhc@lemote.com>
 <1502330682-16812-2-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="5cSRzy0VGBWAML+b"
Content-Disposition: inline
In-Reply-To: <1502330682-16812-2-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62321
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


--5cSRzy0VGBWAML+b
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 10, 2017 at 10:04:37AM +0800, Huacai Chen wrote:
> This patch is borrowed from ARM64 to ensure pmd_present() returns false

I presume you're referring to commit 5bb1cc0ff9a6 ("arm64: Ensure
pmd_present() returns false after pmd_mknotpresent()"). I think it would
be worth mentioning that specifically.

> after pmd_mknotpresent(). This is needed for THP.
>=20
> Cc: stable@vger.kernel.org

Back to what version? 3.8 when THP was added?

Otherwise it looks reasonable:
Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/include/asm/pgtable-64.h | 5 +++++
>  1 file changed, 5 insertions(+)
>=20
> diff --git a/arch/mips/include/asm/pgtable-64.h b/arch/mips/include/asm/p=
gtable-64.h
> index 67fe6dc..a2252c2 100644
> --- a/arch/mips/include/asm/pgtable-64.h
> +++ b/arch/mips/include/asm/pgtable-64.h
> @@ -271,6 +271,11 @@ static inline int pmd_bad(pmd_t pmd)
> =20
>  static inline int pmd_present(pmd_t pmd)
>  {
> +#ifdef CONFIG_MIPS_HUGE_TLB_SUPPORT
> +	if (unlikely(pmd_val(pmd) & _PAGE_HUGE))
> +		return pmd_val(pmd) & _PAGE_PRESENT;
> +#endif
> +
>  	return pmd_val(pmd) !=3D (unsigned long) invalid_pte_table;
>  }
> =20
> --=20
> 2.7.0
>=20
>=20
>=20
>=20

--5cSRzy0VGBWAML+b
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpo/v4ACgkQbAtpk944
dnrkBg//aueYrO2f/dLcawtIl0v+kNhLGcLd1Ibhk85nuq9R5RQ5IiUmYq/go+0A
20B4izQN4h3WhQPF7P1y5A9WC6L7SM9qkwnAAyhImbYYdBBL/7HfRZydPUy2vWp1
yjt6n4yOLXH1urTlLLd39PQz4hProTc0WHgsMQW1t+bT8Kr9cCcvdiLMF3Fv//py
HcGYwpW4kJWxB1zuDXaQLo/vVPlG/kw81eFKWnKNCuH2P8BWtHeiWxZdOwi0AIBA
it3zvmPD2eU6ahghmQnJzS23FSwDdzY7Lr9WaqMyQjXVR/ibhbDbyyyO86zl/rZs
C9vO9u2h/hkz7oji4zRjuAY7EHhk+y3JAsCEBAGKzyPV8k43iA3apW4ZOycVjTNg
o/pv3rrKhhHGBYh0XIP4rhV4lYZELZjDTcKO/nch2UETvO224mpFRAlPijxvaQuJ
hqsBQxpFKHFuQl7RnAH9foUn5QtzBruUrtkN32BCyME2m3AOe00dXvB8/sn6lnnD
6OgEalvrgMwdrW8GZ0mnUYx30Ru2o+KrEyMT7f52d2g06QhFt7z/2INNd96o77ER
Sj5lcfRJsPVZH+77yAcTF7aDHY+f18DSUFOtje94g7OCUukqm3zVzx20ST3i95Vr
O/GHm8fjFQ+1hboYKX/0OBbl7L58RgBFrm2NA7EauQK1ftlJ7CE=
=ZBCM
-----END PGP SIGNATURE-----

--5cSRzy0VGBWAML+b--
