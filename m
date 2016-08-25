Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Aug 2016 20:22:25 +0200 (CEST)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:57117 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992147AbcHYSWSndAXs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Aug 2016 20:22:18 +0200
Received: from raspberrypi.musicnaut.iki.fi (85-76-72-196-nat.elisa-mobile.fi [85.76.72.196])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id 7C4E1188862;
        Thu, 25 Aug 2016 21:22:17 +0300 (EEST)
Date:   Thu, 25 Aug 2016 21:22:10 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ed Swierk <eswierk@skyportsystems.com>,
        linux-mips <linux-mips@linux-mips.org>,
        driverdev-devel <devel@driverdev.osuosl.org>,
        netdev <netdev@vger.kernel.org>,
        Aaro Koskinen <aaro.koskinen@nokia.com>
Subject: Re: Improving OCTEON II 10G Ethernet performance
Message-ID: <20160825182210.GE12169@raspberrypi.musicnaut.iki.fi>
References: <CAO_EM_nrb0M49YwU+gjL+bqT4V1rFj4z7DQ8juTYXgaoKet0mg@mail.gmail.com>
 <57BF21C7.5070709@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <57BF21C7.5070709@caviumnetworks.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54753
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

On Thu, Aug 25, 2016 at 09:50:15AM -0700, David Daney wrote:
> Ideally we would configure the packet classifiers on the RX side to create
> multiple RX queues based on a hash of the TCP 5-tuple, and handle each queue
> with a single NAPI instance.  That should result in better performance while
> maintaining packet ordering.

Would this need anything else than reprogramming CVMX_PIP_PRT_TAGX, and
eliminating the global pow_receive_group and creating multiple NAPI instances
and registering IRQ handlers?

In the Yocto tree, the CVMX_PIP_PRT_TAGX register values are actually
documented:

http://git.yoctoproject.org/cgit/cgit.cgi/linux-yocto-contrib/tree/arch/mips/include/asm/octeon/cvmx-pip-defs.h?h=apaliwal/octeon#n3737

A.
