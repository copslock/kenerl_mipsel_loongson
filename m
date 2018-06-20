Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 23:17:58 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:36262 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992992AbeFTVRvADrY3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2018 23:17:51 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7908220846;
        Wed, 20 Jun 2018 21:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529529464;
        bh=JaQLZwHRKB/x7C+ZikXJeDh6mobwqXfu4k3OBQ2DEPE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CLUVBUtT0TmcX10M5PuUHY5bm8Q0Ht1h8+ysQcYX9Xs4atEz9eRxZau6G3cg3ssFt
         P/Qx0JGdFu3WXvY+kQs2kWYLD/58hgBh7vRpfqv3VLD4h1eyER6YPI3OKnAu4+WIed
         iikleWzrpzMb6BqBE5ZsTolZiy3Wscz1Fa38Oh+o=
Date:   Wed, 20 Jun 2018 22:17:40 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH v2] MIPS: Wire up io_pgetevents syscall
Message-ID: <20180620211738.GA22606@jamesdev>
References: <20180615083543.GA7603@jamesdev>
 <20180620034615.17579-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="EVF5PPMfhYS0aIcm"
Content-Disposition: inline
In-Reply-To: <20180620034615.17579-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64399
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


--EVF5PPMfhYS0aIcm
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 19, 2018 at 08:46:15PM -0700, Paul Burton wrote:
> Wire up the io_pgetevents syscall that was introduced by commit
> 7a074e96dee6 ("aio: implement io_pgetevents").
>=20
> Signed-off-by: Paul Burton <paul.burton@mips.com>
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
>=20
> ---
> This will conflict with the rseq patches, but is trivial to fixup.
>=20
> Changes in v2:
> - Use compat_sys_io_pgetevents for o32 & n32 on MIPS64 kernels.

Thanks,

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--EVF5PPMfhYS0aIcm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyrEcgAKCRA1zuSGKxAj
8ioKAP9H5qC8U2Of6pPE9kdLj9DJYsOcvBOrmZbs28mG3pybiwD/djwmexTXmeDV
BXjbAsb1esKaQEDagX8NW/s+VYECuAM=
=KYJU
-----END PGP SIGNATURE-----

--EVF5PPMfhYS0aIcm--
