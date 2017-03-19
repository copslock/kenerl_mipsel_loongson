Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Mar 2017 09:55:16 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:51294 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23991976AbdCSIzHDaufA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 19 Mar 2017 09:55:07 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v2J8t4ZU003769;
        Sun, 19 Mar 2017 09:55:05 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v2J8t443003766;
        Sun, 19 Mar 2017 09:55:04 +0100
Date:   Sun, 19 Mar 2017 09:55:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     linux-mips@linux-mips.org
Subject: Re: ARCS can't load CONFIG_DEBUG_LOCK_ALLOC kernel
Message-ID: <20170319085504.GB14919@linux-mips.org>
References: <8b2d7473-ba4d-f2c9-27e7-b1a30b95c4f8@gentoo.org>
 <a639551b-4338-e1fb-0cc7-e6ea34b94c2c@gentoo.org>
 <20170316140918.GH5512@linux-mips.org>
 <86da6dd2-7b02-cd0d-f152-00dfb134a3ec@gentoo.org>
 <20170316190629.GP5512@linux-mips.org>
 <13b0221d-c17a-7e5b-6bb5-702ee7d896c1@gentoo.org>
 <20170316205006.GE10914@linux-mips.org>
 <c969ac8f-2915-6d9c-cc59-0da77199b3a1@gentoo.org>
 <23538ffb-4ab5-22b5-d740-fbe5fadf8aa0@gentoo.org>
 <680b861f-c60f-441a-53ff-f79edb0ce044@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <680b861f-c60f-441a-53ff-f79edb0ce044@gentoo.org>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57388
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Sun, Mar 19, 2017 at 03:23:39AM -0400, Joshua Kinard wrote:

> The closest I've gotten to extracting info on the state of the machine is to
> set the MSC debug switches to 0x1018 and then issue an immediate reset to have
> it drop into POD dirty-exclusive as soon as possible.  Then running "why"
> sometimes nets me a valid kernel address in EPC that tells me where the POD CPU
> was last at.  Downside, I have four CPUs and MSC POD locks up if I try
> switching to any of the other CPUs.  So I can't get a register dump off of the
> other three.

Have you tried to send an NMI fro the MSC?  The PoD debugger is actually
a fairly handy tool in such cases.

> 2A 000: Done initializing klconfig.
> 2A 000: Discovering NUMAlink connectivity .........             DONE
> 2A 000: Found 2 objects (2 hubs, 0 routers) in 511413 usec
> 1B 000: Testing/Initializing memory ...............             DONE
> 2A 000: Waiting for peers to complete discovery....             Reading link 0
> (addr 0x92000000
> 2A 000: 00000004) failed
> 1B 000: CPU B switching to UALIAS
> 1B 000: CPU B now running out of UALIAS
> 2A 000: Reading link 0 (addr 0x9200000000000004) failed
> 1B 000: Skipping secondary cache diags
> 1B 000: CPU B switching stack into UALIAS and invalidating D-cache
> 1B 000: CPU B switching into node 0 cached RAM
> 1B 000: CPU B running cached
> 2A 000: Reading link 0 (addr 0x9200000000000004) failed
> 2A 000: Reading link 0 (addr 0x9200000000000004) failed

I thought that kind of messages was indicating a hardware issue.

> Then it gets a general exception and drops to POD Dex:
> 1B 000: Local Slave : Waiting for my NASID ...
> 1B 000: CPU B switching to UALIAS
> 1B 000: CPU B running in UALIAS
> 1B 000: CPU B Flushing and invalidating caches
> 1B 000: CPU B switching to node 0 cached RAM
> 1B 000: CPU B running cached
> 1A 000:
> 1A 000: *** General Exception on node 0
> 1A 000: *** EPC: 0xc00000001fc473dc (0xc00000001fc473dc)
> 1A 000: *** Press ENTER to continue.
> 1A 000: POD MSC Dex>
> 
> If this is a hardware lock up, that might explain why kgdb isn't useful at that
> point.  POD lets me dump the CRBs and PI error spool, but I'm not sure how
> useful that information is w/o SGI's internal documents.

I still haven't forgotten everything (I hope) so maybe you could post that
information anyway just to use the small chance there ight be something
useful in there?

  Ralf
