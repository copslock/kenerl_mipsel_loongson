Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Mar 2018 20:24:29 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:51042 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990406AbeCVTYWPnQ2o (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Mar 2018 20:24:22 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A93092177B;
        Thu, 22 Mar 2018 19:24:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A93092177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Thu, 22 Mar 2018 19:24:11 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: SSL certificate of linux-mips.org have been expired
Message-ID: <20180322192410.GI13126@saruman>
References: <1521729033.6120.6.camel@flygoat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="uJWb33pM2TcUAXIl"
Content-Disposition: inline
In-Reply-To: <1521729033.6120.6.camel@flygoat.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63156
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


--uJWb33pM2TcUAXIl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 22, 2018 at 10:30:33PM +0800, Jiaxun Yang wrote:
> Hi MIPS maintainers:
>=20
> SSL certficete of linux-mips.org have been expired. Either wiki or
> patchwork can't be reached for now. Please renew the certificate,
> thanks.
>=20
> Btw: Is Ralf still maintaining these servers? I havn't seen him for a
> long time.

Yes, Ralf maintains the server. I mentioned it to him by email yesterday
after he emailed me, so hopefully it'll be sorted soon.

Cheers
James

--uJWb33pM2TcUAXIl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlq0AtQACgkQbAtpk944
dnqCCw/+K6iJj0sL/bIlJeHSd9Ih7iiW3Hx8FjajMjZzp5vl357PnAvuge6e/Sup
zt5u2SLfosER/bElD+lwRY1btYu4zpaGyBm+KGM05MkcH7T0AUc0mJ+00v4o5Fav
O1o6arP49iEIRNyENzRQ4afIXFciwgga4BWH5jpqPQTYzTGfGxTbn6ACKu2B3kdp
gL9HIG0YoqzGRqJsQHehD6iex7avMTQuQ9bvUULI94DGLEULQ8Ljgz0FcKmoD3is
mVhYL84iZ1Q/N3so1qo+05tYtzm0BZ+fdLZLVWcrGzEciBGzYrglcjj/sI9tcaT2
HP0tH+Q2EhB/Vvi/J3wa0DJKhG5NzV+EQALDAMj5kTn4A/BWShxZ4o2sxScqze1U
XdzpO9h2nwdHcO904ug+Mxn7hDvejR2qaL6D51LeZ4fsyIFvYGdB7OxJ5sp6QPBP
JXPiF5kOyqZv4EdtEYXWDJ5Nlg339V+StNiGV0CXS8Nbu2DnDc0g5FOu6xgvZWBs
k38n0AMTvxcCGef2QR25mUle7vDX1wBpiKp+OZnYkG0jbEgzuSbmjmkqZ4/Hfs/N
JjRPrr9kj/HAsRR0NGrDjsOaigGJ09t7cAmrMxbUqD0Yfml9jZ6Ed+QGM/Rt7RRW
u68ICp6VjX/meK0r7Fb+52bDYi3l1grAw7DhbwecXeH1Y2JCJxo=
=U6Gt
-----END PGP SIGNATURE-----

--uJWb33pM2TcUAXIl--
