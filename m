Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Aug 2010 16:33:12 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:33355 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491171Ab0HaOdI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Aug 2010 16:33:08 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o7VEX50K016289;
        Tue, 31 Aug 2010 16:33:06 +0200
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o7VEX51W016287;
        Tue, 31 Aug 2010 16:33:05 +0200
Date:   Tue, 31 Aug 2010 16:33:04 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     loody <miloody@gmail.com>
Cc:     "Maciej W. Rozycki" <macro@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: some question about wmb in mips
Message-ID: <20100831143304.GA16268@linux-mips.org>
References: <AANLkTikXife5CaPBQ4k_FUUM6-VD2C7SOOEbyugRhIqG@mail.gmail.com>
 <alpine.LFD.2.00.1006271745480.14683@eddie.linux-mips.org>
 <20100627205206.GB4554@linux-mips.org>
 <AANLkTim53N4t7PXiRPNqtP0G9cEjMdQY77m73MVkApH5@mail.gmail.com>
 <AANLkTinAP93+W8AYsc_PmjiE0doCERaYiQg4=ztZm_wA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AANLkTinAP93+W8AYsc_PmjiE0doCERaYiQg4=ztZm_wA@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-12-10)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27703
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 30, 2010 at 09:58:27PM +0800, loody wrote:

> after reading the DMA api document and check the source code.
> I found mips seems not implement "dma map ops", but x86 has implemented it.
> What are they used for and why mips don't implement it?

This is useful for multiple sets of methods on more complicated systems.
Right now we just don't need that.

  Ralf
