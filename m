Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 16:33:27 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:38521 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011935AbbHMOd0Q8Uwv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 16:33:26 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 01CA9691E9; Thu, 13 Aug 2015 16:33:26 +0200 (CEST)
Date:   Thu, 13 Aug 2015 16:33:25 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Dan Williams <dan.j.williams@intel.com>,
        Vineet Gupta <vgupta@synopsys.com>,
        =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        Miao Steven <realmz6@gmail.com>,
        David Howells <dhowells@redhat.com>,
        Michal Simek <monstr@monstr.eu>,
        the arch/x86 maintainers <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        grundler@parisc-linux.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        linux-metag@vger.kernel.org,
        linux-mips <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>
Subject: Re: [PATCH 31/31] dma-mapping-common: skip kmemleak checks for
        page-less SG entries
Message-ID: <20150813143325.GB17183@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <1439363150-8661-32-git-send-email-hch@lst.de> <CA+55aFxfZM81HNfo2ysfhGwrhx6GX-+F--+jLFmMVv+Z0id2rw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+55aFxfZM81HNfo2ysfhGwrhx6GX-+F--+jLFmMVv+Z0id2rw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48861
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

On Wed, Aug 12, 2015 at 09:05:15AM -0700, Linus Torvalds wrote:
> [ Again, I'm responding to one random patch - this pattern was in
> other patches too.  ]
> 
> A question: do we actually expect to mix page-less and pageful SG
> entries in the same SG list?
> 
> How does that happen?

Both for DAX and the video buffer case people could do direct I/O
spanning the boundary between such a VMA and a normal one unless
we add special code to prevent that.  Right now I don't think it's
all that useful, but then again it doesn't seem harmful either
and adding those checks might add up.
