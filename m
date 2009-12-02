Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Dec 2009 01:26:05 +0100 (CET)
Received: from marcansoft.com ([80.68.93.119]:47940 "EHLO smtp.marcansoft.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1493603AbZLBA0B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 2 Dec 2009 01:26:01 +0100
Received: from [192.168.3.171] (141.Red-80-39-252.dynamicIP.rima-tde.net [80.39.252.141])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.marcansoft.com (Postfix) with ESMTPSA id 46ECD1E806D;
        Wed,  2 Dec 2009 01:25:53 +0100 (CET)
Message-ID: <4B15B40D.70006@marcansoft.com>
Date:   Wed, 02 Dec 2009 01:25:49 +0100
From:   Hector Martin <hector@marcansoft.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20091005)
MIME-Version: 1.0
To:     mbizon@freebox.fr, Florian Fainelli <florian@openwrt.org>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: BCM63xx merge progress
References: <4B15974E.1060505@marcansoft.com> <1259709927.2926.608.camel@sakura.staff.proxad.net>
In-Reply-To: <1259709927.2926.608.camel@sakura.staff.proxad.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <hector@marcansoft.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hector@marcansoft.com
Precedence: bulk
X-list: linux-mips

Maxime Bizon wrote:
> Which part is broken/missing on your side ?
> 

Well, there's a commit (4059ddb4) that claims to "Add USB OHCI support",
yet it only adds a #include to ohci-hcd.c and a few .h bits. The actual
ohci-bcm63xx.c is missing, which means the OHCI driver probably won't
even compile. It's also missing the relevant platform device stuff in
arch/. This concerned me somewhat, it looked like something weird had
happened and the merge was incomplete.

Florian Fainelli wrote:
> Everything that Maxime sent is, or will be merged either in 2.6.32 or
> in 2.6.33, that includes:
> - arch/mips/bcm63xx (will be in 2.6.32)
> - USB driver bits (2.6.33)
> - Ethernet MAC driver bits (2.6.32)
> - Ethernet PHY driver bits (2.6.32)
> - UART driver (2.6.32)
> - PCMCIA support (2.6.32)

I can see the 2.6.32 stuff already. Regarding USB, is there a repo with
the commit that will be in .33? Otherwise I'll just have to merge it
locally and work from there for the moment. What's up with the weirdo
commit mentioned above?

> We maintain a couple of different patches for OpenWrt, specifically
> the mtd partition parser since we provide images, so the box should
> boot from Flash. That driver is not in a mergable state at the moment.
> There is also a embryon of a SPI driver and a watchdog driver, which I
> will probably submit once cleaned up.

Another tidbit I saw in the OpenWRT set is the reset button GPIO
support. I want to have that (eventually) too.

Basically, my dilemma is simply that I want to work off of mainline
(especially since stuff has been partially merged already and changes
have been made), yet I need the missing patches in order to make this
work completely. So eventually I need a tree that contains everything I
need, whether a few individual commits are not really ready for mainline
or not. In doing this, I obviously want to keep in sync with any work
that has been done already as much as possible. So please do tell if
there's a specific place I should be looking at for mainline-compatible
versions of these patches, or anything closer to what will eventually be
merged. As I said, I don't mind doing the merges myself, but then it
might make rebasing onto mainline harder if your official patches are
merged in a substantially different way once they do make it to
mainline. And if I do end up merging stuff, I might as well send it to
you to save you some time.

-- 
Hector Martin (hector@marcansoft.com)
Public Key: http://www.marcansoft.com/marcan.asc
