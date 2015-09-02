Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Sep 2015 14:12:20 +0200 (CEST)
Received: from pmta2.delivery5.ore.mailhop.org ([54.186.218.12]:57154 "EHLO
        pmta2.delivery5.ore.mailhop.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008153AbbIBMMSUwPxQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Sep 2015 14:12:18 +0200
Received: from io (unknown [173.50.93.239])
        by outbound2.ore.mailhop.org (Halon Mail Gateway) with ESMTPSA;
        Wed,  2 Sep 2015 12:12:23 +0000 (UTC)
Received: from io.lakedaemon.net (localhost [127.0.0.1])
        by io (Postfix) with ESMTP id AA16D8011D;
        Wed,  2 Sep 2015 12:12:09 +0000 (UTC)
X-DKIM: OpenDKIM Filter v2.6.8 io AA16D8011D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lakedaemon.net;
        s=mail; t=1441195929;
        bh=PX7tbP5z6zgp6qnzZT3wBos+h0NpAx0v7suveIHyoCk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To;
        b=tY8Vacsa5m7t4aZeracHiwCe6fNSnjmFvnVPxG8//lQVawEqRM3oauBzz7m3Rzh8K
         Cs0DLyXi1P5y7K2hysEiL84EjaDDDHK7ihkVQqci78X+Wwo7JVXtK6LA/bPa9DdsL/
         m2YiiPTM+w3UJlfnJV8AqQbOSMI3Yl/Rh0l3HuX5/W09Q030+dy4083LPdLRxuCkWd
         V5DNi4MDPgjFRiogvH/JjHvJCYlcqMGKYFquJ/HVsQTaIYS9HdZxOkhuT5+ziORsRg
         nme93Li9g8nFG/x50aJ/tpUCjXyp2ydmMt7gwaXSYT5jWrf4PSzX9PDo3NcwpXrief
         nrp2ByAVbQn6A==
Date:   Wed, 2 Sep 2015 12:12:09 +0000
From:   Jason Cooper <jason@lakedaemon.net>
To:     Marc Zyngier <marc.zyngier@arm.com>
Cc:     Qais Yousef <qais.yousef@imgtec.com>,
        Mark Rutland <Mark.Rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Lisa Parratt <Lisa.Parratt@imgtec.com>
Subject: Re: [PATCH 01/10] irqchip: irq-mips-gic: export gic_send_ipi
Message-ID: <20150902121209.GA10628@io.lakedaemon.net>
References: <55DDA1C4.4070301@imgtec.com>
 <alpine.DEB.2.11.1508261427280.15006@nanos>
 <55DDD3E3.7070009@imgtec.com>
 <alpine.DEB.2.11.1508261701430.15006@nanos>
 <55DDDE3C.8030609@imgtec.com>
 <alpine.DEB.2.11.1508262101450.15006@nanos>
 <55E03A2B.3070805@imgtec.com>
 <alpine.DEB.2.11.1508281619311.15006@nanos>
 <55E6C250.50100@imgtec.com>
 <55E6C788.2000405@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55E6C788.2000405@arm.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <jason@lakedaemon.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49084
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jason@lakedaemon.net
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

On Wed, Sep 02, 2015 at 10:55:20AM +0100, Marc Zyngier wrote:
> On 02/09/15 10:33, Qais Yousef wrote:
> > On 08/28/2015 03:22 PM, Thomas Gleixner wrote:
> >> On Fri, 28 Aug 2015, Qais Yousef wrote:
> >>> Thanks a lot for the detailed explanation. I wasn't looking for a quick and
> >>> dirty solution but my view of the problem is much simpler than yours so my
> >>> idea of a solution would look quick and dirty. I have a better appreciation of
> >>> the problem now and a way to approach it :-)
> >>>
> >>>  From DT point of view are we OK with this form then
> >>>
> >>>      coprocessor {
> >>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
> >>>              interrupt-sink = <&intc INT_SPEC CPU_HWAFFINITY>;
> >>>      }
> >>>
> >>> and if the root controller sends normal IPI as it sends normal device
> >>> interrupts then interrupt-sink can be a standard interrupts property (like in
> >>> my case)
> >>>
> >>>      coprocessor {
> >>>              interrupt-source = <&intc INT_SPEC COP_HWAFFINITY>;
> >>>              interrupts = <INT_SPEC>;
> >>>      }
> >>>
> >>> Does this look right to you? Is there something else that needs to be covered
> >>> still?
> >> I'm not an DT wizard. I leave that to the DT experts.
> >>   
> > 
> > Hi Marc Zyngier, Mark Rutland,
> > 
> > Any comments about the DT binding for the IPIs?
> > 
> > To recap, the proposal which is based on Marc Zyngier's is to use 
> > interrupt-source to represent an IPI from Linux CPU to a coprocessor and 
> > interrupt-sink to receive an IPI from coprocessor to Linux CPU. 
> > Hopefully the description above is self explanatory. Please let me know 
> > if you need more info. Thomas covered the routing, synthesising, and 
> > requesting parts in the core code. The remaining (high level) issue is 
> > how to describe the IPIs in DT.
> 
> I'm definitely *not* a DT expert! ;-) My initial binding proposal was
> only for wired interrupts, not for IPIs. There is definitely some common
> aspects, except for one part:
> 
> Who decides on the IPI number? So far, we've avoided encoding IPI
> numbers in the DT just like we don't encode MSIs, because they are
> programmable things. My feeling is that we shouldn't put the IPI number
> in the DT because the rest of the kernel uses them as well and could
> decide to use this particular IPI number for its own use: *clash*.

Agree.  The best way I've found to design DT bindings is to imagine
providing the DT to something other than Linux.  The DT should *only* be
describing the hardware.  As such, I think we should be describing the
connection here, and leaving the assignment up to the OS.

thx,

Jason.
