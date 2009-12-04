Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2009 19:33:28 +0100 (CET)
Received: from elvis.franken.de ([193.175.24.41]:45658 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490960AbZLDSdZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Dec 2009 19:33:25 +0100
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1NGcy5-0003nJ-00; Fri, 04 Dec 2009 19:33:25 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
        id 9538FDE1DF; Fri,  4 Dec 2009 19:33:09 +0100 (CET)
Date:   Fri, 4 Dec 2009 19:33:09 +0100
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     Ed Okerson <ed.okerson@gmail.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: mmap KSEG1
Message-ID: <20091204183309.GA10383@alpha.franken.de>
References: <83f0348b0912040952h40d4d151n79ca5fc33a830ee2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <83f0348b0912040952h40d4d151n79ca5fc33a830ee2@mail.gmail.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25324
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

On Fri, Dec 04, 2009 at 11:52:03AM -0600, Ed Okerson wrote:
> Is it possible to mmap an address in KSEG1 so a user space app can
> read/write to an IO device uncached?

well not exactly to KSEG1, since that is kernel exclusive address space,
but it's possible to map the physical address of the device:

Try

fd = open("/dev/mem", O_RDWR|O_SYNC);
io = mmap (NULL, 4096, PROT_READ|PROT_WRITE, MAP_PRIVATE, fd, ioaddr);

where ioaddr is the physical address of the io device.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessary a
good idea.                                                [ RFC1925, 2.3 ]
