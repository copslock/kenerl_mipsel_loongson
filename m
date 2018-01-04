Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2018 09:48:37 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37866 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeADIs3IVxbB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jan 2018 09:48:29 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 98A2768C8A; Thu,  4 Jan 2018 09:48:28 +0100 (CET)
Date:   Thu, 4 Jan 2018 09:48:28 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Christoph Hellwig <hch@lst.de>,
        iommu@lists.linux-foundation.org,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-ia64@vger.kernel.org,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-c6x-dev@linux-c6x.org,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        patches@groups.riscv.org,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Cris <linux-cris-kernel@axis.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        alpha <linux-alpha@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 16/67] powerpc: rename dma_direct_ to dma_nommu_
Message-ID: <20180104084828.GA3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-17-hch@lst.de> <878tdgtwzp.fsf@concordia.ellerman.id.au> <CAMuHMdWWus2kNSOzS94k-3678826W1YjKwCWTquu3hBLZ80cvw@mail.gmail.com> <87h8s3cvel.fsf@concordia.ellerman.id.au> <CAMuHMdWYDz_jHNxQ-B8944520R-myzHkjkL1rKWUjA38inU7cw@mail.gmail.com> <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgV+DnZAAtiE5oe8rxp4=_JHJrtSQc8F5jrgN0rgYKfwjA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Wed, Jan 03, 2018 at 07:19:46PM +1100, Julian Calaby wrote:
> If this is indeed a linear mapping, can we just remove this and
> replace it with the new "generic" mapping being introduced by this
> patchset?

That is the long-term plan.  But as the powerpc one includes support
for non-coherent DMA it will have to wait for the next batch.
