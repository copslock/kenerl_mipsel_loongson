Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jan 2016 15:03:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57104 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27014865AbcAVODHJwt85 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jan 2016 15:03:07 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u0ME35je024455;
        Fri, 22 Jan 2016 15:03:05 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u0ME34Bp024454;
        Fri, 22 Jan 2016 15:03:04 +0100
Date:   Fri, 22 Jan 2016 15:03:04 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     James Hogan <james.hogan@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Leonid Yegoshin <leonid.yegoshin@imgtec.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: [PATCH 1/2] MIPS: c-r4k: Sync icache when it fills from dcache
Message-ID: <20160122140303.GC1802@linux-mips.org>
References: <1453460306-8505-1-git-send-email-james.hogan@imgtec.com>
 <1453460306-8505-2-git-send-email-james.hogan@imgtec.com>
 <CAOLZvyGeAgMt1KbmQR7c96WWXNJLr89b8hNSi9SePtjUK5K5fg@mail.gmail.com>
 <20160122121908.GG31243@jhogan-linux.le.imgtec.org>
 <56A22936.8050601@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56A22936.8050601@gentoo.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51307
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

On Fri, Jan 22, 2016 at 08:05:58AM -0500, Joshua Kinard wrote:

> > FWIW, attached is the test program I mentioned, which hits the first
> > part of this patch (flush_cache_range) via mprotect(2) and checks if
> > icache seems to have been flushed (tested on mips64r6, but should be
> > portable).
> 
> Here's the output on my Octane, R14000 CPU (mips4):
> 
> # ./mprotect
> Initial mprotect SUCCESS
> Looped { mprotect RW, modify, mprotect RX, test } SUCCESS
> 
> This is without your patch applied.  That look good?  I'm assuming this CPU is
> too old to be affected.  I can test with your patch after the blizzard is over
> later this weekend.

The R10000 family refills the I-cache from the S-cache so is not affected
by the scenario James' patch is for.

  Ralf
