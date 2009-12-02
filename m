Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 03:46:17 +0100 (CET)
Received: from marcansoft.com ([80.68.93.119]:34765 "EHLO smtp.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493689AbZLBCqN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 03:46:13 +0100
Received: from [192.168.3.171] (141.Red-80-39-252.dynamicIP.rima-tde.net [80.39.252.141])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.marcansoft.com (Postfix) with ESMTPSA id A06A11E806D;
        Wed,  2 Dec 2009 03:46:05 +0100 (CET)
Message-ID: <4B15D4E7.6060707@marcansoft.com>
Date:   Wed, 02 Dec 2009 03:45:59 +0100
From:   Hector Martin <hector@marcansoft.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20091005)
MIME-Version: 1.0
To:     mbizon@freebox.fr
CC:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org,
        ralf@linux-mips.org
Subject: Re: BCM63xx merge progress
References: <4B15974E.1060505@marcansoft.com>    <1259709927.2926.608.camel@sakura.staff.proxad.net>     <4B15B40D.70006@marcansoft.com> <1259719052.2452.26.camel@kero>
In-Reply-To: <1259719052.2452.26.camel@kero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <hector@marcansoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25263
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hector@marcansoft.com
Precedence: bulk
X-list: linux-mips

Maxime Bizon wrote:
> On Wed, 2009-12-02 at 01:25 +0100, Hector Martin wrote:
> 
>> Well, there's a commit (4059ddb4) that claims to "Add USB OHCI support",
>> yet it only adds a #include to ohci-hcd.c and a few .h bits. The actual
>> ohci-bcm63xx.c is missing, which means the OHCI driver probably won't
>> even compile. It's also missing the relevant platform device stuff in
> 
> I cannot find this commit in linus' tree nor linux-mips master, where
> does it come from ?

Okay, nevermind, that was a screwup by me. At some point one of my
OpenWRT patch test commits made its way onto the wrong local branch, and
I didn't notice where it lived. Oops. (This commit was meant to be
incomplete, it comes straight from the OpenWRT patch). I think I found
the mips-bcm63xx (proper) patch, tried to search for it on my local
repo, and this thing popped up and I didn't look at it closely enough.
This is what I get for trying to work at 4am.

I take back the 'broken' then, we're just left with 'incomplete'. Makes
quite a bit more sense now, sorry for the confusion.

> The remaining two patches that were not merged in 2.6.32 are on top of
> this tree: http://www.linux-mips.org/git?p=linux-bcm63xx.git
> 
> They should apply with little difficulty on current upstream kernel and
> besides the *_be stuffs that need to be cleaned up, they were ACKed by
> the usb maintainer.

Cool, I'll see about applying them and working off of that. Thanks for
the confirmation.

FWIW, I'm trying to reverse engineer Broadcom's DSL driver, which I hope
will be useful so we can finally have a properly working OpenWRT
firmware for DSL routers based on this firmware.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
