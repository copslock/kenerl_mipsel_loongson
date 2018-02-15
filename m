Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Feb 2018 23:17:37 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:57730 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990656AbeBOWR3w-aOO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 15 Feb 2018 23:17:29 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EB485217B6;
        Thu, 15 Feb 2018 22:17:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB485217B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 15 Feb 2018 22:17:18 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Joe Perches <joe@perches.com>
Cc:     linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: Fix logging messages with spurious periods
 after newlines
Message-ID: <20180215221717.GO3986@saruman>
References: <ac33924a3e39541330e8f008f3ad0fbda74845d6.1512543855.git.joe@perches.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="XVTPT6MZt3zd/C+/"
Content-Disposition: inline
In-Reply-To: <ac33924a3e39541330e8f008f3ad0fbda74845d6.1512543855.git.joe@perches.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62568
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


--XVTPT6MZt3zd/C+/
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 05, 2017 at 11:04:58PM -0800, Joe Perches wrote:
> Using a period after a newline causes bad output.
>=20
> Signed-off-by: Joe Perches <joe@perches.com>

Applied for 4.17,

Thanks
James

--XVTPT6MZt3zd/C+/
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqGBu0ACgkQbAtpk944
dnqCSA/+LvMOmchhHoEefzYbReb/HtaViYODVwXjk14uMRnw7dujDivXPvMoE3B0
u4ZoTYYlua73EWgorwI+4AoFbd9+/WL49L7RBOMwA3ZS2OXor79nSG4RPl3q17h3
n5wx6BxR77oaeRrTP5sg9XIr+/olAl+fk3CBt2WUnTW0Nvcl55T5O99uXHyuUpor
bH6Y+AF90BAzN0z+C5T1eTjmlhvwmhYSNRDIZ9t2O1JzPmuU5GbvzTbdpzp9xm8S
ZEzV1576LYPYOUqGtQ45GuYKUX1kETxa3N9VGSzjWkXNXFYCGFDoYAPq9/PSl0Fv
x+EJOYtQB9jRupTprlBTds3GmXP56HcDMgR5O5E9XuJfyphrfEwWT7JKYYAd7bZC
OAUkAadaIERRTMLpi7X7wGBTleiFHJ3PM9BhMwyk+65ATJ2Lyb0MZ/CMDMwBqua8
FLPLMf+vYOY8xgLd2sD88lmDdqpnNyq5+NAF+1sA4b0wI4eM1y9VSMO6g6WhBwiq
knt0v/KmaPIViW9WqnbNSi2gVA0XCXVwvm8/7bLDwTlWMH6blstzCAfFyQKZCYvf
3e05PvsGnu4dJx/MFKwg+o9bTHpg5yMGR7cJTg23QLmwkvVl44zMAoU7441417NA
nITwre7Qr93gKA+9ik9HuGRiWg7TJKeqBL1V+lzJcgjYgmyoDAM=
=8qR7
-----END PGP SIGNATURE-----

--XVTPT6MZt3zd/C+/--
