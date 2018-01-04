Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Jan 2018 09:53:28 +0100 (CET)
Received: from verein.lst.de ([213.95.11.211]:37957 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990418AbeADIxQE34WB (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Jan 2018 09:53:16 +0100
Received: by newverein.lst.de (Postfix, from userid 2407)
        id C2D1968C8A; Thu,  4 Jan 2018 09:53:15 +0100 (CET)
Date:   Thu, 4 Jan 2018 09:53:15 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Christoph Hellwig <hch@lst.de>, iommu@lists.linux-foundation.org,
        alpha <linux-alpha@vger.kernel.org>,
        arcml <linux-snps-arc@lists.infradead.org>,
        linux-arm-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-c6x-dev@linux-c6x.org, Cris <linux-cris-kernel@axis.com>,
        "open list:QUALCOMM HEXAGON..." <linux-hexagon@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:METAG ARCHITECTURE" <linux-metag@vger.kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org, patches@groups.riscv.org,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        the arch/x86 maintainers <x86@kernel.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 02/67] alpha: mark jensen as broken
Message-ID: <20180104085315.GD3251@lst.de>
References: <20171229081911.2802-1-hch@lst.de> <20171229081911.2802-3-hch@lst.de> <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdUXSMuQ=RoZp86CODVk5Ubd3R+jtqOur_Uqnu+7h_m9AA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61898
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

On Tue, Jan 02, 2018 at 11:36:00AM +0100, Geert Uytterhoeven wrote:
> Hi Christoph,
> 
> On Fri, Dec 29, 2017 at 9:18 AM, Christoph Hellwig <hch@lst.de> wrote:
> > CONFIG_ALPHA_JENSEN has failed to compile since commit aca05038
> > ("alpha/dma: use common noop dma ops"), so mark it as broken.
> 
> unknown revision or path not in the working tree.
> Ah, you dropped the leading "6":
> 6aca0503847f6329460b15b3ab2b0e30bb752793
> is less than 2 years old, though.

I'll fix the reference.

But 23 month of a whole sub-architecture not compiling should still be
enough to mark it broken.
