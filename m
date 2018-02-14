Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Feb 2018 17:39:00 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.99]:38194 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991248AbeBNQivtIDgf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Feb 2018 17:38:51 +0100
Received: from saruman (jahogan.plus.com [212.159.75.221])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1849621726;
        Wed, 14 Feb 2018 16:38:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1849621726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=jhogan@kernel.org
Date:   Wed, 14 Feb 2018 16:38:39 +0000
From:   James Hogan <jhogan@kernel.org>
To:     Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/8] dt-bindings: mips: Add bindings for Microsemi SoCs
Message-ID: <20180214163838.GB3986@saruman>
References: <20180116101240.5393-1-alexandre.belloni@free-electrons.com>
 <20180116101240.5393-2-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="7iMSBzlTiPOCCT2k"
Content-Disposition: inline
In-Reply-To: <20180116101240.5393-2-alexandre.belloni@free-electrons.com>
User-Agent: Mutt/1.7.2 (2016-11-26)
Return-Path: <jhogan@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62539
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


--7iMSBzlTiPOCCT2k
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On Tue, Jan 16, 2018 at 11:12:33AM +0100, Alexandre Belloni wrote:
> +o CPU system control:
> +
> +The SoC has a few registers (ICPU_CFG:CPU_SYSTEM_CTRL) handling configuration of
> +the CPU: 8 general purpose registers, reset control, CPU en/disabling, CPU
> +endianess, CPU bus control, CPU status.

nit: checkpatch suggests endianess should be spelt endianness

Cheers
James

--7iMSBzlTiPOCCT2k
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEd80NauSabkiESfLYbAtpk944dnoFAlqEZg4ACgkQbAtpk944
dnrviw/9F0TiLHgTY3AqdqIU4XRLfU0AeqpAYSW6fT7XVx7vshvSYbRM4VPQuI4Q
jr4SnKdL5cpLCA4+WcveT8Qg+eIy0tmulBskiF1cY6KkCjKycB5De1dFWFZ8uBa8
WuNMrJqGClZY6wl5ufKTIyUJmIb4DYyvfqjlxFpLY4ugmU3IjULII6f2HJTkeLxf
q5D7oPHMQ8FtPS+LNruGduMBHqnMrBChck/yXNJCIDKwCoUaDU2gkacCuXGttNZY
8uzPAxuAEohi+rEdBSx3kGoat3Q07o55HeH+Uges2uM2zo2T96n9bMmIs+gVj0dy
HnvoZvraxpOBsEsCDhldRtQH5+2sLyDVk1hw9wFIk1uBu9NWlvGvgAu7iD8cpCgD
pJwCDeiZIBT7DZhNlh9Mqq63HC+ys4IQbe+Pv5Qqbguq5mnV5fOtbU42jz54apJd
ncyiSlr/MzIoFDPHEI8EeFdR2MbDQRWW8b6CNa7EF5YDpHxLs/Bs8mZU89viz+75
hrfVQZytPxvtdBWOxAIHJFWNRdo28X0O7ubORIemejuYIJuGcarGi3KqLaNuxmf0
3wyqcytg+PoVl5pwMQD2Vp2r6KYYLckbd53WyK1Wl9kTdo6d13TAyzZu1yAoiJ4A
jmytX63lMvkyfIJGUBFYBFCHfSyRh2vhDeQZZYQfgOPay8rZx/Y=
=ne0x
-----END PGP SIGNATURE-----

--7iMSBzlTiPOCCT2k--
