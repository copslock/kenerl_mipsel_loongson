Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jul 2018 17:26:24 +0200 (CEST)
Received: from mga18.intel.com ([134.134.136.126]:52538 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990439AbeGQP0VcBjug (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Jul 2018 17:26:21 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jul 2018 08:26:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.51,366,1526367600"; 
   d="scan'208";a="73088055"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga001.fm.intel.com with ESMTP; 17 Jul 2018 08:26:15 -0700
Message-ID: <c7704b44012f6b743cc3791eab3faf674f988ce9.camel@linux.intel.com>
Subject: Re: [PATCH 3/5] i2c: designware: add MSCC Ocelot support
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
        Allan Nielsen <allan.nielsen@microsemi.com>,
        Rob Herring <robh+dt@kernel.org>
Date:   Tue, 17 Jul 2018 18:26:15 +0300
In-Reply-To: <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
References: <20180717114837.21839-1-alexandre.belloni@bootlin.com>
         <20180717114837.21839-4-alexandre.belloni@bootlin.com>
         <1886510d2a828d3a246ef1f490c6819f073fbdcb.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.1-2 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64895
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

On Tue, 2018-07-17 at 18:16 +0300, Andy Shevchenko wrote:
> On Tue, 2018-07-17 at 13:48 +0200, Alexandre Belloni wrote:
> > The Microsemi Ocelot I2C controller is a designware IP. It also has
> > a
> > second set of registers to allow tweaking SDA hold time and spike
> > filtering.

> What do you think?

You can also split it to 2-3 patches, like:
- move to device_get_match_data()
- move OF device table above in the code (no func changes)
- add support for MSCC


-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
