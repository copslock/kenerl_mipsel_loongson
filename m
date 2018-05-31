Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 23:31:08 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994689AbeEaVa7ffA3J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 23:30:59 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6895A20890;
        Thu, 31 May 2018 21:30:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527802253;
        bh=M83U+mg6b4zfKjNq+uHW6GhSJ5ZOcbIPEeQkTW9Qtjc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TGt2RK3/QAKYYKXuMWsqBMGCrS3jpfFnc8GQulKZMb/Oyoo1NZVQUQhM1V8/NkhWY
         54zEA+OaDcqDh1Sx4RGUIJa9Bdk4l8E0XGVfAtoGB2NSh20Lo9VF9kLmjmwDTICWnH
         pVywsqvypE8nchEMh0Ni+s/7xiIwfdNcKWPhSKzQ=
Date:   Thu, 31 May 2018 22:30:49 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <20180531213048.GB30406@jamesdev>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="kXdP64Ggrk/fb43R"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64138
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


--kXdP64Ggrk/fb43R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 16, 2018 at 04:39:58PM +0100, Maciej W. Rozycki wrote:
> Use 64-bit accesses for 64-bit floating-point general registers with=20
> PTRACE_PEEKUSR, removing the truncation of their upper halves in the=20
> FR=3D1 mode, caused by commit bbd426f542cb ("MIPS: Simplify FP context=20
> access"), which inadvertently switched them to using 32-bit accesses.
>=20
> The PTRACE_POKEUSR side is fine as it's never been broken and continues=
=20
> using 64-bit accesses.
>=20
> Cc: <stable@vger.kernel.org> # 3.19+
> Fixes: bbd426f542cb ("MIPS: Simplify FP context access")
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>
> ---
> Hi,
>=20
>  Here's another one, spotted in the course of GDB PR gdb/22286 regression=
=20
> testing with the n64 ABI.  Please apply.
>=20
>   Maciej

Thanks, applied to mips-fixes, hopefully for 4.17 (but if it misses
tomorrows linux-next it may have to wait 'til 4.18).

Cheers
James

--kXdP64Ggrk/fb43R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBphwAKCRA1zuSGKxAj
8iD3AP9Kj0BRdIaIbiXcXrM2jUI27Svyt9XAdqcE4bEn5glHfwD+OUSfWsfkAm7B
DqzpiLqWGXrVIXqBXEtySES+p92FVgI=
=88k4
-----END PGP SIGNATURE-----

--kXdP64Ggrk/fb43R--
