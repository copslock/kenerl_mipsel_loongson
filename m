Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 14:34:53 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:39479 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491869Ab0JSMeq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Oct 2010 14:34:46 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o9JCYi99004907;
        Tue, 19 Oct 2010 13:34:44 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o9JCYhRT004903;
        Tue, 19 Oct 2010 13:34:43 +0100
Date:   Tue, 19 Oct 2010 13:34:41 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Shinya Kuribayashi <skuribay@pobox.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
Message-ID: <20101019123441.GJ27377@linux-mips.org>
References: <17ebecce124618ddf83ec6fe8e526f93@localhost>
 <17d8d27a2356640a4359f1a7dcbb3b42@localhost>
 <4CBC4F4E.5010305@pobox.com>
 <AANLkTinpry=XG-ZDgXJK-VB6QkBL2TO4-vrsV5Tc1eEs@mail.gmail.com>
 <alpine.LFD.2.00.1010190146360.15889@eddie.linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1010190146360.15889@eddie.linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28155
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 19, 2010 at 01:57:43AM +0100, Maciej W. Rozycki wrote:

>  Ah, the old issue of the write-back barrier.  I can't comment on 
> Loongson, but for DEC IIRC the write-back buffer only needs to be taken 
> care of for uncached writes and they take a path separate to cached 
> writes.  I'd have to dig out the details to be sure.  IIRC the most 
> pathological case was the R2020 WB chip, but that was only used on systems 
> that didn't do DMA (namely DECstatation 3100 and 2100 boxes).

See R4000 User's Manual Version 2, page 326, "Uncached Loads and Stores".
Of course this can only happen on cache coherent or multiprocessor systems.
I guess none of the supported DEC MIPS systems is affected.

  Ralf
