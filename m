Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2018 17:51:15 +0200 (CEST)
Received: from pio-pvt-msa3.bahnhof.se ([79.136.2.42]:33332 "EHLO
        pio-pvt-msa3.bahnhof.se" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991172AbeDIPvIEfqBJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2018 17:51:08 +0200
Received: from localhost (localhost [127.0.0.1])
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTP id 6290A40900;
        Mon,  9 Apr 2018 17:51:07 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at bahnhof.se
Received: from pio-pvt-msa3.bahnhof.se ([127.0.0.1])
        by localhost (pio-pvt-msa3.bahnhof.se [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id g1Mn6OQ6z_jt; Mon,  9 Apr 2018 17:51:01 +0200 (CEST)
Received: from localhost.localdomain (h-155-4-135-114.NA.cust.bahnhof.se [155.4.135.114])
        (Authenticated sender: mb547485)
        by pio-pvt-msa3.bahnhof.se (Postfix) with ESMTPA id 5101E3F7C9;
        Mon,  9 Apr 2018 17:51:01 +0200 (CEST)
Date:   Mon, 9 Apr 2018 17:51:00 +0200
From:   Fredrik Noring <noring@nocrew.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     =?utf-8?Q?J=C3=BCrgen?= Urban <JuergenUrban@gmx.de>,
        linux-mips@linux-mips.org
Subject: Re: [RFC] MIPS: PS2: Interrupt request (IRQ) support
Message-ID: <20180409155057.GA2235@localhost.localdomain>
References: <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk>
 <20170930065654.GA7714@localhost.localdomain>
 <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain>
 <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk>
 <20171111160422.GA2332@localhost.localdomain>
 <20180129202715.GA4817@localhost.localdomain>
 <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180303122657.GC24991@localhost.localdomain>
 <alpine.DEB.2.00.1803031306530.10166@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1803031306530.10166@tp.orcam.me.uk>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <noring@nocrew.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63474
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: noring@nocrew.org
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

Hi Maciej,

>  I'm on holiday starting today and lasting two weeks.  I'll have a look at 
> your patch when I am back.

How are the reviews going? I think some of the most important and for me
least understood parts of the initial submission are:

https://www.linux-mips.org/archives/linux-mips/2018-02/msg00100.html
https://www.linux-mips.org/archives/linux-mips/2018-02/msg00102.html
https://www.linux-mips.org/archives/linux-mips/2018-02/msg00103.html
https://www.linux-mips.org/archives/linux-mips/2018-02/msg00117.html
https://www.linux-mips.org/archives/linux-mips/2018-02/msg00219.html
https://www.linux-mips.org/archives/linux-mips/2018-02/msg00221.html
https://www.linux-mips.org/archives/linux-mips/2018-03/msg00035.html

I'm currently rewriting the Graphics Synthesizer and frame buffer drivers
from scratch, with the following changes:

- modules;
- proper handling of video modes;
- several new video modes including 1920x1080p;
- compatibility with PS2 HDMI adapters;
- extended sysfs with register files;
- hardware support for panning, etc.
- vertical blank synchronisation;
- performance improvements;
- bug fixes.

One critical issue with the OHCI driver was resolved in commit d6c931ea32dc0
"USB: OHCI: Fix NULL dereference in HCDs using HCD_LOCAL_MEM". Robin Murphy
and Christoph Hellwig proposed fixes to DMA handling and Robin will submit a
patch as discussed here:

https://marc.info/?t=152010179900001&r=1&w=2

The OHCI driver still has an issue (and workaround) with interrupts, related
to the IRQ handling.

Fredrik
