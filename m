Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Aug 2018 12:58:11 +0200 (CEST)
Received: from mga17.intel.com ([192.55.52.151]:46724 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994587AbeHPK6CsKVVp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 16 Aug 2018 12:58:02 +0200
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Aug 2018 03:58:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.53,246,1531810800"; 
   d="scan'208";a="254576890"
Received: from mylly.fi.intel.com (HELO [10.237.72.67]) ([10.237.72.67])
  by fmsmga005.fm.intel.com with ESMTP; 16 Aug 2018 03:57:57 -0700
Subject: Re: [PATCH v4 0/7] Add support for MSCC Ocelot i2c
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Wolfram Sang <wsa@the-dreams.de>,
        James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-i2c@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Allan Nielsen <allan.nielsen@microsemi.com>
References: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
From:   Jarkko Nikula <jarkko.nikula@linux.intel.com>
Message-ID: <7eb26433-9346-db9a-6d76-5c1da8b9baa3@linux.intel.com>
Date:   Thu, 16 Aug 2018 13:58:02 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20180816084521.16289-1-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <jarkko.nikula@linux.intel.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jarkko.nikula@linux.intel.com
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

On 08/16/2018 11:45 AM, Alexandre Belloni wrote:
> Hello,
> 
> Because the designware IP was not able to handle the SDA hold time before
> version 1.11a, MSCC has its own implementation. Add support for it and then add
> i2c on ocelot boards.
> 
> I would expect patches 1 to 5 to go through the i2c tree and 6-7 through
> the mips tree once patch 4 has been reviewed by the DT maintainers.
> 
For the patches 1-3 and 5/7 that touch i2c-designware:

Tested-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
Acked-by: Jarkko Nikula <jarkko.nikula@linux.intel.com>
