Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Aug 2018 15:46:02 +0200 (CEST)
Received: from mail-d.ads.isi.edu ([128.9.180.199]:9565 "EHLO
        mail-d.ads.isi.edu" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994056AbeHBNp6Wn5ai (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Aug 2018 15:45:58 +0200
X-IronPort-AV: E=Sophos;i="5.51,436,1526367600"; 
   d="scan'208";a="2662501"
Received: from guest228.east.isi.edu (HELO localhost) ([65.123.202.228])
  by mail-d.ads.isi.edu with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 02 Aug 2018 06:45:46 -0700
Date:   Thu, 2 Aug 2018 09:45:44 -0400
From:   Alexei Colin <acolin@isi.edu>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     alex.bou9@gmail.com, Christoph Hellwig <hch@infradead.org>,
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
Message-ID: <20180802134544.GG38497@guest228.east.isi.edu>
References: <20180731142954.30345-1-acolin@isi.edu>
 <20180731142954.30345-7-acolin@isi.edu>
 <20180801095404.GA17585@infradead.org>
 <fad8661c-cd8c-3a9c-ca03-5d2f63893a24@gmail.com>
 <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVDra1MKcuuD0SqEYXSggr0iVFcbcjL33z7JuiE1_y8yw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Return-Path: <acolin@isi.edu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65353
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

On Thu, Aug 02, 2018 at 10:57:00AM +0200, Geert Uytterhoeven wrote:
> On Wed, Aug 1, 2018 at 3:16 PM Alex Bounine <alex.bou9@gmail.com> wrote:
> > On 2018-08-01 05:54 AM, Christoph Hellwig wrote:
> > > On Tue, Jul 31, 2018 at 10:29:54AM -0400, Alexei Colin wrote:
> > >> Platforms with a PCI bus will be offered the RapidIO menu since they may
> > >> be want support for a RapidIO PCI device. Platforms without a PCI bus
> > >> that might include a RapidIO IP block will need to "select HAS_RAPIDIO"
> > >> in the platform-/machine-specific "config ARCH_*" Kconfig entry.
> > >>
> > >> Tested that kernel builds for arm64 with RapidIO subsystem and
> > >> switch drivers enabled, also that the modules load successfully
> > >> on a custom Aarch64 Qemu model.
> > >
> > > As said before, please include it from drivers/Kconfig so that _all_
> > > architectures supporting PCI (or other Rapidio attachements) get it
> > > and not some arbitrary selection of architectures.
> 
> +1
> 
> > As it was replied earlier this is not a random selection of
> > architectures but only ones that implement support for RapidIO as system
> > bus. If other architectures choose to adopt RapidIO we will include them
> > as well.
> >
> > On some platforms RapidIO can be the only system bus available replacing
> > PCI/PCIe or RapidIO can coexist with PCIe.
> >
> > As it is done now, RapidIO is configured in "Bus Options" (x86/PPC) or
> > "Bus Support" (ARMs) sub-menu and from system configuration option it
> > should be kept this way.
> >
> > Current location of RAPIDIO configuration option is familiar to users of
> > PowerPC and x86 platforms, and is similarly available in some ARM
> > manufacturers kernel code trees.
> >
> > drivers/Kconfig will be used for configuring drivers for peripheral
> > RapidIO devices if/when such device drivers will be published.
> 
> Everything in drivers/rapidio/Kconfig depends on RAPIDIO (probably it should
> use a big if RAPIDIO/endif instead), so it can just be included from
> drivers/Kconfig now.
> 
> The sooner you do that, the less treewide changes are needed (currently
> limited to mips, powerpc, and x86; your patch adds arm64).

If I move RapidIO option to drivers/Kconfig, then it won't appear under
the Bus Options/System Support menu, along with other choices for the
system bus (PCI, PCMCIA, ISA, TC, ...). Alex explains above that RapidIO
may be selected as a system bus on some architectures, and users expect
it to be in the menu in which it has been for some time now.  What
problem is the current organization causing?

This patch does not intend to propose any changes to the current
organization of the menus, if such changes are needed, another patch can
be made with that purpose. What problem is this patch introducing?
