Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Jun 2013 21:05:51 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:49425 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6834871Ab3FZTFu0iESt (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Jun 2013 21:05:50 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5QJ5mAh023199;
        Wed, 26 Jun 2013 21:05:48 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5QJ5lvZ023198;
        Wed, 26 Jun 2013 21:05:47 +0200
Date:   Wed, 26 Jun 2013 21:05:47 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     Tony Wu <tung7970@gmail.com>, linux-mips@linux-mips.org,
        Chris Dearman <chris.dearman@imgtec.com>
Subject: Re: [PATCH] MIPS: Fix gic_set_affinity infinite loop
Message-ID: <20130626190547.GK7171@linux-mips.org>
References: <20130621111308.GC23231@hades.local>
 <51C486DF.4020303@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51C486DF.4020303@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37150
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

On Fri, Jun 21, 2013 at 12:01:19PM -0500, Steven J. Hill wrote:

> On 06/21/2013 06:13 AM, Tony Wu wrote:
> >There is an infinite loop in gic_set_affinity. When irq_set_affinity
> >gets called on gic controller, it blocks forever.
> >
> Tony,
> 
> What hardware platform is this on and how do you trigger the call to
> 'gic_set_affinity' such that you get stuck? Thanks.

I assume on a SMP GIC configuration he must have tried something like

  echo 1 > /proc/irq/2/smp_affinity

Where 1 is a CPU bit mask and 2 the number of a GIC interrupt of which
to change the affinity.

This is a hillarious bug, this obviously has never been working.

I'm not sure if anything else would need fixing or if the loop had any
sane purpose but as of now I can't see one so I'm queueing the patch
for linux-next.

  Ralf
