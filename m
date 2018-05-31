Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2018 23:34:46 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:35072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994688AbeEaVeivOR2J (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 31 May 2018 23:34:38 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A9BC820890;
        Thu, 31 May 2018 21:34:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527802472;
        bh=05w7QQpg69n6ZE9kDkkh31th/hrDoC9I09kV5y/XFAs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K7b4h1MKtmGJOb8kxkfVrSc4YE/nMu5I1OnVj4XGjheZcybJ0SHbyw348QZbBhtkM
         SqJRUeXlZxVj6ot/G/hvFfgb+Vmiv4uHCVAu7dTK7ykEAE/17tg/+9EMa49vzvXw9C
         FY+2q+imb6fdkdSqBHd9c/wr+L3zjOVZFr+ZJBEE=
Date:   Thu, 31 May 2018 22:34:28 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Make FPU context layout comments match
 reality
Message-ID: <20180531213427.GC30406@jamesdev>
References: <alpine.DEB.2.00.1805141441260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805141441260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64139
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


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 15, 2018 at 11:03:09PM +0100, Maciej W. Rozycki wrote:
> Correct comments across ptrace(2) handlers about an FPU register context
> layout discrepancy between MIPS I and later ISAs, which was fixed with
> `linux-mips.org' (LMO) commit 42533948caac ("Major pile of FP emulator
> changes."), the fix corrected with LMO commit 849fa7a50dff ("R3k FPU
> ptrace() handling fixes."), and then broken and fixed over and over
> again, until last time fixed with commit 80cbfad79096 ("MIPS: Correct
> MIPS I FP context layout").
>=20
> NB running the GDB test suite for the relevant ABI/ISA and watching out=
=20
> for regressions is advisable when poking around ptrace(2).
>=20
> Signed-off-by: Maciej W. Rozycki <macro@mips.com>

Thanks, applied for 4.18.

Cheers
James

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWxBqYgAKCRA1zuSGKxAj
8uHhAPkBifAbPhcj+VwFhUXKfcLd0iMFaVBlPeVfEZKVvhX/zAEAoT/rQhvIvI3l
quwDvYFbs9EG4GGn3vzTiKCpt0zkCQA=
=P1yo
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
