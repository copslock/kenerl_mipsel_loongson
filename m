Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 22:43:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:47764 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994696AbeBTVnB6TniS (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 20 Feb 2018 22:43:01 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C2E7021795;
        Tue, 20 Feb 2018 21:42:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2E7021795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Tue, 20 Feb 2018 21:42:49 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V2 10/12] MIPS: Loongson: Make CPUFreq usable for
 Loongson-3
Message-ID: <20180220214248.GE6245@saruman>
References: <1517022752-3053-1-git-send-email-chenhc@lemote.com>
 <1517023381-17624-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <1517023381-17624-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62657
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


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Sat, Jan 27, 2018 at 11:22:59AM +0800, Huacai Chen wrote:
> Loongson-3A/3B support frequency scaling. But due to hardware
> limitation, Loongson-3A's frequency scaling is not independent for
> each core, we suggest enable Loongson-3A's CPUFreq only when there is
> one core online.

Does the code do anything to enforce that?

If not, should it?

Will it just work suboptimally if you tried?

>  arch/mips/include/asm/mach-loongson64/loongson.h |   1 +
>  arch/mips/kernel/smp.c                           |   3 +-
>  arch/mips/loongson64/Kconfig                     |   1 +
>  arch/mips/loongson64/common/platform.c           |  13 +-
>  arch/mips/loongson64/loongson-3/Makefile         |   2 +-
>  arch/mips/loongson64/loongson-3/clock.c          | 191 ++++++++++++++++++
>  drivers/cpufreq/Kconfig                          |  13 ++
>  drivers/cpufreq/Makefile                         |   1 +
>  drivers/cpufreq/loongson3_cpufreq.c              | 236 +++++++++++++++++++++++

This could presumably be fairly neatly divided into 3 separate changes:
- New clocks driver
- New cpufreq driver
- Minimal platform changes in arch/mips to instantiate the drivers

Please can you use the common clock framework i.e. a driver in
drivers/clk/, rather than adding yet another implementation of the clk
api in arch/mips/.

Each change needs the appropriate maintainers on Cc or you'll never get
the required review.

Cheers
James

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqMllIACgkQbAtpk944
dno6Ug//UmGffPuyqd5e9UPPfrbcnvHp2dtKJjgYxg/ch6OKUOIpm/jY3jzk6Ao+
u0AvpX212ScwDKtBIYhxf9zl9GZA5ZC797yXAhKkLVmNXYVhWecBf3cgtEwMlAFS
TYA3x7kJqQfUgEQ6XFDt+1kCtNv/DWK8Ab76iNv0Su4ttaysv6IQsFcuHiv298C0
J0kAS9PJ7+Oau2mdKZGJuFTCVm3TE5EgQxkYFwWE1IUvH+9yi47GEckELQQx+b+N
wFMEbaphuv6qCnzRMhXBC80pHjzb9/MAbPk0LuwhC9H4vX/pPFGFtCvyVAizCI8Y
X8cO7myWxx4ZT7LMFvV1m7eZ1jbiD0oNZwJq4bkL7iFy74wwW8g4WVBb/h29+zp4
mqjOcyYo2RQgNWnlnK7o0/qsAB7c+YKIR/0u3szR06FUsI6u5HSbL3QKsdmomZnd
y5Tgwo2bQ0HUnlebQBaSapGReBn6gtgoGQkS1cIDWRSlyTU7gfrt8NPvvuchlK8y
rBIlDMeUiKz+b4Cj9+XzW4jKiRCN4D4qnfzdUPOKUJ0kcclXJVA5XMe7rShlmqS3
zARVqCeJuv7uSmh5dL5Dn3EyGq+jwOZ11CmUwkrMlTzbJV0umeQAXP5jY6vaZQOc
f9VrSvaZ9TAafv7Y5bkQQuPxhLDUUhALn1cTqTRO7jq2evrLgfw=
=G1Yu
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
