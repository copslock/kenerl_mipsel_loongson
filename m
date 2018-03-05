Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 05 Mar 2018 19:32:19 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:48388 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992212AbeCEScJrpu8w (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 5 Mar 2018 19:32:09 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8230C21486;
        Mon,  5 Mar 2018 18:32:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8230C21486
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Mon, 5 Mar 2018 18:31:58 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Guenter Roeck <linux@roeck-us.net>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH v2 8/8] MIPS: jz4740: Drop old platform reset code
Message-ID: <20180305183157.GI4197@saruman>
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-8-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="CNK/L7dwKXQ4Ub8J"
Content-Disposition: inline
In-Reply-To: <20171230135108.6834-8-paul@crapouillou.net>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62809
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


--CNK/L7dwKXQ4Ub8J
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Dec 30, 2017 at 02:51:08PM +0100, Paul Cercueil wrote:
> This work is now performed by the watchdog driver directly.
>=20
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Acked-by: James Hogan <jhogan@kernel.org>

Cheers
James

--CNK/L7dwKXQ4Ub8J
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqdjR0ACgkQbAtpk944
dnrXCBAAqbAXly/TPoIHI8GzFZRLzM/t1VZBJR1y4DsyrFdylavt8+0ayRLf+zOc
SRG94UZftjLHUuxuqsmyHzq3KMrbh/xrPvE2l4UJf+kBgclRr+R84rsWjf2FSywk
4+Vik/HNRXMslNVla5tGHLRLG65Wzj5FW6AFeY1ib+VLh4rUi9eQFx6rtBuDq3f5
JX/AMHEdjybSisqaRcxlIir9rl6vxF/hziqc7XicOjF7tuq5NSxwUolhr7zeXYvH
u6WR0L89GjOOK92fWO3t5wxUo2ELC5YWRdFg45PwgxS7xfrcfM4rLTRtlkArc2WC
BYF+RHGT8G3seocfafYzrFGBzNfP6QE5Z+e0aGpLdVCn9TGt2JKYssYVsBcHZ+M3
nEoWwHUYyt/lfTnFbFpBo6iOYK5d5ULvoGTDLFVghe87xQp58/JSSSyhqrGBIMvH
FHYVuELdKCqiy3khn+uSIBTkUkzjXEsp1QcSC3PBoGKjkPIMKizKNfYBktGKdGld
DecC0Hza2Si/SAHddh72Ew5zxSKbfgwgblDjnsWEEmpt26NoFhKI1S3RFmmBOcq5
Uhf1Lv/TqbEuVL75lckhqo5Ux9BDyrYSSDq9d/fY9ud2U6VFIArOEoKmf5Dasx4G
qaXQWtR+7/BWjhUD9CK2WTpF+Mc0s1aNxEFRe5kH56BcUAPpbAo=
=IUUM
-----END PGP SIGNATURE-----

--CNK/L7dwKXQ4Ub8J--
