Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 May 2018 00:24:26 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:35138 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992684AbeENWYT3YWLq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 15 May 2018 00:24:19 +0200
Received: from jamesdev (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D622021726;
        Mon, 14 May 2018 22:24:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1526336652;
        bh=C648gIeUino6JRzM5qJmZr6SliIaOzzE4lMeSPEgylI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QmHWVixhZYWVirZ/4UhiViGWlqkym52fgOn4hFh5IbqzsJ8zUFlXsiyRHavMnOpCe
         cvxc74GJhee1VfufauIFQ1Ng/uAzitOAz6TJE+B/BDpZ06ksvjXNTqbFWv55u4i+me
         ffbeqcYbtCgnyv86sRb7hAz1/7jWjUnqOtBDA05c=
Date:   Mon, 14 May 2018 23:24:09 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] mips: xilfpga: stop generating useless dtb.o
Message-ID: <20180514222408.GD29541@jamesdev>
References: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ylS2wUBXLOxYXZFQ"
Content-Disposition: inline
In-Reply-To: <20180425211036.28509-1-alexandre.belloni@bootlin.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63957
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


--ylS2wUBXLOxYXZFQ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 25, 2018 at 11:10:35PM +0200, Alexandre Belloni wrote:
> a dtb.o is generated from nexys4ddr.dts but this is never used since it h=
as
> been moved to mips/generic with commit b35565bb16a5 ("MIPS: generic: Add =
support
> for MIPSfpga")
>=20
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

Both applied for 4.17, with fixes and stable tag (4.15+).

Thanks
James

--ylS2wUBXLOxYXZFQ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEARYIAB0WIQS7lRNBWUYtqfDOVL41zuSGKxAj8gUCWvoMhwAKCRA1zuSGKxAj
8o5LAQCx99mPrHSF2UBUh4EWfEwNe3GSj/KUwchBE35anQSupAD/X02T1X+hD3p2
a1svYX02j994T1mH5L2jnjticVbuugI=
=8vL4
-----END PGP SIGNATURE-----

--ylS2wUBXLOxYXZFQ--
