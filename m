Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Jul 2010 15:02:29 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:41371 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491849Ab0GFNCZ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 6 Jul 2010 15:02:25 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o66D21Fm028815;
        Tue, 6 Jul 2010 14:02:01 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o66D1xq1028814;
        Tue, 6 Jul 2010 14:01:59 +0100
Date:   Tue, 6 Jul 2010 14:01:59 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Manuel Lauss <manuel.lauss@googlemail.com>
Cc:     FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        linux-mips@linux-mips.org, manuel.lauss@gmail.com
Subject: Re: [PATCH] MIPS: Alchemy: fix deprecated compile warnings
Message-ID: <20100706130159.GA6613@linux-mips.org>
References: <20100624012415L.fujita.tomonori@lab.ntt.co.jp>
 <AANLkTimNUemAUf8OI_lQYw4eDRC3uo0rTWORxH1wqHU_@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AANLkTimNUemAUf8OI_lQYw4eDRC3uo0rTWORxH1wqHU_@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Jun 23, 2010 at 06:31:18PM +0200, Manuel Lauss wrote:

> > replace deprecated DMA_32BIT_MASK with DMA_BIT_MASK.
> >
> > cc1: warnings being treated as errors
> > arch/mips/alchemy/devboards/db1200/platform.c:219: error: 'DMA_nnBIT_MASK' is deprecated
> > arch/mips/alchemy/devboards/db1200/platform.c:226: error: 'DMA_nnBIT_MASK' is deprecated
> > arch/mips/alchemy/devboards/db1200/platform.c:388: error: 'DMA_nnBIT_MASK' is deprecated
> > arch/mips/alchemy/devboards/db1200/platform.c:393: error: 'DMA_nnBIT_MASK' is deprecated
> >
> > Signed-off-by: FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>
> > ---
> >  arch/mips/alchemy/devboards/db1200/platform.c |    8 ++++----
> >  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> Acked-by: Manuel Lauss <manuel.lauss@googlemail.com>

Thanks, Fujita-San.  Patch applied.

This one became necessary due to the migration to the new MIPS platform
makefiles which also enable -Werror for all platforms and
arch/mips/alchemy/devboards/db1200/ was previously one of the few
subdirs still getting built without -Werror.

  Ralf
