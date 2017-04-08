Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Apr 2017 02:13:44 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:56805 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdDHANhGzlno (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 8 Apr 2017 02:13:37 +0200
Received: from raspberrypi-3.musicnaut.iki.fi (85-76-102-201-nat.elisa-mobile.fi [85.76.102.201])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 8198F1A25F9;
        Sat,  8 Apr 2017 03:13:35 +0300 (EEST)
Date:   Sat, 8 Apr 2017 03:13:35 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     "Steven J. Hill" <Steven.Hill@cavium.com>
Cc:     linux-mips@linux-mips.org, linux-mmc@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v9] mmc: OCTEON: Add host driver for OCTEON MMC
 controller.
Message-ID: <20170408001335.2eyajki3ujgomcz4@raspberrypi-3.musicnaut.iki.fi>
References: <836c0ca9-18f0-f6b5-bb79-8d0301d54154@cavium.com>
 <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c1d0ccad-10e2-9d5d-8192-2bbd7d7357b3@cavium.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57621
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

Hi,

On Mon, Oct 03, 2016 at 08:18:59PM -0500, Steven J. Hill wrote:
> On 09/19/2016 03:24 PM, Steven J. Hill wrote:
> > The OCTEON MMC controller is currently found on cn61XX and cn71XX
> > devices. Device parameters are configured from device tree data.
> > eMMC, MMC and SD devices are supported. Tested on Cavium CN7130.
> > 
> > Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> > Acked-by: David Daney <david.daney@cavium.com>
> 
> Have any MMC maintainers gotten a chance to review our driver now
> that v4.8 is out? Thanks.

Also v4.9, v4.10 and v4.11 went by.

I think you should resend the patch, to get this driver finally merged.

A.
