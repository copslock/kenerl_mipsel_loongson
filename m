Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Apr 2018 23:04:39 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:57292 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994652AbeDQVEbg5v0s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Apr 2018 23:04:31 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C3CB12178F;
        Tue, 17 Apr 2018 21:04:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3CB12178F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 17 Apr 2018 22:04:18 +0100
From:   James Hogan <jhogan@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@01.org, linux-mips@linux-mips.org,
        Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v3 2/3] compiler.h: Allow arch-specific overrides
Message-ID: <20180417210416.GB21386@saruman>
References: <cbf1a73e1c751fc8db124f974e268bab0d9727a5.1523959603.git-series.jhogan@kernel.org>
 <201804180342.6jrQJ6v3%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="rJwd6BRFiFCcLxzm"
Content-Disposition: inline
In-Reply-To: <201804180342.6jrQJ6v3%fengguang.wu@intel.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63593
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


--rJwd6BRFiFCcLxzm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

Hi kbuild test robot,

On Wed, Apr 18, 2018 at 03:19:47AM +0800, kbuild test robot wrote:
>    In file included from ./arch/x86/include/generated/asm/compiler.h:1:0,
>                     from include/linux/compiler_types.h:58,
>                     from <command-line>:0:
> >> include/asm-generic/compiler.h:2:2: error: #error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."
>     #error "Please don't include <asm/compiler.h> directly, include <linux/compiler.h> instead."

Whoops, I love your bug report.

I'll change asm-generic/compiler.h to look for __LINUX_COMPILER_TYPES_H
instead of __LINUX_COMPILER_H and resend soon.

Thanks!
James


--rJwd6BRFiFCcLxzm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrWYVAACgkQbAtpk944
dnpItBAAufXUFwYhH2lz7N2GEw1Z23twrtCeSRcrq65r2wEcMizH6taYASGvNoww
tmaKoXz+9oQQqvK1/4MSXMotkNYkVSe+MoGXnXU4x+v3dLsAiKG433SJKi65g97S
jsEr+nWlGJMBFyD/zbLjYpCwKcx4fAqyR02VVQs87ChO1uaHE33LrK5pYpqLCqud
1/tkeoP61zIE42fhEsXvS7Mw+5VDIGksPWuiMfpsxpsOek/tOhfDF2dDLFWK3gz6
OUnL33pma+ocv+MP3+g1lI3PGqPSB+k4D3BYpLM7sQUNcFrr0qI/5gC8cc7QRuo8
bGj36DXnYO6pqkWbHoiZC+PkelL+CcBj/aYlM/pKUr/84J9A1QX+6slsmgbtcQQT
wUnsPtSrRnZw0/BbilsGPE9BakF8epbnB5u+mu7Fp4VAMgiKd/b1VKZ2M740dpqM
UODP5v/CxSE4YGVHTx8TDutciODzbOcJu7mvogRw+QufVHX6GKvcdl/CU6ezGZuM
LXzT+W7YRlLZ8X0/0JopD0mcDMc8Oglr3W3ilkG/pYa09vFHwW6KmeeFqBw4XSOT
gxdk0QUahi7wo2+to2zxAfky0FT06Vzxx0tXP3x+nXTL52D+CMQtGacZPEpDnTn6
+gnkisuFdngBdb0YB0UGDzY8zoLfjzdA7X38v9U91vLHizWxgWU=
=ROKm
-----END PGP SIGNATURE-----

--rJwd6BRFiFCcLxzm--
