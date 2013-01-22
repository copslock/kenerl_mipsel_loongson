Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Jan 2013 12:54:54 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:35672 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6825653Ab3AVLyracLpZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 Jan 2013 12:54:47 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r0MBsiBu031340;
        Tue, 22 Jan 2013 12:54:44 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r0MBshFc031333;
        Tue, 22 Jan 2013 12:54:43 +0100
Date:   Tue, 22 Jan 2013 12:54:43 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     John Stultz <john.stultz@linaro.org>
Cc:     Yong Zhang <yong.zhang0@gmail.com>, linux-mips@linux-mips.org
Subject: Re: Any NXP PNX user left (was: Re: pnx_clocksource broken?)
Message-ID: <20130122115443.GB14944@linux-mips.org>
References: <4F84E531.3010001@linaro.org>
 <20120416140040.GA2378@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20120416140040.GA2378@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 35504
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Mon, Apr 16, 2012 at 04:00:40PM +0200, Ralf Baechle wrote:

> > Looking at arch/mips/pnx8550/common/time.c the pnx_clocksource never
> > seems to be assigned a mult/shift value before it calls
> > clocksource_register(). Clearly this is broken and I suspect this
> > clocksource is never used.
> > 
> > I was hoping to convert this driver over (its the last of 3
> > remaining) to use clocksource_register_hz/khz() but I'm not sure
> > what the actual frequency of the hardware should be. Is
> > mips_hpt_frequency the right value here?
> > 
> > Even so, if this is clocksource is never used, should it just be removed?
> 
> Iow PNX has not had a functioning clocksource for a very long time.  Equally
> there has not been any user feedback for ages and I wonder if that makes the
> PNX code a candidate for removal.
> 
> Any remaining PNX users should raise their voice now or PNX will be
> toast.  Soon.

Not soon at all but nobody's answered so I've removed all of PNX8550.

  Ralf
