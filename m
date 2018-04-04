Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Apr 2018 15:10:55 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991307AbeDDNKsGLMW5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Apr 2018 15:10:48 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 01BD821707;
        Wed,  4 Apr 2018 13:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01BD821707
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 4 Apr 2018 14:10:37 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Paul Cercueil <paul@crapouillou.net>,
        linux-mmc@vger.kernel.org, linux-mips@linux-mips.org,
        kernel@collabora.com
Subject: Re: [PATCH v4 15/15] MIPS: configs: ci20: Enable ext4
Message-ID: <20180404131036.GB25517@saruman>
References: <20180328210057.31148-1-ezequiel@collabora.com>
 <20180328210057.31148-16-ezequiel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FkmkrVfFsRoUs1wW"
Content-Disposition: inline
In-Reply-To: <20180328210057.31148-16-ezequiel@collabora.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63413
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


--FkmkrVfFsRoUs1wW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Mar 28, 2018 at 06:00:57PM -0300, Ezequiel Garcia wrote:
> Now that we have MMC support, enable ext2/3/4 support
> in the CI20 defconfig.
>=20
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Looks reasonable,

Acked-by: James Hogan <jhogan@kernel.org>

Thanks
James

--FkmkrVfFsRoUs1wW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrEzswACgkQbAtpk944
dnqAFg/7BcnbmtazPMPtGhc12EcIctGen8VANDN+AtnDu1zUIGT/ePYBZphC3+KR
pLLLG60BPpyWXWKB/3WIDCizmgLe4UUTQmCf00XCZTlwbDs2oi8/J+4bTMd+k2+0
3h7Nt6G0y/LKIxIBje10PY9JB8D4ljz0UPlLj+S1naVDcv1P7QfOCvD7qhy1J/qB
XQUuqU3dfHCA1t07whXLr83PLiCfDgqGYIolo6OAq7zMdWD9YR1U7xm+FkFM7Pv9
wo4PWogoCpvhM6XKAYI6aieyyhDKVcyHPFRiEeocFCQW4T+cgIpUqfXHZktdVivT
9pYZzZdMXIwt73drgM/f6PFanRi0fkJxF7UdU/Srbqz6jtGyslYVpraRLF+GbMke
UrpTkXFhKEC4sFBmNBWrN+l3W3Qi+EcPtfuFmPEV4CNUbpwGtuz5A580TH+etVaT
uL8u6i/24jlqulNYY+r0K16YTAzIBACnurQFdaRMbKhx84cZy9U0YjoEGi2wQb9j
PHqs9tDMupz/9fXNcmcqJIsJAQlhTjKjuRraYuWoLRP3kXUyAf6ICOgNafYezzBo
P5yuCQUgijjcb/cqBZzOGB46tcQe7xGx/1o/1KG4C2LAtdTBUweXhrU1Lq6yqp60
kBUD7OF13/x46NFg97lQhFyOvxxHC/yr49DAhHdQ85kWZ1cA0X4=
=z//k
-----END PGP SIGNATURE-----

--FkmkrVfFsRoUs1wW--
