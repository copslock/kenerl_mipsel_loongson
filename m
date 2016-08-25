Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 23:19:01 +0200 (CEST)
Received: from emh02.mail.saunalahti.fi ([62.142.5.108]:33684 "EHLO
        emh02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992196AbcHYVSy2KOaW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 23:18:54 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh02.mail.saunalahti.fi (Postfix) with ESMTP id 2809623401D;
        Fri, 26 Aug 2016 00:18:52 +0300 (EEST)
Date:   Fri, 26 Aug 2016 00:18:52 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ed Swierk <eswierk@skyportsystems.com>,
        linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
Message-ID: <20160825211852.GG12169@raspberrypi.musicnaut.iki.fi>
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
 <57BF21C7.5070709@caviumnetworks.com>
 <20160825182210.GE12169@raspberrypi.musicnaut.iki.fi>
 <57BF5101.6080909@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BF5101.6080909@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54756
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

On Thu, Aug 25, 2016 at 01:11:45PM -0700, David Daney wrote:
> On 08/25/2016 11:22 AM, Aaro Koskinen wrote:
> >On Thu, Aug 25, 2016 at 09:50:15AM -0700, David Daney wrote:
> >>Ideally we would configure the packet classifiers on the RX side to create
> >>multiple RX queues based on a hash of the TCP 5-tuple, and handle each queue
> >>with a single NAPI instance.  That should result in better performance while
> >>maintaining packet ordering.
> >
> >Would this need anything else than reprogramming CVMX_PIP_PRT_TAGX, and
> >eliminating the global pow_receive_group and creating multiple NAPI instances
> >and registering IRQ handlers?
> 
> That is essentially how it works.  Set the tag generation parameters, and
> use the low order bits of the tag to select which POW/SSO group is assigned.
> The SSO group corresponds to an "rx queue"

OK, I will try to experiment with this. Even though my home routers are
2-core only I could still create more queues and verify that the traffic
gets distributed by checking the counters...

> >In the Yocto tree, the CVMX_PIP_PRT_TAGX register values are actually
> >documented:
> >
> >http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/arch/mips/include/asm/octeon/cvmx-pip-defs.h?h=apaliwal/octeon#n3737
> 
> Wow, I didn't realize that documentation was made public.

Also D-Link and Qbiquity GPL source offerings for their products usually
include documentation for register fields. Only in mainline kernel they
are missing.

A.
