Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 04 Sep 2013 18:54:08 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:35534 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6827351Ab3IDQyBG5Z0h (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 4 Sep 2013 18:54:01 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r84GrxOf028105;
        Wed, 4 Sep 2013 18:53:59 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r84Grwah028104;
        Wed, 4 Sep 2013 18:53:58 +0200
Date:   Wed, 4 Sep 2013 18:53:58 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Jim Quinlan <jim2101024@gmail.com>
Cc:     linux-mips@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH] MIPS: dma: if BMIPS5000, flush region just like r10000
Message-ID: <20130904165358.GA27447@linux-mips.org>
References: <y>
 <1377637071-32740-1-git-send-email-jim2101024@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1377637071-32740-1-git-send-email-jim2101024@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37756
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

Dan,

On Tue, Aug 27, 2013 at 04:57:51PM -0400, Jim Quinlan wrote:
> Date:   Tue, 27 Aug 2013 16:57:51 -0400
> From: Jim Quinlan <jim2101024@gmail.com>
> To: ralf@linux-mips.org, linux-mips@linux-mips.org
> cc: cernekee@gmail.com, Jim Quinlan <jim2101024@gmail.com>
> Subject: [PATCH] MIPS: dma: if BMIPS5000, flush region just like r10000
> Content-Type: text/plain
> 
> The BMIPS5000 (Zephyr) processor utilizes instruction speculation. A
> stale misprediction address in either the JTB or the CRS may trigger
> a prefetch inside a region that is currently being used by a DMA
> engine, which is not IO-coherent.  This prefetch will fetch a line
> into the scache, and that line will soon become stale (ie wrong)
> during/after the DMA.  Mayhem ensues.
> 
> In dma-default.c, the r10000 is handled as a special case in the
> same way that we want to handle Zephyr.  So we generalize the
> exception cases into a function, and include Zephyr as one
> of the processors that needs this special care.

Is this a processor erratum or just documented, undesireable behaviour?

In case of the R10000 family it's the later and it also only affects
systems without cache coherency.  In such systems it is also possible
that cachelines in speculative-dirty state will be created by a
speculativly executed store instruction.  This is normal - but on a
cache coherent system the coherency logic would prevent such speculativly
dirty lines from being written back to memory.

To avoid this from happening non-coherent R10000 systems also require their
kernel to be built with a special compiler option that inserts cache barrier
operations wherever a speculativly dirty line otherwise might be created.

Patch is looking good.

  Ralf
