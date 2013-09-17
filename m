Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 17:38:56 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:45812 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6860908Ab3IQPiw3mC3V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 17:38:52 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1VLxMa-0001hm-00; Tue, 17 Sep 2013 17:38:52 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id 947275B90CA; Tue, 17 Sep 2013 17:38:26 +0200 (CEST)
Date:   Tue, 17 Sep 2013 17:38:26 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
Message-ID: <20130917153826.GA21354@alpha.franken.de>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
 <20130905180825.GB11592@linux-mips.org>
 <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
 <20130907073450.GE11592@linux-mips.org>
 <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
 <alpine.LFD.2.03.1309160606110.2176@linux-mips.org>
 <20130917084126.GA9785@alpha.franken.de>
 <alpine.LFD.2.03.1309171524240.5967@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309171524240.5967@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Tue, Sep 17, 2013 at 04:10:54PM +0100, Maciej W. Rozycki wrote:
>  OK, I think I've got a plan now.  I don't want to burden the DECstation 
> with stack switching or the extra memory use it requires, so I'll reshape 
> arch/mips/fw/lib/call_o32.S a bit to fit both platforms.  Will you be able 
> and willing to test my code once it's ready with a SNI system?

sure no problem. Thanks for fixing that.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
