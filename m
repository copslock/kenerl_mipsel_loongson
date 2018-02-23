Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Feb 2018 10:52:43 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:46000 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990431AbeBWJwejImbl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 23 Feb 2018 10:52:34 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 495C3217A3;
        Fri, 23 Feb 2018 09:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 495C3217A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Fri, 23 Feb 2018 09:52:21 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: ath25: check for kzalloc allocation failure
Message-ID: <20180223095220.GK6245@saruman>
References: <20180222175012.11076-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mPOSj6iWmtyhwOMz"
Content-Disposition: inline
In-Reply-To: <20180222175012.11076-1-colin.king@canonical.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62704
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


--mPOSj6iWmtyhwOMz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2018 at 05:50:12PM +0000, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
>=20
> Currently there is no null check on a failed allocation of board_data,
> and hence a null pointer dereference will occurr.  Fix this by checking
> for the out of memory null pointer.
>=20
> Fixes: a7473717483e ("MIPS: ath25: add board configuration detection")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to my fixes branch with 3.19+ stable tag.

Thanks
James

--mPOSj6iWmtyhwOMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqP5FQACgkQbAtpk944
dno/kg/+OdLgQEiQPu+8he69/Y2ZIDSfdIn9mblJXoYxnbpS5YaSMK/fPvSizNQ6
8x+n0VkGC5FgNLd7dTfQOFiP18Z5jv0f0nPzrBKMhK7PF7Zm1+KS8nLspvWjxdbE
NzDs8xnNF5tu9LCT/WTh/PeSJUCqMG/nbCbZ9XSZ0wM4F9A989kG4AgHQkCiHdsA
U0Sw7vOouFUboMWYzv+jWBjOGYVU7LvtyGcBkhsbKfhuKJmhqKV4NCasEmrGUMFB
rjMYvUa5orbGkGX93WbuuFFybDV2Z8HOW+QidvPi7GezbyhI4nq+iM0/wEPe2FZe
KS8zwnS6Pdqm8H/YtA37onKOl39mlAyOh2tFbjBZ6PusAKnPh5SPBpLCDzXwKoGD
Nb0kfhT4zbEEbu8MvIOFMnTkfD7sxzE9+h+ZK5LfQiK+csOOIVYJ3F+UMm8I7pJD
jRS9BnqO4MGea9Fkn5VIgXZ1hyRQ+DSqt/42BsrtgGSuiqRoB//+4T1y9aPLOpHj
1Q3yXaqYoG5GznU38ioHGPzQAlA9Ho5zK0xetkUXjwIx8y3a4Fhy7TTEkUzUkz1v
j8fX41yNlkSB6NdVlYv8yMS98qLVYGGbFOqLvT+tUcbpZoa6Dtxl/UD6CpwtpTD3
Gqj3p+bsxcTSbJS0gXHSl3lbdRtOWbsjXwM0TUmKUzqAaJOoY6k=
=R+XB
-----END PGP SIGNATURE-----

--mPOSj6iWmtyhwOMz--
