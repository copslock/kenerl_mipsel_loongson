Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Feb 2018 16:31:59 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:33688 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994832AbeBAPbws7n7z (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 1 Feb 2018 16:31:52 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3A20A2178E;
        Thu,  1 Feb 2018 15:31:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A20A2178E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 1 Feb 2018 15:31:36 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Maarten ter Huurne <maarten@treewalker.org>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH v7 00/14] JZ4770 and GCW0 patchset
Message-ID: <20180201153135.GI7637@saruman>
References: <20180105182513.16248-2-paul@crapouillou.net>
 <20180116154804.21150-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FUaywKC54iCcLzqT"
Content-Disposition: inline
In-Reply-To: <20180116154804.21150-1-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62396
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


--FUaywKC54iCcLzqT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2018 at 04:47:50PM +0100, Paul Cercueil wrote:
> Hi Ralf,
>=20
> Here is the V7 of my JZ4770 and GCW0 patch series.
>=20
> What changed from V6:
> - In patch 10/14 I reverted a change that prevented the system
>   name/model from being correctly initialized
> - The patch dealing with the MMC DMA hardware issue has been dropped,
>   since we couldn't reproduce the corruption issue. I can always send a
>   separate patch if we find a way to reliably trigger the bug.
> - All the rest is untouched.

I've applied to my 4.16 branch.

Thanks
James

>=20
> Greetings,
> -Paul
>=20
>=20

--FUaywKC54iCcLzqT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlpzMs8ACgkQbAtpk944
dnqRVQ/9GBxyEYAzjZOTEUMe/66jfEdfioZSyrPrNR6d80N3tTDQsjCeu411WbRA
W6BcM6sHCG/PXTb0retna/JBMCAQW0Q3+PZ1RWjjZy7JAZ+hm1G42aJfyr7lXLBv
y9DduaI7/GKH3hRudv+eS/FN4DtpZSZRVb8UB7/++V3jREleHUTFeMLxXk4rt0qn
+oqQDz+gpq7SAVH3zd+fe/5pv6uuSID0SD0CGaoUOHHdeWdwr6OjJrcr4pvLjaeo
8o0Hgd7Zr9Wp0Pr8JyUR/z2D86AJ3WW6ZuYUM+Jsb+tUfvNSPLoNf6ArGFytdHaf
PQqgF6o98aJlOcIYfTfFaKaCnX1QMRUrkRca7Aed+mIb+SMqDIamwhFsgOJaxPq1
HFH2d9DQQpsQQjB/sCcslZGufW16QgbA7Ls+yF7HOEZQuqYhazxC7ZTQ7h21pmpq
ylr4kNWaDE2bFtXyrbD7TILz20jPKmXvLX8j2GlltHZsk21hqgfZht4Yd9e6m5Hx
7N4zF6PihKoz6/Dmq0igmiBWMfuQreCXPUz9hKqNURfpsgMZ0O9HRJwfa/K1Ld4/
opgLhjxp8xLBdpoCw1NqWgKYMMO1t4XIRcWXnHpxT9KaGspMSmWj3I4u78uL3IOP
FLKQ62RHkC83Bu1ddTFbgnTMujsplUEuOww8EvrtvL1+qvZogBs=
=DPLy
-----END PGP SIGNATURE-----

--FUaywKC54iCcLzqT--
