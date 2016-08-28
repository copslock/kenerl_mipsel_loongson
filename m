Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2016 14:23:00 +0200 (CEST)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:42014 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992093AbcH1MWxaxP6D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Aug 2016 14:22:53 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id A2F851A26CA;
        Sun, 28 Aug 2016 15:22:50 +0300 (EEST)
Date:   Sun, 28 Aug 2016 15:22:39 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Aaro Koskinen <aaro.koskinen@nokia.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [BISECTED REGRESSION] v4.8-rc: DT/OCTEON driver probing broken
Message-ID: <20160828122239.GA14316@raspberrypi.musicnaut.iki.fi>
References: <20160816150056.GD18731@ak-desktop.emea.nsn-net.net>
 <0336fae0-1717-2f90-c221-6ef69f7024ee@leemhuis.info>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0336fae0-1717-2f90-c221-6ef69f7024ee@leemhuis.info>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54824
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

On Sun, Aug 28, 2016 at 12:34:06PM +0200, Thorsten Leemhuis wrote:
> Lo! Kefeng, below report made it to the list of regression for 4.8, but
> afaics nothing happened after the initial report. Is there maybe some
> reason why it shouldn't be on the list of regressions at all? Or was the
> problem discussed elsewhere? Or is it even fixed already? I noticed
> https://git.kernel.org/torvalds/c/fc520f8b4f (of/platform: disable the
> of_platform_default_populate_init() for all the ppc board), but that
> change is PPC specific.

There is a fix proposal here:

	https://patchwork.linux-mips.org/patch/14041/

There is still few other boards remaining that use of_platform_bus_probe()
from device_initcall, but who knows, maybe they are not affected.

arch/microblaze/kernel/platform.c
arch/mips/mti-malta/malta-dt.c
arch/mips/netlogic/xlp/dt.c
arch/x86/platform/olpc/olpc_dt.c

A.

> On 16.08.2016 17:00, Aaro Koskinen wrote:
> > Hi,
> > 
> > Commit 44a7185c2ae6 ("of/platform: Add common method to populate default
> > bus") added new arch_initcall of_platform_default_populate_init() that
> > will be called before device_initcall octeon_publish_devices(). Now the
> > of_platform_bus_probe() called in octeon_publish_devices() is apparently
> > doing nothing:
> > 
> > [   52.331353] calling  octeon_publish_devices+0x0/0x14 @ 1
> > [   52.331358] OF: of_platform_bus_probe()
> > [   52.331362] OF:  starting at: /
> > [   52.331378] OF: of_platform_bus_create() - skipping /soc@0, already populated
> > [   52.331394] initcall octeon_publish_devices+0x0/0x14 returned 0 after 29 usecs
> > 
> > This also means that USB etc. won't get probed.
> > 
> > Any ideas what would be the proper fix for this? Changing
> > octeon_publish_devices() to arch_initcall seems to work but that may be
> > a bit hackish... Also, there might be also other MIPS boards affected
> > (arch/mips/netlogic/xlp/dt.c, arch/mips/mti-malta/malta-dt.c).
> > 
> > A.
> > 
> > http://news.gmane.org/find-root.php?message_id=20160816150056.GD18731%40ak-desktop.emea.nsn-net.net 
> > http://mid.gmane.org/20160816150056.GD18731%40ak-desktop.emea.nsn-net.net
> > 
> 
