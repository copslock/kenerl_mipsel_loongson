Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2018 15:00:17 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44202 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990475AbeEXNALUtrAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 24 May 2018 15:00:11 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9244820899;
        Thu, 24 May 2018 13:00:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1527166804;
        bh=KNuP6EmkbB1lqGvuJ6MtBIFEI8sEIjbBP5QFO2pMT9c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rjt7Ty9XXdVvvpbdLjOXeUJl3tGiehXQ4c02FqbM9xz0n8qFWCSX5JqXMXFPaLL0G
         bJtmey6IUKNhkLOg6mRR965Rd3xqKmk1En8E0wJLojXZ2tQ0iCHCc7SIXBDqcUqXU0
         Een8gfc+Vb0/MoBxj/+rvtbD9UXg51zehWfPnvRs=
Date:   Thu, 24 May 2018 14:00:00 +0100
From:   James Hogan <jhogan@kernel.org>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: ptrace: Fix PTRACE_PEEKUSR requests for 64-bit FGRs
Message-ID: <20180524125959.GB24269@jamesdev>
References: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3uo+9/B/ebqu+fSQ"
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1805161306260.10896@tp.orcam.me.uk>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64007
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


--3uo+9/B/ebqu+fSQ
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

should that be 3.15+?

Cheers
James

--3uo+9/B/ebqu+fSQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWwa3TgAKCRA1zuSGKxAj
8sDvAP9b5xyZTvJTRL1ODiGao0nXlZE58CbdZGfh08Ld5eRiaAEAysXgF3YS4+nm
+cHSReh8L6LfjKCPbHrOsWEht17wgQY=
=+Mrn
-----END PGP SIGNATURE-----

--3uo+9/B/ebqu+fSQ--
