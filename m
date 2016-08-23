Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 23 Aug 2016 22:36:13 +0200 (CEST)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:40307 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991963AbcHWUgGq-BOg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 23 Aug 2016 22:36:06 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id A516E69D88;
        Tue, 23 Aug 2016 23:36:05 +0300 (EEST)
Date:   Tue, 23 Aug 2016 23:36:05 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>,
        Jon Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <regressions@leemhuis.info>
Subject: [BISECTED REGRESSION] v4.8-rc: gpio-leds broken on OCTEON
Message-ID: <20160823203605.GA12169@raspberrypi.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54737
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

gpio-leds fails to probe on OCTEON with v4.8-rc3 and when using
arch/mips/boot/dts/cavium-octeon/dlink_dsr-1000n.dts. Leds still
worked with v4.7.

I bisected this to:

	commit 15cc2ed6dcf91a8658e084be4e140147161819d7
	Author: Jon Hunter <jonathanh@nvidia.com>
	Date:   Mon Jun 20 14:49:18 2016 +0100

	of/irq: Mark initialised interrupt controllers as populated

I have no idea how this is related to gpio-leds, except that on OCTEON
DTBs the gpio node is also interrupt controller...

Any ideas?

A.
