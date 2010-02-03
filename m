Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 13:33:24 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:59764 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1491050Ab0BCMdU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 13:33:20 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o13CXW7t006907;
        Wed, 3 Feb 2010 13:33:33 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o13CXVvB006904;
        Wed, 3 Feb 2010 13:33:31 +0100
Date:   Wed, 3 Feb 2010 13:33:31 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Anoop P.A." <Anoop_P.A@pmc-sierra.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: Cached Base address difference.
Message-ID: <20100203123331.GB20375@linux-mips.org>
References: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com>
 <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com>
 <20100203012934.GA20375@linux-mips.org>
 <A7DEA48C84FD0B48AAAE33F328C0201404809DE0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A7DEA48C84FD0B48AAAE33F328C0201404809DE0@BBY1EXM11.pmc_nt.nt.pmc-sierra.bc.ca>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25867
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Feb 03, 2010 at 03:34:25AM -0800, Anoop P.A. wrote:

> I am seeing a address conflict in asm-generic/spaces.h  . in spaces.h (
> 64 bit)CAC_BASE has been defined as 0x9800000000000000 however see mips
> run says it is 0x9000000000000000
> http://books.google.co.in/books?id=kk8G2gK4Tw8C&lpg=PP1&dq=see%20mips%20
> run&pg=PA51#v=onepage&q=&f=false
> 
> Is this intentional?

<asm/mach-generic/spaces.h> defines:

#ifndef CAC_BASE
#ifdef CONFIG_DMA_NONCOHERENT
#define CAC_BASE                _AC(0x9800000000000000, UL)
#else
#define CAC_BASE                _AC(0xa800000000000000, UL)
#endif
#endif

No 0x9000000000000000 anywhere - and it would be wrong because it stands
for uncached.

  Ralf
