Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Dec 2015 00:23:09 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:57075 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27013900AbbLOXXGWUQiR (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Dec 2015 00:23:06 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 2A3E6203A9;
        Tue, 15 Dec 2015 23:23:04 +0000 (UTC)
Received: from mail.kernel.org (unknown [178.162.198.111])
        (using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BAA48203A4;
        Tue, 15 Dec 2015 23:23:02 +0000 (UTC)
Date:   Wed, 16 Dec 2015 00:23:00 +0100
From:   Sebastian Reichel <sre@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jonas Gorski <jogo@openwrt.org>, linux-pm@vger.kernel.org,
        Mark Brown <broonie@kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        bcm-kernel-feedback-list <bcm-kernel-feedback-list@broadcom.com>
Subject: Re: [PATCH linux-next 1/2] power: Add brcm,bcm6358-power-controller
 device tree binding
Message-ID: <20151215232300.GB7421@earth>
References: <5668AB4F.7030100@simon.arlott.org.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="XOIedfhf+7KOe/yw"
Content-Disposition: inline
In-Reply-To: <5668AB4F.7030100@simon.arlott.org.uk>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <sre@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50638
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sre@kernel.org
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


--XOIedfhf+7KOe/yw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Dec 09, 2015 at 10:29:35PM +0000, Simon Arlott wrote:
> The BCM6358 contains power domains controlled with a register. Power
> domains are indexed by bits in the register. Power domain bits can be
> interleaved with other status bits and clocks in the same register.
>=20
> Newer SoCs with dedicated power domain registers are active low.

That's neither a power supply driver (like a battery charger or a
fuel gauge), nor a reboot/poweroff driver, so does not really fit
into my tree. I will add generic PM maintainers to the discussion.

-- Sebastian

--XOIedfhf+7KOe/yw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJWcKDUAAoJENju1/PIO/qanW0P+gPU6Ii+5doqe4tOqU+RWSUr
PDpj0smF8huH4pmzqSwpbJjci4G0xqGRTSh/XARVq5fJ3IfiDmUQhbFHHR7cb/15
DDxtDN8FhAPfZB/Ylx4tIm5W4pZvAhROJHM25LCiroV5yhPIx+hRja4Uc4LPNImG
tasXry7MG7IthMJAgB+Qc+f3VcMIa1DlUks/nwCCOgY0IO+Sir9V7YFDREfYxdtO
N+owMT2SR3noR0A4IxlaDHd+1cT8giWMd5UOVjFph/j31M7Uxl/haJEvm8ZPwPAJ
ShFhVo5FCpObUlP5bmffywditTLwatf+GFfFY+Z1X916jTK9V9G73PnLlsuIqBTe
2fXiC8q5f7YmGDWOjijLFGxb1vIwcj3qM7B1UkYWqCuUW49dzXbA4FU6DLp5z3vZ
s091BxCi3oXWB0bvFiqc1xooD5beQUALVAFuaGkRzR3tjTttzZP/KA8GuHgBoDrw
S9DQ8Denq9m+o8+0F4cX7noY77m52wHfgGai8vkP0NPq2VlE8lrzpIcZivY37CpM
yswwip0nJ6HnFbqFql4SD/1OrOH04rWe2NtWpL0piDFVZ1VlbeF4ULt8DY1j/Foa
ucdOBI9+93jczW8XAnrER6Vkte6+TyffUUONAUZMn5fEg/Ne85ijTH1BQZfYilmQ
4LR3wrR6ccdi+dGOWuA6
=zyMi
-----END PGP SIGNATURE-----

--XOIedfhf+7KOe/yw--
