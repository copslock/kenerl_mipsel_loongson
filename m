Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2018 23:30:51 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:38478 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992992AbeFTVamS84NZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2018 23:30:42 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id DC9762083A;
        Wed, 20 Jun 2018 21:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1529530235;
        bh=GL024BYDuKB5hmShj++DiGt7r1jBEN/plNT6xSYhkRs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k/FxnWs86qlFU7KWmNL8st6I75TlQkMoXFCTTdHXLkyLKnls6LHvo748bYpfDBHVH
         UQhB8I05IEGXYVW8+Ewl8ykQJnAABECdaFfzmSSSZ2MV7UEwqFUsW9T/e6JUournxQ
         eIPMZIRdBdiqR19+liek44ipZ0etuG6vahjgNH+w=
Date:   Wed, 20 Jun 2018 22:30:32 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Paul Burton <paul.burton@mips.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Always use -march=<arch>, not -<arch> shortcuts
Message-ID: <20180620213031.GB22606@jamesdev>
References: <20180619003800.32129-1-paul.burton@mips.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="61jdw2sOBCFtR2d/"
Content-Disposition: inline
In-Reply-To: <20180619003800.32129-1-paul.burton@mips.com>
User-Agent: Mutt/1.10.0 (2018-05-17)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64400
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


--61jdw2sOBCFtR2d/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Mon, Jun 18, 2018 at 05:37:59PM -0700, Paul Burton wrote:
> Resolve this problem by using the long-form -march=<arch> in all cases,
> which makes it through the arch/mips/vdso/Makefile's filtering & is thus
> consistently used to build both the kernel proper & the VDSO.

Reviewed-by: James Hogan <jhogan@kernel.org>

Cheers
James

--61jdw2sOBCFtR2d/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWyrHdwAKCRA1zuSGKxAj
8npyAP0RzFBGeTPJZj/D0fvsIVlzI22crAdue8YHI3cj/Iw3iAD6Alxq7kqO+IAw
G8Izbv5PrBIYo8GnSFa7f7gZYPrkGw0=
=9y7k
-----END PGP SIGNATURE-----

--61jdw2sOBCFtR2d/--
