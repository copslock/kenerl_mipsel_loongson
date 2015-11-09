Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 17:18:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:52998 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011208AbbKIQSBMoWtK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 17:18:01 +0100
Date:   Mon, 9 Nov 2015 16:18:01 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
In-Reply-To: <20151109144932.GE22591@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com> <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com> <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org> <20151109144932.GE22591@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49877
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 9 Nov 2015, Ralf Baechle wrote:

> > I can check if things still work correctly when routed through libata, 
> > although it'll have to wait a couple of weeks yet at the least as I have 
> > wired my SWARM for hardware debugging, making it not immediately bootable 
> > and I'll be departing soon (i.e. I have no time for complicated fiddling).  
> > The host driver itself is actually in arch/mips/sibyte/swarm/platform.c 
> > BTW.
> > 
> >  Note to self: it would be nice if physical rather than virtual MMIO 
> > addresses were reported too.
> 
> Part of the problem is that everybody who is serious about using a Swarm
> is using PCI PATA/SATA card, so this part receives very little TLC.  I
> btw. can't test because the controller on my Pass 2 board is broken ...

 I think I've been reasonably serious about my SWARM and despite issues 
elsewhere the onboard PATA interface is a part of the system I've never 
had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's 
still 11MB/s (and one of the 4 generic data movers present in the SoC 
could be used as a DMA engine to offload the CPU if anyone bothered 
implementing that in the HBA driver).  I used it for stuff like native GCC 
bootstraps, some regression testing.  Maybe I'm just lucky, I've read 
people's horror stories.  Besides I'm out of free PCI slots, I'd have to 
use an expansion box.

  Maciej
