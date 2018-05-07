Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 May 2018 22:17:14 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:44560 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994626AbeEGURHlcfeu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 7 May 2018 22:17:07 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B47E9204EE;
        Mon,  7 May 2018 20:16:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525724220;
        bh=DW7HsjpOIhzgI/Um3yfFKC+vKGK22tZeAH82NpHzn2c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RxhaI3WJ4ie5aNfvU5PRZCC7wkLehypz+QIbWFTfTgCiDFl0g7rF5F3zHVVqKniYw
         YQIkQpZSoPgKYtLkyarJHz2w4zUAYpWYN9OqpEw/uDFNeCsx10Fio0qUYCqmPLey+O
         u9Dc6qNjLja0dv8/g7mz4+ABERWFuD1xgYDSSAJk=
Date:   Mon, 7 May 2018 21:16:57 +0100
From:   James Hogan <jhogan@kernel.org>
To:     NeilBrown <neil@brown.name>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] MIPS: c-r4k: fix data corruption related to cache
 coherence.
Message-ID: <20180507201655.GA27369@jamesdev>
References: <87sh7klyhc.fsf@notabene.neil.brown.name>
 <20180425214650.GA25917@saruman>
 <87h8nzlzf1.fsf@notabene.neil.brown.name>
 <20180425220834.GC25917@saruman>
 <87vacdlf8d.fsf@notabene.neil.brown.name>
 <87lgcwcvj2.fsf@notabene.neil.brown.name>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="Qxx1br4bt0+wmkIi"
Content-Disposition: inline
In-Reply-To: <87lgcwcvj2.fsf@notabene.neil.brown.name>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63890
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


--Qxx1br4bt0+wmkIi
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 07:40:49AM +1000, NeilBrown wrote:
>=20
> Hi James,
>  this hasn't appear in linux-next yet, or in any branch
>  of
>    git://git.kernel.org/pub/scm/linux/kernel/git/jhogan/mips.git
>=20
>  Should I expect it to?

Sorry Neil, I haven't applied it yet. I'm planning to get a few fixes
sorted this week, at which point it would land in the mips-fixes branch
at the above repo.

Cheers
James

--Qxx1br4bt0+wmkIi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvC0NgAKCRA1zuSGKxAj
8oKRAPwK7fmohcud0fjIl2pvltDY4gpwo83BsYs92ho1OS55JgEAlVOso4iJX4X5
7NItreTsvuSUoS9uUB3be8tkG4FGKAk=
=y4bN
-----END PGP SIGNATURE-----

--Qxx1br4bt0+wmkIi--
