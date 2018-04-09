Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 22:08:57 +0200 (CEST)
Received: from mail.kernel.org ([198.145.29.99]:58714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992009AbeDIUIuFBjEv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Apr 2018 22:08:50 +0200
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5684521771;
        Mon,  9 Apr 2018 20:08:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5684521771
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 9 Apr 2018 21:08:38 +0100
From:   James Hogan <jhogan@kernel.org>
To:     Sasha Levin <Alexander.Levin@microsoft.com>
Cc:     "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: Re: [PATCH AUTOSEL for 4.14 043/161] MIPS: JZ4770: Work around
 config2 misreporting associativity
Message-ID: <20180409200838.GB17347@saruman>
References: <20180409001936.162706-1-alexander.levin@microsoft.com>
 <20180409001936.162706-43-alexander.levin@microsoft.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="tjCHc7DPkfUGtrlw"
Content-Disposition: inline
In-Reply-To: <20180409001936.162706-43-alexander.levin@microsoft.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63476
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


--tjCHc7DPkfUGtrlw
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 09, 2018 at 12:20:20AM +0000, Sasha Levin wrote:
> From: Maarten ter Huurne <maarten@treewalker.org>
>=20
> [ Upstream commit 1f7412e0e2f327fe7dc5a0c2fc36d7b319d05d47 ]
>=20
> According to config2, the associativity would be 5-ways, but the
> documentation states 4-ways, which also matches the documented
> L2 cache size of 256 kB.

JZ4770 support is new in 4.16, so no need for this to be backported.
More likely it'll just break the build due to references to
MACH_INGENIC_JZ4770.

Cheers
James

--tjCHc7DPkfUGtrlw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlrLyEYACgkQbAtpk944
dnoYMA/+J7j53fTTZktDcA/AEGAoibI48k1rSjXv9MM1kjjSPCEcbQFUbMdfLLpk
Wal+55kwJgfU8yLuEntBlHyWOUceGM9a9DGPulDLs97JPVy1yCB0RSzplbcE24aB
Euk4FaqvrEw4L3bDcmoQlL+TOSMdPhgyoAT5xDgDaFLAuMyK+r0KPDhTp+c0YlNn
qZWVlLRN+jYCL/3BCOISd1ab+feD4Gm4kckQGCkbg8SI4vJGrApHkpus6RdNzxtS
B9E36V96zrr24EHG1iOalR0IMI6XXTX7alYcUhCZEVb7lUTlvyUn527vJFh5Pxxx
CXeap6ODc3BPyFNXIE7qBgMMi74i3X0Mo0OTZJ/N3YexBEuhU+H9k+rb2co+0TJ2
AhFbsZcdgpo6xp19bwStpDZ2oyth5/EuJw1s+Q2OkgnEnvKh+RB+mCLkyX+QRpnQ
oDOz3Cn1um7VT4uO9oOM0Kq5u7xGgUnXUr9Ath6zcKqwaQNIdOHGz5fmFk3uncX3
o1UFjqUukb0of/NdtrunYrJ5Tj3OwmGRFTa8ihVB4NSCUApcez+9jqE1NvyQa+Uy
vw3FDZER8XsHXagVC73hmWp8lm4aDOK9IjD+CfwmSHKWDqisELbPexZtRwgbuTz1
GkE3QnqKu8lYqb+8mTtNzCmuu0sumT5RwRMUp6pSW78DPVeuKHI=
=izFW
-----END PGP SIGNATURE-----

--tjCHc7DPkfUGtrlw--
