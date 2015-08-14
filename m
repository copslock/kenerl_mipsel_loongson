Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 05:59:33 +0200 (CEST)
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:34674 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbbHND7asV70i (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 05:59:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2BDFD8EE0D8;
        Thu, 13 Aug 2015 20:59:23 -0700 (PDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
        by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id zubW3f-MZEPL; Thu, 13 Aug 2015 20:59:22 -0700 (PDT)
Received: from [153.66.254.242] (unknown [184.11.141.41])
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id B8E298EE0CF;
        Thu, 13 Aug 2015 20:59:21 -0700 (PDT)
Message-ID: <1439524760.8421.23.camel@HansenPartnership.com>
Subject: Re: [PATCH 29/31] parisc: handle page-less SG entries
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mips <linux-mips@linux-mips.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@ml01.01.org>,
        David Howells <dhowells@redhat.com>,
        sparclinux@vger.kernel.org,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        David Woodhouse <dwmw2@infradead.org>,
        =?ISO-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        Miao Steven <realmz6@gmail.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        linux-metag@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Michal Simek <monstr@monstr.eu>,
        Parisc List <linux-parisc@vger.kernel.org>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        ppc-dev <linuxppc-dev@lists.ozlabs.org>
Date:   Thu, 13 Aug 2015 20:59:20 -0700
In-Reply-To: <CAA9_cmcNA__N_yVTKsEqLAKBuoL-hx73t6opdsmb7w-0qKXaWg@mail.gmail.com>
References: <1439363150-8661-1-git-send-email-hch@lst.de>
         <1439363150-8661-30-git-send-email-hch@lst.de>
         <CA+55aFxsH9Lde7wqZi555vqfH2uxeQqC9cjeca9L6Wr=XpyzXA@mail.gmail.com>
         <20150813143150.GA17183@lst.de>
         <CAA9_cmcNA__N_yVTKsEqLAKBuoL-hx73t6opdsmb7w-0qKXaWg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <James.Bottomley@HansenPartnership.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: James.Bottomley@HansenPartnership.com
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

On Thu, 2015-08-13 at 20:30 -0700, Dan Williams wrote:
> On Thu, Aug 13, 2015 at 7:31 AM, Christoph Hellwig <hch@lst.de> wrote:
> > On Wed, Aug 12, 2015 at 09:01:02AM -0700, Linus Torvalds wrote:
> >> I'm assuming that anybody who wants to use the page-less
> >> scatter-gather lists always does so on memory that isn't actually
> >> virtually mapped at all, or only does so on sane architectures that
> >> are cache coherent at a physical level, but I'd like that assumption
> >> *documented* somewhere.
> >
> > It's temporarily mapped by kmap-like helpers.  That code isn't in
> > this series. The most recent version of it is here:
> >
> > https://git.kernel.org/cgit/linux/kernel/git/djbw/nvdimm.git/commit/?h=pfn&id=de8237c99fdb4352be2193f3a7610e902b9bb2f0
> >
> > note that it's not doing the cache flushing it would have to do yet, but
> > it's also only enabled for x86 at the moment.
> 
> For virtually tagged caches I assume we would temporarily map with
> kmap_atomic_pfn_t(), similar to how drm_clflush_pages() implements
> powerpc support.  However with DAX we could end up with multiple
> virtual aliases for a page-less pfn.

At least on some PA architectures, you have to be very careful.
Improperly managed, multiple aliases will cause the system to crash
(actually a machine check in the cache chequerboard). For the most
temperamental systems, we need the cache line flushed and the alias
mapping ejected from the TLB cache before we access the same page at an
inequivalent alias.

James
