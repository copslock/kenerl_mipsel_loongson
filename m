Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 14:44:42 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992828AbeCANoeUBq4y (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Mar 2018 14:44:34 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 867E42177C;
        Thu,  1 Mar 2018 13:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 867E42177C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Mar 2018 13:44:02 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Ben Hutchings <ben@decadent.org.uk>
Cc:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        akpm@linux-foundation.org, Paul Burton <paul.burton@mips.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 3.16 091/254] MIPS: CPS: Fix r1 .set mt assembler warning
Message-ID: <20180301134401.GQ6245@saruman>
References: <lsq.1519831217.271785318@decadent.org.uk>
 <lsq.1519831218.652977295@decadent.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7kD9y3RnPUgTZee0"
Content-Disposition: inline
In-Reply-To: <lsq.1519831218.652977295@decadent.org.uk>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62764
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


--7kD9y3RnPUgTZee0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2018 at 03:20:18PM +0000, Ben Hutchings wrote:
> 3.16.55-rc1 review patch.  If anyone has any objections, please let me kn=
ow.
>=20
> ------------------
>=20
> From: James Hogan <jhogan@kernel.org>
>=20
> commit 17278a91e04f858155d54bee5528ba4fbcec6f87 upstream.

You'll want this too:

8dbc1864b74f5dea5a3f7c30ca8fd358a675132f
MIPS: CPS: Fix MIPS_ISA_LEVEL_RAW fallout

Its only tagged for stable 4.15 since the one it fixes wasn't tagged for
stable.

If you're going to select patches for backporting based on Fixes tags,
maybe its worth looking for patches which are marked as fixing ones
you've backported too.

Cheers
James

--7kD9y3RnPUgTZee0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqYA5oACgkQbAtpk944
dnoCAg/+KTDFkcVwtPk3I4VT7ZMasy/wlIdy+6qCZwo6ErA7Ao32wQoEUm5Mh5jw
0CH7F2+iSftl6SCZ0cASnq9EVkK5qSdqDmjh6rdeJQAGxaOaK9ybMPQBpK1URwoc
TlfJSAurtgwqL/QPsAwKJSrUjX0HInBlt0sl6+cpYW8ToocBQZhL4iKywyfyFKeB
ZB+0pNHDnDcpy8a10ju8iqfXNDebZRcEunD2SumDw3Ccn5t+mQ87ABpUwhX61G1J
KPPvLJcnQ77pa9/P7Gi4hE8m7VbhZcaRCcPBzaV7UaMHKWxnK07A4Qbp6uSMGS2G
z6YAtIMzbBdGdB9Yeu6iyVLrDUZMSU3ctRu7Vbyj1RwPmM2KJ0cUaoiaWFSbPGtX
3PdwI1RoWiFF23rBlxQLclY1KI0U8tvB7diWX89COoAbHksk7cCNJCkBz0W1q5YY
M1XTl3RLmboGQRmIms0mTSsv6N+KWL567I+02OsnzXyopQoM6fG3qf//InwmLHfQ
SoGgJWXAsnn+l4PDZQlNrH+N3VSibUavdIomWpLouBSX3mSY5loe5aK0LD7IP9T7
ZV53I3nwJb8Ev7oaKs/kGVZ/DSPsRS937NB+ps6UWgcafPZDH6cvd+MIVFCc8euJ
2IOooTEES12UEM65n0X+gzYbBjYJ5uVRPTFKwpxzh8Bt9BimLoE=
=zDIT
-----END PGP SIGNATURE-----

--7kD9y3RnPUgTZee0--
