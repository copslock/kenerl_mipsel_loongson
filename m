Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 19:32:52 +0200 (CEST)
Received: from emh07.mail.saunalahti.fi ([62.142.5.117]:39498 "EHLO
        emh07.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbcHYRcpn3MOs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 19:32:45 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh07.mail.saunalahti.fi (Postfix) with ESMTP id 0F49140CE;
        Thu, 25 Aug 2016 20:32:43 +0300 (EEST)
Date:   Thu, 25 Aug 2016 20:32:43 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Ed Swierk <eswierk@skyportsystems.com>
Cc:     linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>,
        David Daney <ddaney@caviumnetworks.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
Message-ID: <20160825173243.GD12169@raspberrypi.musicnaut.iki.fi>
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54751
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

On Wed, Aug 24, 2016 at 06:29:49PM -0700, Ed Swierk wrote:
> I'm trying to migrate from the Octeon SDK to a vanilla Linux 4.4
> kernel for a Cavium OCTEON II (CN6880) board running in 64-bit
> little-endian mode. So far I've gotten most of the hardware features I
> need working, including XAUI/RXAUI, USB, boot bus and I2C, with a
> fairly small set of patches.
> https://github.com/skyportsystems/linux/compare/master...octeon2

Interesting, have you considered sending some of this stuff into mainline?

> The biggest remaining hurdle is improving 10G Ethernet performance:
> iperf -P 10 on the SDK kernel gets close to 10 Gbit/sec throughput,
> while on my 4.4 kernel, it tops out around 1 Gbit/sec.

Did you compare throughput and packets per second performance of both
kernels using just a single core?

> Comparing the octeon-ethernet driver in the SDK
> (http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/drivers/net/ethernet/octeon?h=apaliwal/octeon)
> against the one in 4.4, the latter appears to utilize only a single
> CPU core for the rx path. It's not clear to me if there is a similar
> issue on the tx side, or other bottlenecks.

Did you try CONFIG_RPS and moving softirqs into other core(s)?

> I started trying to port multi-CPU rx from the SDK octeon-ethernet
> driver, but had trouble teasing out just the necessary bits without
> following a maze of dependencies on unrelated functions. (Dragging
> major parts of the SDK wholesale into 4.4 defeats the purpose of
> switching to a vanilla kernel, and doesn't bring us closer to getting
> octeon-ethernet out of staging.)
> 
> Has there been any work on the octeon-ethernet driver since this patch
> set? https://www.linux-mips.org/archives/linux-mips/2015-08/msg00338.html
> 
> Any hints on what to pick out of the SDK code to improve 10G
> performance would be appreciated.

One thing that is missing from staging driver for CN68XX is the proper
SSO initialization. But I see that you have already implemented that.

Unfortunately I don't have a proper CN68XX test system at the moment, so
CN68XX support has not progressed much since that patch set from my side.

A.
