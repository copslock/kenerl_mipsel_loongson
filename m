Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 06:00:05 +0200 (CEST)
Received: from linux-sh.org ([111.68.239.195]:38705 "EHLO linux-sh.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903394Ab2FTD77 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 05:59:59 +0200
Received: from linux-sh.org (localhost.localdomain [127.0.0.1])
        by linux-sh.org (8.14.5/8.14.4) with ESMTP id q5K3xrTl018403;
        Wed, 20 Jun 2012 12:59:53 +0900
Received: (from pmundt@localhost)
        by linux-sh.org (8.14.5/8.14.4/Submit) id q5K3xpgt017547;
        Wed, 20 Jun 2012 12:59:51 +0900
X-Authentication-Warning: linux-sh.org: pmundt set sender to lethal@linux-sh.org using -f
Date:   Wed, 20 Jun 2012 12:59:51 +0900
From:   Paul Mundt <lethal@linux-sh.org>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
Message-ID: <20120620035951.GC5623@linux-sh.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33730
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lethal@linux-sh.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Sun, Jun 17, 2012 at 09:56:59PM +0200, Geert Uytterhoeven wrote:
> On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
> > JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
> > ??- build errors: +235/-10
> 
> Truckloads of powerpc "Unrecognized opcode" breakage, and
> 
That was my fault, should be fixed up by 2603efa31a.

>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
> declaration of function 'pci_iomap'
> [-Werror=implicit-function-declaration]:  => 90:3
>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
> declaration of function 'pci_iounmap'
> [-Werror=implicit-function-declaration]:  => 142:2
> 
Not sure about this one, it should find everything alright via:

	linux/io.h -> asm/io.h -> asm-generic/iomap.h -> asm-generic/pci_iomap.h

in the case that PCI is enabled. None of allyesconfig/modconfig enable
PCI for me though, so I'm unsure of how you got in to this configuration
to begin with?

> xtensa
> 
>   + error: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
> 
> sh4/landisk_defconfig
> 
>   + error: "__ashrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [drivers/mtd/mtd.ko] undefined!:  => N/A
>   + error: "__lshrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
> 
These seem to be the same issue on both platforms, EXPORT_SYMBOL()
doesn't work from lib-y. While it's straightforward to fix, I'm not able
to reproduce __lshrdi3/__ashrdi3 references in any of the above, which
compiler are you using?
