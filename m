Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 21:49:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:42655 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6824283AbaAUUtloxHZg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 21:49:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s0LKndRD031628;
        Tue, 21 Jan 2014 21:49:39 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s0LKnctI031627;
        Tue, 21 Jan 2014 21:49:38 +0100
Date:   Tue, 21 Jan 2014 21:49:38 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using
 prefetching.
Message-ID: <20140121204938.GW14169@linux-mips.org>
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39049
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

On Tue, Jan 21, 2014 at 10:18:42AM -0600, Steven J. Hill wrote:

> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
> 
> Use the PREF instruction to optimize partial checksum operations.

Prefetch operations may cause obscure bus error exceptions on some systems
such as Malta, for example, when prefetching beyond the end of memory.
It may also mean memory regions that are just undergoing a DMA transfer
are being brought back into cache.

This pretty much means that pref is only safe to use on cache-coherent
systems.

Those are the very same reasons that are making pref headache for memcpy.

Performance tuning is another can of worms.  On those platforms that I've
benchmarked code with and without pref on, it was very hard to predict
if pref was actually an advantage.  If data that is not going to be
used is prefetch, pref wastes an issue slot, wastes instruction bandwith
and in the end makes things slower.  If data is not prefetched early
enough, same kind of issue.  And in the end PREF and MT were invented
to solve the same kind of fundamental problem: memory is slow and slower
on embedded.  For both solutions the results are extremly dependent on
workload.

Cheers,

  Ralf
