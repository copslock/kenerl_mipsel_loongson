Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 03 Sep 2017 12:43:58 +0200 (CEST)
Received: from cpanel2.indieserve.net ([199.212.143.6]:37436 "EHLO
        cpanel2.indieserve.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991797AbdICKnnhrjIB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 3 Sep 2017 12:43:43 +0200
Received: from cpec03f0ed08c7f-cm68b6fcf980b0.cpe.net.cable.rogers.com ([174.118.92.171]:57626 helo=localhost.localdomain)
        by cpanel2.indieserve.net with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
        (Exim 4.89)
        (envelope-from <rpjday@crashcourse.ca>)
        id 1doSNL-0004Yu-KJ; Sun, 03 Sep 2017 06:43:35 -0400
Date:   Sun, 3 Sep 2017 06:43:33 -0400 (EDT)
From:   "Robert P. J. Day" <rpjday@crashcourse.ca>
X-X-Sender: rpjday@localhost.localdomain
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>
cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        monstr@monstr.eu,
        Linux PPC Mailing List <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] devicetree: Remove remaining references/tests for
 "chosen@0"
In-Reply-To: <1504390854.4974.108.camel@kernel.crashing.org>
Message-ID: <alpine.LFD.2.21.1709030637090.24875@localhost.localdomain>
References: <alpine.LFD.2.21.1709020416130.13598@localhost.localdomain> <1504390854.4974.108.camel@kernel.crashing.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - cpanel2.indieserve.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - crashcourse.ca
X-Get-Message-Sender-Via: cpanel2.indieserve.net: authenticated_id: rpjday+crashcourse.ca/only user confirmed/virtual account not confirmed
X-Authenticated-Sender: cpanel2.indieserve.net: rpjday@crashcourse.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <rpjday@crashcourse.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59922
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rpjday@crashcourse.ca
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

On Sun, 3 Sep 2017, Benjamin Herrenschmidt wrote:

> On Sat, 2017-09-02 at 04:43 -0400, Robert P. J. Day wrote:
> > Since, according to a recent devicetree ML posting by Rob Herring,
> > the node "/chosen@0" is most likely for real Open Firmware and
> > does not apply to DTSpec, remove all remaining tests and
> > references for that node, of which there are very few left:
>
> Technically that would break Open Firmware systems where the node is
> really called chosen@0
>
> Now I'm not sure such a thing actually exist however.
>
> My collection of DTs don't seem to have one, except in the ancient
> html variants that were extracted by the pengionppc folks for the
> original PowerMac 8600 but I wonder if that's a bug in the
> extraction script since they also have @0 on /packages etc...

  obviously, this isn't a priority issue, i was just working off a
comment by rob herring that "chosen@0" is not defined by the current
DTSpec 0.1, so it seemed appropriate to toss it. if there's a reason
to hang onto it, that's fine with me.

  however, given the diff stat of the change to remove every single
reference to that node name in the current kernel source:

 arch/microblaze/kernel/prom.c | 3 +--
 arch/mips/generic/yamon-dt.c  | 4 ----
 arch/powerpc/boot/oflib.c     | 7 ++-----
 drivers/of/base.c             | 2 --
 drivers/of/fdt.c              | 5 +----
 5 files changed, 4 insertions(+), 17 deletions(-)

it seems inconsistent that three architectures would be testing for
that node, but none of the rest. consistency suggests that every
architecture should take it into account, or none should.

  anyway, not a big deal, i'm fine with any decision.

rday

-- 

========================================================================
Robert P. J. Day                                 Ottawa, Ontario, CANADA
                        http://crashcourse.ca

Twitter:                                       http://twitter.com/rpjday
LinkedIn:                               http://ca.linkedin.com/in/rpjday
========================================================================
