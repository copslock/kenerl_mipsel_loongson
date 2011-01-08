Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 09 Jan 2011 00:07:27 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:39434 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491026Ab1AHXHY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 9 Jan 2011 00:07:24 +0100
Date:   Sat, 8 Jan 2011 23:07:24 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     "Kevin D. Kissell" <kevink@paralogos.com>
cc:     Linux MIPS org <linux-mips@linux-mips.org>,
        tsbogend@alpha.franken.de
Subject: Re: MIPS Malta and PCNet32 Driver
In-Reply-To: <4D28C2C7.2080005@paralogos.com>
Message-ID: <alpine.LFD.2.00.1101082251440.31930@eddie.linux-mips.org>
References: <4D28AFB4.7090108@paralogos.com> <4D28C2C7.2080005@paralogos.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, 8 Jan 2011, Kevin D. Kissell wrote:

> and, amusingly, from a stock 2.6.32.27 kernel that exhibits the problem,
> I plugged in a PCI NIC and *both* interfaces came up happy.  :o/   One
> might suspect that PCNet32 now assumes some level of initialization that
> isn't being done in the platform code, and lucks out if a more
> thoroughly paranoid driver gets loaded first.

 Are you seeing the problem with a system controller other than the 
Bonito?  That would be somewhat alarming, though easier to fix.

 With the Bonito I'd have assumed it was some low-level PCI code rewrite 
-- that seem to keep happening over and over again -- that missed a bit in 
the Bonito driver or the driver altogether.  With the Bonito core cards 
limited to the MIPS 20Kc core and some exotic (for the Malta) QED CPU 
options that would be no surprise at all to me.

  Maciej
