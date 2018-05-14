Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 00:37:34 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:36454 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENWh0xTJNU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2018 00:37:26 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E9BB21723;
        Mon, 14 May 2018 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526337440;
        bh=CI6DZF33lBYIVAFSXy9A44er/xLU/P2oRM7sMW8iz0w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0ZaiXcWD3F8OUUDpRMDPAF58CJhhPOyKvGy75jZixpeBXCnnd3kpwit7AnFhf/qIP
         yo8yDfgRZFLb6KrRD+AdEmbVnsHxkAi5/BGW4jr8eXZ4p2KrrBiPSzG/e7uMfU07Ox
         +AbR6FR9dAy1i6UM9fLEev1nHJ+lbEFMZ3Ek4c7c=
Date:   Mon, 14 May 2018 23:37:16 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix ptrace(2) PTRACE_PEEKUSR and PTRACE_POKEUSR
 accesses to o32 FGRs
Message-ID: <20180514223715.GE29541@jamesdev>
References: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="BQPnanjtCNWHyqYD"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141537210.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63958
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


--BQPnanjtCNWHyqYD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 14, 2018 at 04:49:43PM +0100, Maciej W. Rozycki wrote:
> Check the TIF_32BIT_FPREGS task setting of the tracee rather than the=20
> tracer in determining the layout of floating-point general registers in=
=20
> the floating-point context, correcting access to odd-numbered registers=
=20
> for o32 tracees where the setting disagrees between the two processes.
>=20
> Cc: stable@vger.kernel.org # 3.14+
> Fixes: 597ce1723e0f ("MIPS: Support for 64-bit FP with O32 binaries")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Hi,
>=20
>  These are not the usual requests used by GDB to access the floating-poin=
t=20
> context, which is likely why it went unnoticed so long.  They are only=20
> used as a fallback in the case where PTRACE_GETFPREGS and PTRACE_SETFPREG=
S=20
> requests are not supported, i.e. with ancient kernels.
>=20
>  However to verify an unrelated GDB bug fix I have tweaked GDB to always=
=20
> use PTRACE_PEEKUSR and PTRACE_POKEUSR, and then discovered this issue in=
=20
> native GDB regression testing, as it showed regressions from corrupt FGR=
=20
> contents across numerous tests compared to the usual results.  This fix=
=20
> removed those regressions then.
>=20
>  Not being typically used does not mean we ought to keep the interface=20
> broken.  Therefore please apply.

Looks good. Applied to fixes branch for 4.17.

Thanks
James

--BQPnanjtCNWHyqYD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoPmgAKCRA1zuSGKxAj
8vHgAQCWxOnS4xlCHH+ctDoJS88qeXWE6ojQ4iM0LlzCyfNKrAEAo6VvdB1DEWg1
tBq1rCXSUbUnkg+qpV7h9T1CG5N1Cgc=
=df5g
-----END PGP SIGNATURE-----

--BQPnanjtCNWHyqYD--
