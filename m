Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 23:09:27 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:56312 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992096AbeBOWJSNphfO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 23:09:18 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62902217B6;
        Thu, 15 Feb 2018 22:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62902217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 22:09:07 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-mips@linux-mips.org,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "David S. Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Subject: Re: [PATCH v3 2/3] MIPS: crypto: Add crc32 and crc32c hw accelerated
 module
Message-ID: <20180215220906.GM3986@saruman>
References: <cover.a1aaa0593f5afd4b00e8131611adda3a02c060d1.1518214143.git-series.jhogan@kernel.org>
 <77eab2cb46e52be3639610a7ad574bac7bf78d73.1518214143.git-series.jhogan@kernel.org>
 <20180215083316.GA5212@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="3FyYKcuUbgqNYeqV"
Content-Disposition: inline
In-Reply-To: <20180215083316.GA5212@gondor.apana.org.au>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62566
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


--3FyYKcuUbgqNYeqV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15, 2018 at 04:33:16PM +0800, Herbert Xu wrote:
> Acked-by: Herbert Xu <herbert@gondor.apana.org.au>
=20
Thanks Herbert,

Series applied for 4.17.

Cheers
James

--3FyYKcuUbgqNYeqV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqGBQEACgkQbAtpk944
dnqEZRAAjnjfHOoS6pBCLP9V9wfgaKnfSdtpd3wFfZ/2JK5JKnfQPHxfs+m+M77f
cDj43/Bb2EACzDz/K7lJQTH2NRArdjafpku608LQVzS9Hli06+pigZKgfBVMy3NY
nRZmuGP55d11m7rhAp/qm6HZtZZAp69QmwR0WmlVMaGZkYU3IyFlpsLJdBgdKmWU
HnPy00Huc96DWILJ7RInWbzi+wHD7m6IEwyGzYt+wgeKjp9e/K4Y3Q3RBFi7f/vE
9QWH0Ta4hJTAkCMTzQ+eY+1tIIlk5NjSGI4OPuxSMPuLBt3Ik1fofVkP4gEb/iQi
6CxHjyZ6Y/f1Pz1fYllfyk1w25qT6OPIduQ31YTsWJiwjsxfeLnjwfU+RhH3ce+S
Z0Hmt2znSkuPLebtECaSOJ3yXgExf1KhtRAt/7pf/mX6Iwj1SiFLn7eseUdD+HU9
HGhhjwtwTZa8Bvixh/Yl8ccUK6R5daMnpXQckLcMaygKsOtoTBHtJJraMq2QJ3h9
mUSnHzG6iMAsLpFN9+6h1qbQ/riSGfdSNgazOmIqTM0ykPPYh9u04vXhNtSGAwOM
JXKKm7g++cmuDaMLT5G38yUwjiy9jSObHJvJFYw+1fiO1CklwGH237twZQnNana3
tXtmV83Co41FHrZIWwED0DLSmfYWSp/gZVArsngT1Vu2dy64OAU=
=M69k
-----END PGP SIGNATURE-----

--3FyYKcuUbgqNYeqV--
