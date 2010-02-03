Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2010 02:29:36 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:60212 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S1492832Ab0BCB3c (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 3 Feb 2010 02:29:32 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id o131Tdm5020514;
        Wed, 3 Feb 2010 02:29:39 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id o131TY5h020512;
        Wed, 3 Feb 2010 02:29:34 +0100
Date:   Wed, 3 Feb 2010 02:29:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Shane McDonald <mcdonald.shane@gmail.com>
Cc:     Wu Zhangjin <wuzhangjin@gmail.com>,
        David VomLehn <dvomlehn@cisco.com>, mbizon@freebox.fr,
        linux-mips@linux-mips.org
Subject: Re: [PATCH urgent] MIPS: Fixup of the r4k timer
Message-ID: <20100203012934.GA20375@linux-mips.org>
References: <1265015455-32553-1-git-send-email-wuzhangjin@gmail.com>
 <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2b2f2321002011903m7a090481m52d84a664beb5468@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25863
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Feb 01, 2010 at 09:03:10PM -0600, Shane McDonald wrote:

> On Mon, Feb 1, 2010 at 3:10 AM, Wu Zhangjin <wuzhangjin@gmail.com> wrote:
> >
> > From: Wu Zhangjin <wuzhangjin@gmail.com>
> >
> > As reported by Maxime Bizon, the commit "MIPS: PowerTV: Fix support for
> > timer interrupts with > 64 external IRQs" have broken the r4k timer
> > since it didn't initialize the cp0_compare_irq_shift variable used in
> > c0_compare_int_pending() on the architectures whose cpu_has_mips_r2 is
> > false.
> >
> > This patch fixes it via initializing the cp0_compare_irq_shift as the
> > cp0_compare_irq used in the old c0_compare_int_pending().
> >
> > Reported-by: Maxime Bizon <mbizon@freebox.fr>
> > Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
> 
> When applied to 2.6.33-rc6, this patch fixes the problem on my
> RM7035C-based system.
> 
> Tested-by: Shane McDonald <mcdonald.shane@gmail.com>

Thanks folks, applied.

  Ralf
