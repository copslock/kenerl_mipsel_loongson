Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Nov 2015 19:54:10 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:54672 "EHLO localhost"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011441AbbKISyGFH0VI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 9 Nov 2015 19:54:06 +0100
Date:   Mon, 9 Nov 2015 18:54:05 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
cc:     Ralf Baechle <ralf@linux-mips.org>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        linux-mips@linux-mips.org, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mips: sb1250_swarm_defconfig: disable IDE subsystem
In-Reply-To: <5640D8E9.7080808@cogentembedded.com>
Message-ID: <alpine.LFD.2.20.1511091827480.10231@eddie.linux-mips.org>
References: <1442245918-27631-1-git-send-email-b.zolnierkie@samsung.com> <1442245918-27631-16-git-send-email-b.zolnierkie@samsung.com> <alpine.LFD.2.20.1511072211330.18958@eddie.linux-mips.org> <20151109144932.GE22591@linux-mips.org>
 <alpine.LFD.2.20.1511091559180.10231@eddie.linux-mips.org> <5640D8E9.7080808@cogentembedded.com>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49879
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

On Mon, 9 Nov 2015, Sergei Shtylyov wrote:

> >   I think I've been reasonably serious about my SWARM and despite issues
> > elsewhere the onboard PATA interface is a part of the system I've never
> > had any with.  Yes, it's limited to PIO 3, but it's not a big deal, that's
> > still 11MB/s (and one of the 4 generic data movers present in the SoC
> 
>    If you measure it with something like 'hdparm -t', the real speed figures
> in the PIO modes would disappoint you. It's usually more like 3 MB/s even in
> PIO4...

 Well, various factors contribute to actual figures possible to achieve, 
the physical medium transfer speed being an important one.  That 11MB/s 
throughput is the maximum you can ever get on the wire in PIO 3, assuming 
data is already available to transfer and IORDY is asserted right away 
every cycle.

 As I say my SWARM is currently in flux, so I can't get any benchmarking 
done right now, but as a matter of interest I'll check that when I get to 
looking at this piece.

> > could be used as a DMA engine to offload the CPU if anyone bothered
> > implementing that in the HBA driver).
> 
>    Oh, that's nice!

 Indeed, I've been told the generic bus interface the PATA inferface has 
been cooked up on in this system has been specifically designed such as to 
make it work with the data mover.  There's still lot of silicon treasure 
left in this system unexplored!

  Maciej
