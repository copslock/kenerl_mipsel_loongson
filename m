Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 12:15:55 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:44553 "EHLO duck.linux-mips.net"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491808Ab1EMKPw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 12:15:52 +0200
Received: from duck.linux-mips.net (duck.linux-mips.net [127.0.0.1])
        by duck.linux-mips.net (8.14.4/8.14.3) with ESMTP id p4DAHHoY025506;
        Fri, 13 May 2011 11:17:17 +0100
Received: (from ralf@localhost)
        by duck.linux-mips.net (8.14.4/8.14.4/Submit) id p4DAHGaJ025504;
        Fri, 13 May 2011 11:17:16 +0100
Date:   Fri, 13 May 2011 11:17:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Wu Zhangjin <wuzhangjin@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MIPS: Squash pci_fixup_irqs() compiler warning
Message-ID: <20110513101716.GB25345@linux-mips.org>
References: <cb01d61712b1374a8c62bc765094ea7e@localhost>
 <4DAC7499.5000602@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4DAC7499.5000602@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29976
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Apr 18, 2011 at 10:27:53AM -0700, David Daney wrote:

> >It's been two years since the original discussion, and the warning is
> >still there.  It is now the only warning left in my kernel build.
> >
> >I was hoping we could get this resolved for good (one way or another).

[...]

> NAK.
> 
> I think Ralf's idea in the e-mail you referenced is the proper approach.
> 
> Change pci_fixup_irqs(...) to take a 'const struct pci_dev *'
> instead. There is a lot of work going on in the kernel to constify
> things.  This should be fairly easy to get accepted.

It's a fairly big manual job but should be just right for spatch.

  Ralf
