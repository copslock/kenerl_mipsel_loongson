Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2010 23:11:03 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:47739 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492495Ab0BXWK7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 24 Feb 2010 23:10:59 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NkPRb-0001R2-00; Wed, 24 Feb 2010 23:10:59 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 72858C34E5; Wed, 24 Feb 2010 23:10:53 +0100 (CET)
Date:   Wed, 24 Feb 2010 23:10:53 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Bjorn Helgaas <bjorn.helgaas@hp.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: RFC: [MIPS] BCM1480/BCM1480HT remove io_offset
Message-ID: <20100224221053.GB20280@alpha.franken.de>
References: <201002241338.41501.bjorn.helgaas@hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201002241338.41501.bjorn.helgaas@hp.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26033
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Wed, Feb 24, 2010 at 01:38:41PM -0700, Bjorn Helgaas wrote:
> BCM1480 and BCM1480HT currently offset the Linux ioport space from the

BCM1480 and BCM1480HT are two hoses on the same chip. Since there is
only one PCI IO port range, it's probably not a good idea to let
both busses use the same IO port range. But maybe I'm overlooking
something.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
