Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Mar 2018 16:22:40 +0100 (CET)
Received: from mail.bootlin.com ([62.4.15.54]:48379 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992916AbeCBPWcznw8Q (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 2 Mar 2018 16:22:32 +0100
Received: by mail.bootlin.com (Postfix, from userid 110)
        id AC54E2037F; Fri,  2 Mar 2018 16:22:23 +0100 (CET)
Received: from localhost (242.171.71.37.rev.sfr.net [37.71.171.242])
        by mail.bootlin.com (Postfix) with ESMTPSA id 63C3220146;
        Fri,  2 Mar 2018 16:22:23 +0100 (CET)
Date:   Fri, 2 Mar 2018 16:22:24 +0100
From:   Alexandre Belloni <alexandre.belloni@free-electrons.com>
To:     James Hogan <jhogan@kernel.org>
Cc:     Paul Burton <paul.burton@mips.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/13] MIPS: mscc: Add initial support for Microsemi MIPS
 SoCs
Message-ID: <20180302152224.GD1479@piout.net>
References: <20171128152643.20463-1-alexandre.belloni@free-electrons.com>
 <20171128152643.20463-10-alexandre.belloni@free-electrons.com>
 <20171128160137.GF27409@jhogan-linux.mipstec.com>
 <20171128165359.GJ21126@piout.net>
 <20171128173151.GD5027@jhogan-linux.mipstec.com>
 <20171128195002.dcq7i2wqmstkn3rr@pburton-laptop>
 <20171129163819.GN21126@piout.net>
 <20180117235846.GA25314@saruman>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180117235846.GA25314@saruman>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <alexandre.belloni@bootlin.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62775
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alexandre.belloni@free-electrons.com
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

Hi,

On 17/01/2018 at 23:58:47 +0000, James Hogan wrote:
> Poking at random I/O always feels a bit risky.
> 
> Some safety checked environment checking (Paul says modetty0 should
> always be in there for YAMON) might work.
> 
> Does Ocelot have a read-only ID register with a specific value? We'd
> have to add prioritisation of the legacy board detection to rely on
> that.
> 

There is an ID register at 0x71070000.

> If all else fails, we could still make them mutually exclusive,
> something roughly like below would work but its a bit clumsy as all the
> ocelot config options would still get enabled when sead3 is enabled,
> even though some of the drivers may not be useful. The detection &
> co-existence can always be improved later. What do you think?
> 

I now have something working based on what you suggested. I'm cleaning
that up and I'll resubmit soon.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
