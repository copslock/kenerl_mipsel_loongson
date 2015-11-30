Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2015 17:35:34 +0100 (CET)
Received: from mezzanine.sirena.org.uk ([106.187.55.193]:49263 "EHLO
        mezzanine.sirena.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008058AbbK3Qfbae9Ke (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Nov 2015 17:35:31 +0100
Received: from cpc11-sgyl31-2-0-cust672.sgyl.cable.virginm.net ([94.175.94.161] helo=debutante)
        by mezzanine.sirena.org.uk with esmtpsa (TLS1.2:RSA_AES_128_CBC_SHA1:128)
        (Exim 4.80)
        (envelope-from <broonie@sirena.org.uk>)
        id 1a3RP6-0000pI-CE; Mon, 30 Nov 2015 16:34:17 +0000
Received: from broonie by debutante with local (Exim 4.86)
        (envelope-from <broonie@sirena.org.uk>)
        id 1a3RP3-0005vu-2D; Mon, 30 Nov 2015 16:34:13 +0000
Date:   Mon, 30 Nov 2015 16:34:13 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Joshua Kinard <kumba@gentoo.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Jiri Slaby <jslaby@suse.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Kumar Gala <galak@codeaurora.org>,
        Yijing Wang <wangyijing@huawei.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Rob Herring <robh+dt@kernel.org>,
        John Crispin <blogic@openwrt.org>,
        Jayachandran C <jchandra@broadcom.com>,
        linux-spi@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Ray Jui <rjui@broadcom.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Michal Simek <michal.simek@xilinx.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Russell Joyce <russell.joyce@york.ac.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Grant Likely <grant.likely@linaro.org>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org,
        Pawel Moll <pawel.moll@arm.com>, linux-pci@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Zhou Wang <wangzhou1@hisilicon.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ley Foon Tan <lftan@altera.com>, devicetree@vger.kernel.org,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-serial@vger.kernel.org, rtc-linux@googlegroups.com,
        Rob Herring <robh@kernel.org>,
        Mauro Carvalho Chehab <mchehab@osg.samsung.com>,
        Wolfram Sang <wsa@the-dreams.de>, Duc Dang <dhdang@apm.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Michal Simek <monstr@monstr.eu>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-gpio@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "David S. Miller" <davem@davemloft.net>,
        Joe Perches <joe@perches.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?iso-8859-1?Q?S=F6ren?= Brinkmann <soren.brinkmann@xilinx.com>,
        dmaengine@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Minghuan Lian <Minghuan.Lian@freescale.com>,
        linux-i2c@vger.kernel.org
Message-ID: <20151130163413.GB1929@sirena.org.uk>
References: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="pI6hLdwVzam1XFuA"
Content-Disposition: inline
In-Reply-To: <1448900513-20856-1-git-send-email-paul.burton@imgtec.com>
X-Cookie: A beer delayed is a beer denied.
User-Agent: Mutt/1.5.24 (2015-08-30)
X-SA-Exim-Connect-IP: 94.175.94.161
X-SA-Exim-Mail-From: broonie@sirena.org.uk
Subject: Re: [PATCH 00/28] MIPS Boston board support
X-SA-Exim-Version: 4.2.1 (built Mon, 26 Dec 2011 16:24:06 +0000)
X-SA-Exim-Scanned: Yes (on mezzanine.sirena.org.uk)
Return-Path: <broonie@sirena.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50210
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@kernel.org
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


--pI6hLdwVzam1XFuA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 30, 2015 at 04:21:25PM +0000, Paul Burton wrote:
> This series introduces support for the Imagination Technologies MIPS
> Boston development board. Boston is an FPGA-based development board
> akin to the much older Malta board, built around a Xilinx FPGA running
> a MIPS CPU & other logic including a PCIe root port connected to an
> Intel EG20T Platform Controller Hub. This provides a base set of
> peripherals including SATA, USB, SD/MMC, ethernet, I2C & GPIOs. PCIe
> slots are also present for expansion.

This is an insanely big CC list :(

What are the interdependencies here - does this really need to be one
patch series or can the individual driver changes go in separately?  The
latter is more normal, usually rather than a single patch series we just
have each driver sent by itself since that's usually easier to handle
and avoids the massive CC lists.

--pI6hLdwVzam1XFuA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJWXHqEAAoJECTWi3JdVIfQJSUH/iIgPfd2b5fhUdpCuloKrkzo
ez7mkxbm3A2j3pKg0G57M4IEOD1UHHBQdACn9Gn38+UCLVdK2VoDpY+xxpf0bUbB
aWm0a1vnjxwyTW5lSEkeR0i6EzMuFliUJnIsdv9yrmwUdm8Z0zJTYaLRm2rKsgR3
kQLDe+kzzuf3qKW0mVcOL8y4rb/keG79c35wSXn4heWbFL7FCAUmVZ0bhcOkeLP+
O9T7D/fqnlT4+gOvBBlglzHBjWY8JUYJiccHFfccRZJ3hOO973bHQi8QcGhS06C3
LFww/Secx7tTiUXfdXo5sD0dAJwN7mG8sBrYAmZPBcW1TYn6wzCxFMK9XkLVA9k=
=7ym9
-----END PGP SIGNATURE-----

--pI6hLdwVzam1XFuA--
