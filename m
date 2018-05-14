Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 11:26:54 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60966 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeENJ0qESpEC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 11:26:46 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7704921723;
        Mon, 14 May 2018 09:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526289999;
        bh=SEpO+m/sTrEyI0yQ9QVgsJWOD1iw88m7/kzjIHAFlGQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=bz6BOiwYiMiUOC0CHeo4j3jHEpFFGY45iyPmO4UcY+HjHvAWI56h2t5ycoKIrC7TS
         ThddLrkRx8ymvZ/R7Hx6sG7DjDm9C9WbhGFz1eLowl+xoOlEL7DkSvpMUZofaMwZKF
         Sx1Hwyym/IPOq3ZbEYu0l8FeVAIwnzbvpZRfhjLY=
Date:   Mon, 14 May 2018 10:26:34 +0100
From:   James Hogan <jhogan@kernel.org>
To:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>, linux-alpha@vger.kernel.org,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 2/4] um: Add generated/ to MODE_INCLUDE
Message-ID: <20180514092633.GA2419@jamesdev>
References: <cover.a2e1d7681cb1ff2808945fc00db5f29c2f011783.1526074770.git-series.jhogan@kernel.org>
 <d820cbb19a333cdfc4a24d0c6b2c3f09def1f3e5.1526074770.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="MW5yreqqjyrRcusr"
Content-Disposition: inline
In-Reply-To: <d820cbb19a333cdfc4a24d0c6b2c3f09def1f3e5.1526074770.git-series.jhogan@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63923
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


--MW5yreqqjyrRcusr
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 10:47:00PM +0100, James Hogan wrote:
> Add the um specific generated includes directory to MODE_INCLUDE so that
> asm/compiler.h can be used for overriding linux/compiler*.h which is
> included automatically, with um using a generated asm-generic wrapper at
> arch/um/include/generated/asm/compiler.h.
>=20
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: user-mode-linux-devel@lists.sourceforge.net

Hmm, I thought I'd fixed this, but again the kbuild test robot
complains:

On Sat, May 12, 2018 at 09:47:40AM +0800, kbuild test robot wrote:
> bisected to: aea47daf8a396e512e0cfe11d9c05798749db172  compiler.h: Allow =
arch-specific overrides
> commit date: 2 days ago
> config: um-x86_64_defconfig (attached as .config)
> compiler: gcc-7 (Debian 7.3.0-16) 7.3.0
> reproduce:
>         git checkout aea47daf8a396e512e0cfe11d9c05798749db172
>         # save the attached .config to linux build tree
>         make ARCH=3Dum SUBARCH=3Dx86_64
>=20
> All errors (new ones prefixed by >>):
>=20
>    In file included from arch/um/include/shared/init.h:44:0,
>                     from arch/um/kernel/config.c:8:
> >> include/linux/compiler_types.h:58:10: fatal error: asm/compiler.h: No =
such file or directory
>     #include <asm/compiler.h>
>              ^~~~~~~~~~~~~~~~
>    compilation terminated.
>=20
> vim +58 include/linux/compiler_types.h
>=20
>     56=09
>     57	/* Allow architectures to override some definitions where necessar=
y */
>   > 58	#include <asm/compiler.h>
>     59=09

Can anybody else reproduce that or have ideas why its still happening? I
don't seem to be able to.

Its from my mips-next-test branch here (that isn't in linux-next):
git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git

Cheers
James

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
uyMERIZ54Ir5VYFOntr3BfwPKy/ng8puAAA=

--3V7upXqbjpZ4EhLz--

--MW5yreqqjyrRcusr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvlWRgAKCRA1zuSGKxAj
8tvYAQDyW3oFO8o6V1FpwEDkcgafFKLAvgPBcQ0tW+aBXvH3hQEAwmBRwFalAVqW
tiy+HzQg1NVIBCIpXoaOPRK2UxtRrgQ=
=IZg4
-----END PGP SIGNATURE-----

--MW5yreqqjyrRcusr--
