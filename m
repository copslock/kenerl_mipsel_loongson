Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 26 Oct 2018 22:54:28 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:60964 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993060AbeJZUyZkVGZP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 26 Oct 2018 22:54:25 +0200
Received: from darkstar.musicnaut.iki.fi (85-76-71-107-nat.elisa-mobile.fi [85.76.71.107])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id 94EC5300CF;
        Fri, 26 Oct 2018 23:54:23 +0300 (EEST)
Date:   Fri, 26 Oct 2018 23:54:23 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Robin Murphy <robin.murphy@arm.com>,
        Christoph Hellwig <hch@lst.de>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66960
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

OCTEON (MIPS64) MMC driver probe fails with v4.19, because with

commit 6c2fb2ea76361da9b420a8e23a2a19e7842cbdda
Author: Robin Murphy <robin.murphy@arm.com>
Date:   Mon Jul 23 23:16:09 2018 +0100

    of/device: Set bus DMA mask as appropriate

we now get a default 32-bit bus DMA mask, and the device itself has
64-bit mask, so it gets rejected.

With the current mainline, the driver is again working (probably
because of b4ebe6063204 ("dma-direct: implement complete bus_dma_mask
handling")). But I think this is just because I happen to have < 4 GB RAM,
and it probably could still fail on bigger systems..?

A.
