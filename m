Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 May 2018 11:20:44 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:33508 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991783AbeEDJUgqAsmw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 May 2018 11:20:36 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 667A821707;
        Fri,  4 May 2018 09:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1525425630;
        bh=TIa+i7gHBzFUjJX1gmePv7hWd4kl069PY+LIJnV8ESk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfjKhmu7fG20nHO+3+Me3qDWB8+sumSW8jPBC0pfq2uveGb2kPBHmKiexL2HVdUDt
         elpHS5qTIT5bWOIKo+QnoPlIonagAWRatTZ+2x7ZumyE/Shxt2V1BGGdbWA7fDDxZQ
         5w+K3BRAPHLKqv/Lcy2aRsKy3IzaHN6KhW+Z/mnY=
Date:   Fri, 4 May 2018 10:20:26 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>
Subject: Re: Git repo status?
Message-ID: <20180504092025.GA29286@jamesdev>
References: <d87d4d71-c77d-71bd-e5e3-a66518a6e969@gentoo.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tKW2IUtsqtDRztdT"
Content-Disposition: inline
In-Reply-To: <d87d4d71-c77d-71bd-e5e3-a66518a6e969@gentoo.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63863
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


--tKW2IUtsqtDRztdT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 03, 2018 at 07:24:27PM -0400, Joshua Kinard wrote:
>=20
> Any one know when linux-4.16 might be sync'ed to the linux-mips.org main =
git
> repo?  Or is there an alternate official repo I can clone to mess around =
with?

If the MIPS stable branches aren't being actively maintained (I'm not
really sure what their purpose was tbh) it may be better to stick to
the official kernel.org stable branches:

git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git

I try and get fixes backported there, though if there are issues do let
us know.

Cheers
James

--tKW2IUtsqtDRztdT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWuwl0wAKCRA1zuSGKxAj
8pXjAQDCFO8CCQgAjPZCRP3gUqxF56BWhdfG5RgSTft8bBMBxwD/VI8xYXsdwgAd
Gv1NhviSC4iXcyOLm7nzWJ26prGIWAs=
=Cwja
-----END PGP SIGNATURE-----

--tKW2IUtsqtDRztdT--
