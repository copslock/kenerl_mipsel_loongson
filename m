Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 22:13:02 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:60142 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992009AbeDIUMx6IcXv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 22:12:53 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 31ADE21771;
        Mon,  9 Apr 2018 20:12:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31ADE21771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 21:12:42 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.15 048/189] clk: ingenic: Fix recalc_rate
 for clocks with fixed divider
Message-ID: <20180409201242.GC17347@saruman>
References: <20180409001637.162453-1-alexander.levin@microsoft.com>
 <20180409001637.162453-48-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="lCAWRPmW1mITcIfM"
Content-Disposition: inline
In-Reply-To: <20180409001637.162453-48-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63477
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


--lCAWRPmW1mITcIfM
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:17:24AM +0000, Sasha Levin wrote:
> From: Paul Cercueil <paul@crapouillou.net>
>=20
> [ Upstream commit e6cfa64375d34a6c8c1861868a381013b2d3b921 ]
>=20
> Previously, the clocks with a fixed divider would report their rate
> as being the same as the one of their parent, independently of the
> divider in use. This commit fixes this behaviour.
>=20
> This went unnoticed as neither the jz4740 nor the jz4780 CGU code
> have clocks with fixed dividers yet.

FYI this one isn't strictly necessary for backport since JZ4770 support
is new in 4.16, but its probably harmless too.

Cheers
James

--lCAWRPmW1mITcIfM
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLyToACgkQbAtpk944
dnqnABAAoXM5BPPPtuK//G4tlXF/zFL83WJr6nFQ5NjhueEyvO8j9pNK+Q4mL4Mr
wQSGY9v+1Sy5MIXgD0dRPdCadvza2GeTm7Futg+B2i/co9FQt/sprV1gMogrVVO7
0GeyXcak7LRVL8hnwEgMwMXrgOjsTXYsZqAAGllwI2A9UiTGMtjxlatbMlDzGmOY
eEal+Yja9Sf1R28VAk2Xw3YKtrD5WQ8MGg88gzxz7pvUkmFAdb27XJLf4PVZn7kM
lMO/KH8R+pmln5XfLspx2NZQOuqPuVMT4LYx69fkM8ZZhQHryo79mKnSRvWTEpr3
OqLmfqfzW2lF5rN8+135ePt+E2oZ07k36YI5jG00RaXmrrSibY0osQQH/vP2yT1n
2mpEod89Wdt+PqKSbM6B5+96YgejEsZBBFqyZXp7mvKf/4FQRRlCGVv/requayT9
ACreXW+XPdbWm8Ib/Ps/1x/yEl5/lWDc35qEWO3ZaJFAjUrOsN8MHRlBE2B8xblE
9lx649jtjb2eKHqbesPSRSU4aWhGJhcpp7hHOsJ78j6PMEP44Q/FvEB64+n5YsVW
z5hKIkKZTa6xJ3bv5eE8p7v+F4YJYd1TA2raNjef6AtssBSxIr0dq71HS+5cfTbH
jCLyIfLeFfHs1XyzUBCNNNQM5v/IvW14P+pLgYyhVk77O7FmwCk=
=K9v0
-----END PGP SIGNATURE-----

--lCAWRPmW1mITcIfM--
