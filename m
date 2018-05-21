Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2018 18:39:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:37460 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994699AbeEUQjoVnL9I (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 21 May 2018 18:39:44 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9675020853;
        Mon, 21 May 2018 16:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526920778;
        bh=JUrffgIJ23nwUJZ6xqHytVuugToynzpjTFb1L3lqknU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nDLsTs3Nyt8PfAxfTgorAwYBiZ4M2YiCaEau1ztvVspBoOUlG3ynulCJd8T1G1Zag
         3UBY9XUareFkFm0rBch0GwfBhW1UGrWoNTylI286bauze1xjDN/vMvde5bfQpX2XfO
         NVjPjyUBRL1ieNegTODx8ye/lFThicOqbcqaecg8=
Date:   Mon, 21 May 2018 17:39:33 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Mathias Kresin <dev@kresin.me>
Cc:     john@phrozen.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, martin.blumenstingl@googlemail.com,
        hauke@hauke-m.de, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: lantiq: gphy: Drop reboot/remove reset asserts
Message-ID: <20180521163932.GA12779@jamesdev>
References: <1523176203-18926-1-git-send-email-dev@kresin.me>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
In-Reply-To: <1523176203-18926-1-git-send-email-dev@kresin.me>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63994
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


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 08, 2018 at 10:30:03AM +0200, Mathias Kresin wrote:
> While doing a global software reset, these bits are not cleared and let
> some bootloader fail to initialise the GPHYs. The bootloader don't
> expect the GPHYs in reset, as they aren't during power on.
>=20
> The asserts were a workaround for a wrong syscon-reboot mask. With a
> mask set which includes the GPHY resets, these resets aren't required
> any more.
>=20
> Fixes: 126534141b45 ("MIPS: lantiq: Add a GPHY driver which uses the RCU =
syscon-mfd")
> Cc: stable@vger.kernel.org # 4.14+
> Signed-off-by: Mathias Kresin <dev@kresin.me>

Applied for 4.17. Thanks for the acks/reviews folk!

Thanks
James

--J2SCkAp4GZ/dPZZf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwL2PgAKCRA1zuSGKxAj
8rK8AP0SVYNW7NEA13xPomDmbyz2GyrZgOSsEOtpLYO1Q9nJfQD/TP6iEOWkftpf
ZVv9xJSbsuXgiteRcmpW1dId20KZVwc=
=Z5bm
-----END PGP SIGNATURE-----

--J2SCkAp4GZ/dPZZf--
