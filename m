Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 14:21:44 +0200 (CEST)
Received: from mga07.intel.com ([134.134.136.100]:43158 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993030AbeGQMVge7zjT (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 14:21:36 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 05:21:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,365,1526367600"; 
   d="scan'208";a="57148412"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by orsmga007.jf.intel.com with ESMTP; 17 Jul 2018 05:21:21 -0700
Message-ID: <08da5a79982a1ac2a2b6b4931d497edfe8fa6171.camel@linux.intel.com>
Subject: Re: [PATCH 0/5] Add support for MSCC Ocelot i2c
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Tue, 17 Jul 2018 15:21:20 +0300
In-Reply-To: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: andriy.shevchenko@linux.intel.com
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

On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> Hi,
> 
> Because the designware IP was not able to the the SDA hold time, MSCC
> has
> its own implementation. Add support for it and then add i2c on ocelot
> boards.
> 
> I would expect patches 1 to 3 to go through the i2c tree and 4-5
> through
> the mips tree once patch 3 has been reviewed by the DT maintainers.

Without reading datasheet it all feels like a wrong place to put.

But maybe that SoC (SoC family?) has some update to DesignWare IP.
Btw, what the version of DW IP it's using? 2.00a? More older, more
recent?


> Alexandre Belloni (5):
>   i2c: designware: factorize setting SDA hold time
>   i2c: designware: allow IP specific sda_hold_time
>   i2c: designware: add MSCC Ocelot support
>   mips: dts: mscc: Add i2c on ocelot
>   mips: dts: mscc: enable i2c on ocelot_pcb123
> 
>  .../bindings/i2c/i2c-designware.txt           |  5 ++-
>  arch/mips/boot/dts/mscc/ocelot.dtsi           | 19 +++++++++++
>  arch/mips/boot/dts/mscc/ocelot_pcb123.dts     |  5 +++
>  drivers/i2c/busses/i2c-designware-common.c    | 33
> +++++++++++++++++++
>  drivers/i2c/busses/i2c-designware-core.h      |  3 ++
>  drivers/i2c/busses/i2c-designware-master.c    | 22 +------------
>  drivers/i2c/busses/i2c-designware-platdrv.c   | 20 +++++++++++
>  drivers/i2c/busses/i2c-designware-slave.c     | 22 +------------
>  8 files changed, 86 insertions(+), 43 deletions(-)
> 

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
