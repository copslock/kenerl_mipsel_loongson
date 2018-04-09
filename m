Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 22:42:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:41190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992121AbeDIUmlXR0Cn (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 22:42:41 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4FE9721785;
        Mon,  9 Apr 2018 20:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FE9721785
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 21:42:29 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Burton <paul.burton@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.9 173/293] MIPS: Handle tlbex-tlbp race
 condition
Message-ID: <20180409204229.GE17347@saruman>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
 <20180409002239.163177-173-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="0QFb0wBpEddLcDHQ"
Content-Disposition: inline
In-Reply-To: <20180409002239.163177-173-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63479
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


--0QFb0wBpEddLcDHQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:25:09AM +0000, Sasha Levin wrote:
> From: Paul Burton <paul.burton@imgtec.com>
>=20
> [ Upstream commit f39878cc5b09c75d35eaf52131e920b872e3feb4 ]
>=20
> In systems where there are multiple actors updating the TLB, the
> potential exists for a race condition wherein a CPU hits a TLB exception
> but by the time it reaches a TLBP instruction the affected TLB entry may
> have been replaced. This can happen if, for example, a CPU shares the
> TLB between hardware threads (VPs) within a core and one of them
> replaces the entry that another has just taken a TLB exception for.
>=20
> We handle this race in the case of the Hardware Table Walker (HTW) being
> the other actor already, but didn't take into account the potential for
> multiple threads racing. Include the code for aborting TLB exception
> handling in affected multi-threaded systems, those being the I6400 &
> I6500 CPUs which share TLB entries between VPs.
>=20
> In the case of using RiXi without dedicated exceptions we have never
> handled this race even for HTW. This patch adds WARN()s to these cases
> which ought never to be hit because all CPUs with either HTW or shared
> FTLB RAMs also include dedicated RiXi exceptions, but the WARN()s will
> ensure this is always the case.

=2E..

> +	/*
> +	 * If the CPU shares FTLB RAM with its siblings then our entry may be
> +	 * replaced at any time by a sibling performing a write to the FTLB.
> +	 */
> +	if (cpu_has_shared_ftlb_ram)

cpu_has_shared_ftlb_ram was only added in v4.13, commit e7bc8557428f
("MIPS: Add CPU shared FTLB feature detection"). To backport this patch
you'd need that one too at least (and I6500 support was also new in 4.13
so you'd also have to drop that case from the backport of that patch).

There may be other dependencies too, I don't know OTOH.

Cheers
James

--0QFb0wBpEddLcDHQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrL0DUACgkQbAtpk944
dnqzGxAAnk8FHAtfIuBnHAWn4zo52YiO17tEzqjop4yu1MSgmlzilTMq1ebc1ziz
raCU6EBUPfvHxPsI+hFZs1IzyyGwNCCuvNdXH5L99FK/fku1sLzMm1wTP3cCiVaF
5G8ysaeZedI+QA5DkyV3O32otpmmTCEauog6it0nNSuazQ4vGHlEMey0HfVPFTal
ssGDCUGrigjsg2zyHZ50UzWjpcxXLHwR6xtSiipi1s9K2tRp07Ivj4N2cMO/qNqW
/qEY7lwEwj1o+uKO1lVzwF/r9H6To0C+okmA3D/5E2YH4ZfL/w1RjBcZcxC2iabX
V5HS5A21j9kx5gnPPn3/ynJ/wigisOFZk8cPJehwsF2NYTLgWxFD+nOislhi5n3m
N6oCW2+g6E4qJCXWeJazJ2ooN/LZ4r4qEk/0EKzq+Bc8nYbr1mS1eTlVxC5/pAdZ
qAZWAvWNh3NCFqTWinue5o0903ddIdOZ3Ovy1/eiyO0Ln8pyZhdrpYxZdurAujL+
3fQxh/BwkSmtx6leX9brwE4QJNEzngmjWcqAVM46OHXGrTgLDr4Njt9kpHFItrKa
OIoB+Wp6iXFy9I4/XIcZuV+SUaIhv6C2LVxxMC9Vy7JVGoVA9Pvp2q3Zssa6fYob
TXwYhAIbdCtTjvtxlVT67GPvYMEoZSXxgR2o0AOg9z2+mf1UGHM=
=UWpd
-----END PGP SIGNATURE-----

--0QFb0wBpEddLcDHQ--
