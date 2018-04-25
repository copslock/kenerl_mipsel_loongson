Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Apr 2018 00:02:38 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60892 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994611AbeDYWCbmqTDn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Apr 2018 00:02:31 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 612DD21748;
        Wed, 25 Apr 2018 22:02:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 612DD21748
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 25 Apr 2018 23:02:21 +0100
From:   James Hogan <jhogan@kernel.org>
To:     gregkh@linuxfoundation.org
Cc:     alexander.levin@microsoft.com, linux-mips@linux-mips.org,
        matt.redfearn@mips.com, paul.burton@mips.com, ralf@linux-mips.org,
        stable-commits@vger.kernel.org
Subject: Re: Patch "MIPS: generic: Fix machine compatible matching" has been
 added to the 4.14-stable tree
Message-ID: <20180425220221.GB25917@saruman>
References: <1524582066147140@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8GpibOaaTibBMecb"
Content-Disposition: inline
In-Reply-To: <1524582066147140@kroah.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63790
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


--8GpibOaaTibBMecb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 05:01:06PM +0200, gregkh@linuxfoundation.org wrote:
> We now have a platform (Ranchu) in the "generic" platform which matches

The reason I didn't tag stable was because Ranchu was added in 4.16 ...

>  	if (!mach->matches)
>  		return NULL;

=2E.. so mach->matches will always be NULL before 4.16 ...

> =20
> -	for (match =3D mach->matches; match->compatible; match++) {
> +	for (match =3D mach->matches; match->compatible[0]; match++) {

=2E.. so this can't get hit.

Feel free to drop, otherwise it does no harm, its dead code.

Cheers
James

--8GpibOaaTibBMecb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuD67QAKCRA1zuSGKxAj
8sjoAQCFqYkF5eNlKg0sR93RTtJSkCaO+eV6yhZ/tRgONsOwNwEApiJh1GxMKJIA
OkTaSFoxYZZvYqkNY9MxNHxWCaIKsgI=
=b5O0
-----END PGP SIGNATURE-----

--8GpibOaaTibBMecb--
