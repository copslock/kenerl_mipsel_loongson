Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2018 08:25:16 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:41224 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990409AbeENGZI0htFc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2018 08:25:08 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D4A62184B;
        Fri, 11 May 2018 22:17:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526077048;
        bh=ZrdxgBec1toodlXsSYWrEkkoZ9D01aVukBHdmI2VnQM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cag2zSJghj4rAGY8pBX6uaFyKbg5Rrfv/29JSBgUBo3BiHZBqbCoNxozeZqzyCWMB
         p6cG2PwzI5jFCRp56GFozQE2R3a9yh4+/9qZAEkV6STevhoIH3CH5KVWcgyLM0vMQL
         fowCoI9vAbNcIt3Vx0VgvJM0qiUjzgs/dhRSY82U=
Date:   Fri, 11 May 2018 23:17:24 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ptrace: expose FIR register through FP regset
Message-ID: <20180511221723.GC20355@jamesdev>
References: <alpine.DEB.2.00.1804301510100.11756@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="vOmOzSkFvhd7u8Ms"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1804301510100.11756@tp.orcam.me.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63916
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


--vOmOzSkFvhd7u8Ms
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 30, 2018 at 03:56:47PM +0100, Maciej W. Rozycki wrote:
> Correct commit 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")=20
> and expose the FIR register using the unused 4 bytes at the end of the=20
> NT_PRFPREG regset.  Without that register included clients cannot use=20
> the PTRACE_GETREGSET request to retrieve the complete FPU register set
> and have to resort to one of the older interfaces, either PTRACE_PEEKUSR=
=20
> or PTRACE_GETFPREGS, to retrieve the missing piece of data.  Also the=20
> register is irreversibly missing from core dumps.
>=20
> This register is architecturally hardwired and read-only so the write
> path does not matter.  Ignore data supplied on writes then.
>=20
> Cc: stable@vger.kernel.org # v3.13+
> Fixes: 7aeb753b5353 ("MIPS: Implement task_user_regset_view.")
> Signed-off-by: James Hogan <james.hogan@mips.com>
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Looks good, applied for 4.17.

Thanks for cleaning & submitting this :)

Cheers
James

--vOmOzSkFvhd7u8Ms
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvYWcgAKCRA1zuSGKxAj
8jHbAPwKPV3zZ3xQ8iU8BIT1DKTp2MEF22z1ERxpaHFy4YeIzwEA2mVIMs32Qj6C
VxMQ3RC2QrdX5zfROPHA+WXa3YrZxwE=
=j+0l
-----END PGP SIGNATURE-----

--vOmOzSkFvhd7u8Ms--
