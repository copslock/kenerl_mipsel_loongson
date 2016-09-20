Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2016 00:57:56 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:50221 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992571AbcITW5tMpYUJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Sep 2016 00:57:49 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-138-228-nat.elisa-mobile.fi [85.76.138.228])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id C4BB569986;
        Wed, 21 Sep 2016 01:57:47 +0300 (EEST)
Date:   Wed, 21 Sep 2016 01:57:47 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Message-ID: <20160920225747.GE27622@raspberrypi.musicnaut.iki.fi>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Mon, Sep 19, 2016 at 03:24:30PM -0500, Steven J. Hill wrote:
> The OCTEON MMC controller is currently found on cn61XX and cn71XX
> devices. Device parameters are configured from device tree data.
> eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> 
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> Acked-by: David Daney <david.daney@cavium.com>

Acked-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.
