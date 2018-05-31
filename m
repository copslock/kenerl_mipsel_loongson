Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 23:30:15 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994688AbeEaVaIbIqDJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 23:30:08 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A80B220890;
        Thu, 31 May 2018 21:30:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527802201;
        bh=Vy2nIzyMSNLPsCeLMsX7X225soO5TlUCIhqk16jg6yc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gcHBk3OvfuDbrB581sY2LS7gtyDb8fxa6F469Q41tqZxRVtP1v3diIuwZmxiexJwE
         kd3uBFvWd/+1qeCAp5dvSPtSO+aifNpHc2URE+ZX1FmPRj72eqisPrp0LKte/r5UIS
         Qfv3gFLVdjZtd1KAVrwHKbRf+rsBG5xQxIIYa6dU=
Date:   Thu, 31 May 2018 22:29:57 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: prctl: Disallow FRE without FR with PR_SET_FP_MODE
 requests
Message-ID: <20180531212956.GA30406@jamesdev>
References: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141439290.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64137
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


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 11:04:44PM +0100, Maciej W. Rozycki wrote:
> Having PR_FP_MODE_FRE (i.e. Config5.FRE) set without PR_FP_MODE_FR (i.e.=
=20
> Status.FR) is not supported as the lone purpose of Config5.FRE is to=20
> emulate Status.FR=3D0 handling on FPU hardware that has Status.FR=3D1=20
> hardwired[1][2].  Also we do not handle this case elsewhere, and assume=
=20
> throughout our code that TIF_HYBRID_FPREGS and TIF_32BIT_FPREGS cannot=20
> be set both at once for a task, leading to inconsistent behaviour if=20
> this does happen.
>=20
> Return unsuccessfully then from prctl(2) PR_SET_FP_MODE calls requesting=
=20
> PR_FP_MODE_FRE to be set with PR_FP_MODE_FR clear.  This corresponds to=
=20
> modes allowed by `mips_set_personality_fp'.
>=20
> References:
>=20
> [1] "MIPS Architecture For Programmers, Vol. III: MIPS32 / microMIPS32
>     Privileged Resource Architecture", Imagination Technologies,
>     Document Number: MD00090, Revision 6.02, July 10, 2015, Table 9.69=20
>     "Config5 Register Field Descriptions", p. 262
>=20
> [2] "MIPS Architecture For Programmers, Volume III: MIPS64 / microMIPS64=
=20
>     Privileged Resource Architecture", Imagination Technologies,=20
>     Document Number: MD00091, Revision 6.03, December 22, 2015, Table=20
>     9.72 "Config5 Register Field Descriptions", p. 288
>=20
> Cc: stable@vger.kernel.org # 4.0+
> Fixes: 9791554b45a2 ("MIPS,prctl: add PR_[GS]ET_FP_MODE prctl options for=
 MIPS")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Thanks, applied to mips-fixes, hopefully for 4.17 (but if it misses
tomorrows linux-next it may have to wait 'til 4.18).

Cheers
James

--u3/rZRmxL6MmkK24
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBpUwAKCRA1zuSGKxAj
8nD+AQDlX/YPX/WyufbGvOmzQO3ows5pmEBYDLTntCMjLwfQLAEA9ODc1Qt8srfM
nrZ+PcIffTYPGEghVp1HHUcl1GHBqwU=
=UY2D
-----END PGP SIGNATURE-----

--u3/rZRmxL6MmkK24--
