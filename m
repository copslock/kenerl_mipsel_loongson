Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2010 04:56:05 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44230 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1490976Ab0F1C4B (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jun 2010 04:56:01 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o5RKdfCA004654;
        Sun, 27 Jun 2010 21:39:42 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o5RKdfEb004652;
        Sun, 27 Jun 2010 21:39:41 +0100
Date:   Sun, 27 Jun 2010 21:39:40 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     loody <miloody@gmail.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about wmb in mips
Message-ID: <20100627203940.GA4554@linux-mips.org>
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
X-archive-position: 27268
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18364

On Mon, Jun 28, 2010 at 12:16:06AM +0800, loody wrote:

> Dear all:
> AFAIK, wmb in mips is implemented by calling sync,
> wmb->fast_wmb->__sync, which makes sure Loads and stores executed
> before the SYNC are completed before loads
> and stores after the SYNC can start
> But will this instruction write the cache back too?

No.

> take usb example, it will call this maco before it let host processing
> the commands on dram, so I wondering whether sync will write the cache
> back to memory.

SYNC is for memory consistency, not coherency.

  Ralf
