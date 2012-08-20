Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Aug 2012 21:52:42 +0200 (CEST)
Received: from Chamillionaire.breakpoint.cc ([80.244.247.6]:36094 "EHLO
        Chamillionaire.breakpoint.cc" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903547Ab2HTTwf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 20 Aug 2012 21:52:35 +0200
Received: from bigeasy by Chamillionaire.breakpoint.cc with local (Exim 4.72)
        (envelope-from <sebastian@breakpoint.cc>)
        id 1T3Y1Y-00048l-Qs; Mon, 20 Aug 2012 21:52:33 +0200
Date:   Mon, 20 Aug 2012 21:52:31 +0200
From:   Sebastian Andrzej Siewior <sebastian@breakpoint.cc>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Sebastian Andrzej Siewior <sebastian@breakpoint.cc>, balbi@ti.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH] usb: gadget: bcm63xx UDC driver
Message-ID: <20120820195231.GA7087@breakpoint.cc>
References: <97cb21b8063a02a9664baf8b749ae200@localhost>
 <20120819201714.GA3152@breakpoint.cc>
 <CAJiQ=7CADk_75U5=OQH8vXA=xtj-U=TbBhXzC8JfUGbYEKmxng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJiQ=7CADk_75U5=OQH8vXA=xtj-U=TbBhXzC8JfUGbYEKmxng@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 34297
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sebastian@breakpoint.cc
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Aug 19, 2012 at 01:53:26PM -0700, Kevin Cernekee wrote:
> > According to this code, i in iudma[] can be in 1..5. You could have more than
> > one IRQ. The comment above this for loop is point less. So I think if you can
> > only have _one_ idma irq than you could remove the for loop in
> > bcm63xx_udc_data_isr().
> 
> There are 6 IUDMA channels, and each one always has a dedicated
> interrupt line.  IRQ resource #0 is the control (vbus/speed/cfg/etc.)
> IRQ, and IRQ resources #1-6 are the IUDMA (IN/OUT data) IRQs.  Maybe
> it would be good to add a longer comment to clarify this?

Now that I look at the code again, I see what I've missed. So you can have
multiple irqs in the range #1-6. Why not pass the iudma struct then?
Passing the struct instead of a range is good thing.

Sebastian
