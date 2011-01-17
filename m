Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 13:10:36 +0100 (CET)
Received: from 80-190-117-144.ip-home.de ([80.190.117.144]:59614 "EHLO
        bu3sch.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493405Ab1AQMKd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 13:10:33 +0100
Received: by bu3sch.de with esmtpsa (Exim 4.69)
        (envelope-from <mb@bu3sch.de>)
        id 1Penun-0008JB-4H; Mon, 17 Jan 2011 13:10:29 +0100
Subject: Re: Merging SSB and HND/AI support
From:   Michael =?ISO-8859-1?Q?B=FCsch?= <mb@bu3sch.de>
To:     Florian Fainelli <florian@openwrt.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org
In-Reply-To: <201101171220.52292.florian@openwrt.org> (sfid-20110117_122124_233292_51C2DD96)
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
         <1295261783.24530.3.camel@maggie>  <201101171220.52292.florian@openwrt.org>
         (sfid-20110117_122124_233292_51C2DD96)
Content-Type: text/plain; charset="UTF-8"
Date:   Mon, 17 Jan 2011 13:00:09 +0100
Message-ID: <1295265609.24530.25.camel@maggie>
Mime-Version: 1.0
X-Mailer: Evolution 2.30.3 
Content-Transfer-Encoding: 8bit
Return-Path: <mb@bu3sch.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28934
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mb@bu3sch.de
Precedence: bulk
X-list: linux-mips

On Mon, 2011-01-17 at 12:20 +0100, Florian Fainelli wrote: 
> On Monday 17 January 2011 11:56:23 Michael Büsch wrote:
> > On Mon, 2011-01-17 at 11:46 +0100, Jonas Gorski wrote:
> > > Hello,
> > > 
> > > I am currently looking into adding support for the newer Broadcom
> > > BCM47xx/53xx SoCs. They require having HND/AI support, which probably
> > > means merging the current SSB code and the HND/AI code from the
> > > brcm80211 driver. Is anyone already working on this?
> > > 
> > > As far as I can see, there are two possibilities:
> > > 
> > > a) Merge the HND/AI code into the current SSB code, or
> > > 
> > > b) add the missing code for SoCs to brcm80211 and replace the SSB code
> > > with it.
> > 
> > Why can't we keep those two platforms separated?
> 
> That is also what I am wondering about. Considering that previous BCM47xx 
> platforms use a MIPS4k core and newer one use MIPS74k or later, you would not 
> be able to build a single kernel for both which takes advantages of compile-
> time optimizations targetting MIPS74k. If this ist not a big concern, then 
> let's target a single kernel.

Ok, but it should be easily possible to compile both SSB and HND/AI
bus support into one kernel anyway. Nothing prevents drivers from having
an SSB and an HND/AI probe callback.

-- 
Greetings Michael.
