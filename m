Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jul 2015 23:36:36 +0200 (CEST)
Received: from mail-pa0-f47.google.com ([209.85.220.47]:34026 "EHLO
        mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011141AbbGUVgfOpfE1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jul 2015 23:36:35 +0200
Received: by pacan13 with SMTP id an13so127754425pac.1
        for <linux-mips@linux-mips.org>; Tue, 21 Jul 2015 14:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=R324c+xIo2660RSidstmeHO/G0ayfQ9zsL43ScRH8Hw=;
        b=Z7t9F0l9azyP/b+lzR40cILAczzD4MYF/waaRqpkybwUkq1UV/63mMRH2vf12h48wX
         32LcPKd1LxCGFqhArGfzPzKkStbt8h21lvzmwgKg3Yzf5p8+c1MzenUEPHqMHlTXIi8p
         7b0VC2atawZmWX1mNZJVcsviKJFi2RknfKToqML1lHtkTUSDzADonPJ2nSw8WCfaIdew
         f0+Jy+Hn/64x+tKTKXtVa6jSbjDxnR/p7uDLJCDyB1pBDNtfWPFe7eSjWMs3S8fZvX4x
         rPVbv4YXtI4m89HlPjXBqbZJ/oSG3yNFuzY/lniaB6G9myFl07ZGJaLnGlUxfNEXgr5U
         926A==
X-Received: by 10.66.236.167 with SMTP id uv7mr75557299pac.134.1437514588745;
        Tue, 21 Jul 2015 14:36:28 -0700 (PDT)
Received: from google.com ([2620:0:1000:1301:41a8:58f7:736b:734a])
        by smtp.gmail.com with ESMTPSA id j4sm29216672pdg.64.2015.07.21.14.36.27
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 21 Jul 2015 14:36:28 -0700 (PDT)
Date:   Tue, 21 Jul 2015 14:36:25 -0700
From:   Brian Norris <computersforpeace@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH 1/2] genirq: add chip_{suspend,resume} PM support to
 irq_chip
Message-ID: <20150721213625.GO24125@google.com>
References: <20150619224123.GL4917@ld-irv-0074>
 <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
 <alpine.DEB.2.11.1506201605290.4107@nanos>
 <55AE8E5D.8020700@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <55AE8E5D.8020700@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48374
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Hi Florian, Thomas,

On Tue, Jul 21, 2015 at 11:24:29AM -0700, Florian Fainelli wrote:
> On 20/06/15 07:11, Thomas Gleixner wrote:
> > On Fri, 19 Jun 2015, Brian Norris wrote:
...
> > I really don't want to set a precedent for random (*foo)(*bar)
> > callbacks.
> >  
> >> +
> >> +		if (ct->chip.chip_suspend)
> >> +			ct->chip.chip_suspend(gc);
> > 
> > So wouldn't it be the more intuitive solution to make this a callback
> > in the struct gc itself?
> 
> Brian can correct me, but his approach is more generic, if there is
> another irqchip driver needing a similar infrastructure, this would be
> already there, and directly usable. Maybe all we need to is to change
> the chip_suspend/resume arguments to pass a reference to irq_chip instead?

I believe Thomas is right. We could just make these into
irq_chip_generic callbacks, which would probably be the right
abstraction level. Wouldn't be much code change from this submission,
AFAICT.

(Sorry for dropping the ball on this one.)

Brian
