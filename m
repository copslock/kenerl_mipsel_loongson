Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Jan 2011 23:33:42 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:60498 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491030Ab1AHWdj (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 8 Jan 2011 23:33:39 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1PbhLt-0008I1-00; Sat, 08 Jan 2011 23:33:37 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 12FCA1D45C; Sat,  8 Jan 2011 23:33:24 +0100 (CET)
Date:   Sat, 8 Jan 2011 23:33:24 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
Cc:     Linux MIPS org <linux-mips@linux-mips.org>
Subject: Re: MIPS Malta and PCNet32 Driver
Message-ID: <20110108223323.GA20092@alpha.franken.de>
References: <4D28AFB4.7090108@paralogos.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4D28AFB4.7090108@paralogos.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28888
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Sat, Jan 08, 2011 at 10:40:52AM -0800, Kevin D. Kissell wrote:
> I'm suspecting that the problem is at least as likely to be in the Malta
> PCI support as in the PCNet driver itself.  Is this phenomenon
> understood? Has there been a fix circulated for it?

the pcnet32 driver first resets the chip and then checks CSR0 to see that
the chip is really reset. It also checks, if writing the register index
register works. It looks like something is wrong here with accessing the chip
for what ever reason. This probing part of the driver hasn't changed for a long
time, at least it fairly looks like it was, when I still was the maintainer
of the driver. 

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
