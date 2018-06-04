Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jun 2018 22:13:01 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994661AbeFDUMyVhoja (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 4 Jun 2018 22:12:54 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66F2220845;
        Mon,  4 Jun 2018 20:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528143167;
        bh=5AtyzRELWiexrnbOIpFqp6aiaRnHT2jOgGYiiZnEuDU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GxG5N/hKwcUjdwQuf+joF6/xdKmRo2r1NmyIOq6pDupFsqvDvwOwVUjm0YPxEg+xr
         oYTezWCliJ3XhEtjp/SgCfvcjvfPWBA7G+owNmQt7ZKEV60YXH7SKc+vGIMBa6p4Fv
         ETzjkXWdXwGsKFfyZw0/FOz1GFSSK2vB5qY38pEw=
Date:   Mon, 4 Jun 2018 21:12:43 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Wolfram Sang <wsa@the-dreams.de>,
        Simon Guinot <simon.guinot@sequanux.org>,
        Paul Burton <paul.burton@mips.com>
Subject: Re: [PATCH] MIPS: pb44: Fix i2c-gpio GPIO descriptor table
Message-ID: <20180604201242.GA11664@jamesdev>
References: <20180526171251.7653-1-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="jI8keyz6grp/JLjh"
Content-Disposition: inline
In-Reply-To: <20180526171251.7653-1-linus.walleij@linaro.org>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64179
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


--jI8keyz6grp/JLjh
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, May 26, 2018 at 07:12:51PM +0200, Linus Walleij wrote:
> I used bad names in my clumsiness when rewriting many board
> files to use GPIO descriptors instead of platform data. A few
> had the platform_device ID set to -1 which would indeed give
> the device name "i2c-gpio".
>=20
> But several had it set to >=3D0 which gives the names
> "i2c-gpio.0", "i2c-gpio.1" ...
>=20
> Fix the one affected board in the MIPS tree. Sorry.
>=20
> Fixes: b2e63555592f ("i2c: gpio: Convert to use descriptors")
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Cc: Simon Guinot <simon.guinot@sequanux.org>
> Reported-by: Simon Guinot <simon.guinot@sequanux.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Ralf can you please apply this for MIPS fixes?

Thanks (and sorry this missed 4.17). Now applied.

Cheers
James

--jI8keyz6grp/JLjh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxWdOAAKCRA1zuSGKxAj
8t7BAQCwN8M+ecFypYeIfe2z3Ii1NGBx9u94MPPKnUUUJP0wkwEAgQmGZTR+g//w
yGiZjWZYWzk0Vzgnat2lwlCr5V64YAk=
=Jzxd
-----END PGP SIGNATURE-----

--jI8keyz6grp/JLjh--
