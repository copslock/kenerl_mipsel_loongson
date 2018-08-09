Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2018 11:29:53 +0200 (CEST)
Received: from mga05.intel.com ([192.55.52.43]:28898 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992479AbeHIJ3tTluVy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 9 Aug 2018 11:29:49 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Aug 2018 02:29:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,214,1531810800"; 
   d="scan'208";a="75107867"
Received: from smile.fi.intel.com (HELO smile) ([10.237.72.86])
  by fmsmga002.fm.intel.com with ESMTP; 09 Aug 2018 02:29:42 -0700
Message-ID: <92b206fcb5af4ad809e6f2b103a21bce9f9af706.camel@linux.intel.com>
Subject: Re: [PATCH v3 1/6] i2c: designware: use generic table matching
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Wolfram Sang <wsa@the-dreams.de>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        James Hogan <jhogan@kernel.org>,
        Paul Burton <paul.burton@mips.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
Date:   Thu, 09 Aug 2018 12:29:41 +0300
In-Reply-To: <20180808202210.qkocl4hckqla7exe@ninjato>
References: <20180806185412.7210-1-alexandre.belloni@bootlin.com>
         <20180806185412.7210-2-alexandre.belloni@bootlin.com>
         <20180808202210.qkocl4hckqla7exe@ninjato>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <andriy.shevchenko@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65494
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

On Wed, 2018-08-08 at 22:22 +0200, Wolfram Sang wrote:
> On Mon, Aug 06, 2018 at 08:54:07PM +0200, Alexandre Belloni wrote:
> > Switch to device_get_match_data in probe to match the device
> > specific data
> > instead of using the acpi specific function.
> > 
> > Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> 
> Andy, you happy with this patch?
> 

Yes, yes.
If you need my formal tag, here it is

Acked-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
