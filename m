Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Aug 2017 13:23:52 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:40774 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991500AbdH1LXn5W0A- (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Aug 2017 13:23:43 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v7SBNWHh015697;
        Mon, 28 Aug 2017 13:23:32 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v7SBNR4J015695;
        Mon, 28 Aug 2017 13:23:27 +0200
Date:   Mon, 28 Aug 2017 13:23:27 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, linux-mtd@lists.infradead.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        martin.blumenstingl@googlemail.com, john@phrozen.org,
        linux-spi@vger.kernel.org, hauke.mehrtens@intel.com,
        robh@kernel.org, andy.shevchenko@gmail.com, p.zabel@pengutronix.de,
        kishon@ti.com, mark.rutland@arm.com,
        Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH v10 03/16] spi: spi-falcon: drop check of boot select
Message-ID: <20170828112327.GA15640@linux-mips.org>
References: <20170819221823.13850-1-hauke@hauke-m.de>
 <20170819221823.13850-4-hauke@hauke-m.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170819221823.13850-4-hauke@hauke-m.de>
User-Agent: Mutt/1.8.3 (2017-05-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Aug 20, 2017 at 12:18:10AM +0200, Hauke Mehrtens wrote:

> Do not check which flash type the SoC was booted from before
> using this driver. Assume that the device tree is correct and use this
> driver when it was added to device tree. This also removes a build
> dependency to the SoC code.
> 
> All device trees I am aware of only have one correct flash device entry
> in it. The device tree is anyway bundled with the kernel in all systems
> using device tree I know of.
> 
> The boot mode can be specified with some pin straps and will select the
> flash type the rom code will boot from. One SPI, NOR or NAND flash chip
> can be connect to the EBU and used to load the first stage boot loader
> from.

I think other than this patch we finally have all the acks necessary so
I merged the series except this patch which shouldn't be strictly necessary.

  Ralf
