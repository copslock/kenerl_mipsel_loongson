Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Sep 2015 11:04:24 +0200 (CEST)
Received: from mail.base45.de ([80.241.61.77]:47797 "EHLO mail.base45.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006923AbbIIJEWvqGA7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 Sep 2015 11:04:22 +0200
Received: from [2a02:8109:8c40:8f4:bd68:64f6:6ae5:6056] (helo=lazus.yip)
        by mail.base45.de with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.82)
        (envelope-from <lynxis@fe80.eu>)
        id 1ZZbIf-000317-R8; Wed, 09 Sep 2015 11:04:18 +0200
Date:   Wed, 9 Sep 2015 11:04:06 +0200
From:   Alexander Couzens <lynxis@fe80.eu>
To:     Alban <albeu@free.fr>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] MIPS: ath79: set missing irq ack handler for
 ar7100-misc-intc irq chip
Message-ID: <20150909110406.2e4a4f97@lazus.yip>
In-Reply-To: <20150903103245.21dc9dd7@avionic-0020>
References: <1441251262-13335-1-git-send-email-lynxis@fe80.eu>
        <1441251262-13335-2-git-send-email-lynxis@fe80.eu>
        <20150903103245.21dc9dd7@avionic-0020>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 boundary="Sig_/mTYCrXriuVUD985kG3i33J3"; protocol="application/pgp-signature"
Return-Path: <lynxis@fe80.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49141
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lynxis@fe80.eu
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

--Sig_/mTYCrXriuVUD985kG3i33J3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 3 Sep 2015 10:32:45 +0200
Alban <albeu@free.fr> wrote:

> > -IRQCHIP_DECLARE(ath79_misc_intc, "qca,ar7100-misc-intc",
> > -		ath79_misc_intc_of_init);
> > +
> > +static int __init ar7100_misc_intc_of_init(
> > +	struct device_node *node, struct device_node *parent)
> > +{
> > +	pr_info("IRQ: Setup ar7100 misc IRQ controller from
> > devicetree.\n");
>=20
> Debug left over?

I'll remove it in next patch. I added it because you mentioned a log
message in your last review.

> On Mon, 10 Aug 2015 20:11:14 +0200
> Alban <albeu@free.fr> wrote:
>> Mon, 10 Aug 2015 20:11:14 +0200
>> A log message would be nice. IMHO it should mention that the ACK
>> callbacks have been missed when introducing OF support.

--Sig_/mTYCrXriuVUD985kG3i33J3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJV7/YHAAoJEMKenaag34YEPbQQAJZIno5m8B629KfceUaaVgwA
I0q9PVcRBxr7mLW/DXdj/fsTLQ+A0XjuvdTqzxWTRo1SmhFlg/6oobw8w2+7QqJv
CJSFP2l7cd12RYEKWbn7SpkfRgSJZ06T2cgVQUnSvZfqD4796YjLVmxBub1xH6N+
L0Xz7X8OjnHpEbrtXmxOPA34qZyGbgx3lf1IbVRWrgyuEJTLP7NqQZdYwS4cH9gf
l7eqTmfj+TpTZTn6iB5at1+a6zw1r6ay/vDGwBDScZoZcFnk9qSqf5x2YOiceBPj
BaBx3EmXGrSCeZfdW3H4FcHXlEDPVAooc7TbR3T8dC1pKys8euCzaAfvQ2SEi2GH
P9iYC9sQ/2ThoQyJrOv/eNW8ftQvqaek89aND3o1lQZQT/wwFbWcnk1l55GvPvyF
lfcL/DcVwcd0hvXy2qqlq6va3++e+HWsE8u4yS7i/rluX6lzBC/Iwk6c0MNOgzNi
sbHBV0sk1R1geFE5si38zz91YXhntU0pmAnA4QRWlr7HJbBhy/+llirew4sidem9
u+h5YCU79xJ6JJr2WaoMJz7DFEFeAJlROem9x8L3pRBiGpTzUQcM5vU+P5g6Gnh3
bSOJGhpxxuLjStBM2hqZGGGCLq4l6biBva8pmzy0FoTqobitS/3hrIKOxgp/3bz6
cJQ3NLbgk6OOpnfOU2oK
=gOkz
-----END PGP SIGNATURE-----

--Sig_/mTYCrXriuVUD985kG3i33J3--
