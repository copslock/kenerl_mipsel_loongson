Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 16:00:48 +0200 (CEST)
Received: from mail-d.ads.isi.edu ([128.9.180.199]:18243 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994056AbeHBOAlc8Bmi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 16:00:41 +0200
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="2662692"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 07:00:34 -0700
Date:   Thu, 2 Aug 2018 10:00:33 -0400
From:   Alexei Colin <acolin@isi.edu>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>, alex.bou9@gmail.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Will Deacon <will.deacon@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jwalters@isi.edu, Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [RESEND PATCH 6/6] arm64: enable RapidIO menu in Kconfig
Message-ID: <20180802140033.GH38497@guest228.east.isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
 <20180802134544.GG38497@guest228.east.isi.edu>
 <20180802135421.GA13512@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180802135421.GA13512@infradead.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <acolin@isi.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65355
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: acolin@isi.edu
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

On Thu, Aug 02, 2018 at 06:54:21AM -0700, Christoph Hellwig wrote:
> On Thu, Aug 02, 2018 at 09:45:44AM -0400, Alexei Colin wrote:
> > If I move RapidIO option to drivers/Kconfig, then it won't appear under
> > the Bus Options/System Support menu, along with other choices for the
> > system bus (PCI, PCMCIA, ISA, TC, ...).
> 
> It's not like anyone cares.  And FYI, moving all those to
> drivers/Kconfig is osmething I will submit for the next merge window.

Ok, I would appreciate a CC on that patch. After it lands, if
there is time, I'll resubmit a rebased version of this patch.
