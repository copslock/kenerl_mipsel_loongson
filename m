Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 00:51:02 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:48558 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491175Ab0JRWu7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Oct 2010 00:50:59 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9IMovpQ018652;
        Mon, 18 Oct 2010 23:50:57 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9IMoukm018651;
        Mon, 18 Oct 2010 23:50:56 +0100
Date:   Mon, 18 Oct 2010 23:50:56 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Shinya Kuribayashi <skuribay@pobox.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
Message-ID: <20101018225056.GI27377@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
 <4CBC4F4E.5010305@pobox.com>
 <20101018191936.GH27377@linux-mips.org>
 <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28145
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Oct 18, 2010 at 12:41:20PM -0700, Kevin Cernekee wrote:

> On Mon, Oct 18, 2010 at 12:19 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
> > I'm trying to get a statement from the MIPS architecture guys if the
> > necessity to do anything beyond a cache flush is an architecture violation.
> 
> IMO such a requirement would be unnecessarily strict.  Larger flushes
> (e.g. page at a time) tend to benefit from some form of pipelining or
> write gathering.  Forcing the processor to flush exactly 32 bytes at a
> time, synchronously, could really slow things down and thrash the
> memory controller.
> 
> I have not been able to find any official statement from MIPS that
> says that CACHE + SYNC should be used, but that seems like the most
> intuitive way to implement things on the hardware side.

I agree with you but I seem to remember having read something that suggests
otherwise.  Oh well, maybe it's just something in the Cambridge water
that makes my halocinate ;)

  Ralf
