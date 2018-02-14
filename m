Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 18:04:01 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:41948 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991248AbeBNRDyMtFuf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Feb 2018 18:03:54 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BA3DD2177D;
        Wed, 14 Feb 2018 17:03:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BA3DD2177D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 14 Feb 2018 17:03:43 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 7/8] MIPS: defconfigs: add a defconfig for Microsemi
 SoCs
Message-ID: <20180214170342.GF3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="FoLtEtfbNGMjfgrs"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-8-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62543
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


--FoLtEtfbNGMjfgrs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 16, 2018 at 11:12:39AM +0100, Alexandre Belloni wrote:
> +# CONFIG_EARLY_PRINTK is not set

Only Loongson1b/1c explicitly disable early printk. Do you disable it
for a particular reason?

Cheers
James

--FoLtEtfbNGMjfgrs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEa+4ACgkQbAtpk944
dnqKiA/+JK10L4NAhXabJQzC3QCp0V/6S/flEnfzjFfGzkDAIDUQYNTAgW8z5SoH
j+SnhK9IRrCricogV/QqKkvHiTGhPh4VaVB7hnvuCC5+RKNnbGlf2YPBbtqKt1O+
30wV9Xgdg3JxUsglfeF+4ssKzjCJ52ymUIvCaJfNRihj8OLxJGKNH4MqA2nP/a/1
2a6Z0dtLxaeMEsZMciIBVVK/vOjHVmj54DB7ts/NJswTClPxpZYZi6h68suWUYoi
tqoYO+ylwamih9O72JS+kJTtpRtq2jLY7g+rN3AXtNZzqxG6vN+Bffflihw9HudW
xcYP+KDtUVXwLILuz/VUYPNPvJQq1VVJ9EzMPIOvFlPGKM+Jzoqnm3ucVZHpBqq4
I9XJvAgFZqYypB+40iWWc7qULgLd4BvHTnpyTEqSOtxjnCzkXAqaNZ1EJXzl8Z1K
A/O7v6gVTuFTZi+R1T7xz+RPiUSpHp80GQOMGX/3Umja18QpriQYcVszqDU8ZD++
2jF3jOYJw+gXRMLjDOAkm39T6crVB6jK8xZuTUu1kWhd7l2/TwHFG5aQrfLdDMaK
cTA+G4QnUbzwj/ac3DNRT2Vr/Weqem9O9hcIXEdoig4cddKGj2f/FBQS171qnBa5
2u5oFnHOab2G58NGQpFSbayZX7lnIfthbM+oBOCahA/v88qWyOg=
=OoOS
-----END PGP SIGNATURE-----

--FoLtEtfbNGMjfgrs--
