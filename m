Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Aug 2015 16:35:30 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:38546 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011935AbbHMOf2vcyYv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 13 Aug 2015 16:35:28 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 69172691EB; Thu, 13 Aug 2015 16:35:28 +0200 (CEST)
Date:   Thu, 13 Aug 2015 16:35:28 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Julian Calaby <julian.calaby@gmail.com>
Cc:     Boaz Harrosh <boaz@plexistor.com>, Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        axboe@kernel.dk, linux-mips@linux-mips.org,
        linux-ia64@vger.kernel.org, linux-nvdimm@ml01.01.org,
        David Howells <dhowells@redhat.com>,
        sparclinux <sparclinux@vger.kernel.org>,
        Hans-Christian Egtvedt <egtvedt@samfundet.no>,
        linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        x86@kernel.org, David Woodhouse <dwmw2@infradead.org>,
        =?iso-8859-1?Q?H=E5vard?= Skinnemoen <hskinnemoen@gmail.com>,
        linux-xtensa@linux-xtensa.org, grundler@parisc-linux.org,
        realmz6@gmail.com, alex.williamson@redhat.com,
        linux-metag@vger.kernel.org, Michal Simek <monstr@monstr.eu>,
        linux-parisc@vger.kernel.org, vgupta@synopsys.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-alpha@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: RFC: prepare for struct scatterlist entries without page
        backing
Message-ID: <20150813143528.GC17183@lst.de>
References: <1439363150-8661-1-git-send-email-hch@lst.de> <55CB3F47.3000902@plexistor.com> <CAGRGNgUKkaPnyvn30DXyNpdiXQzS6J=1+mQ3ick8C8=bhx_RHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGRGNgUKkaPnyvn30DXyNpdiXQzS6J=1+mQ3ick8C8=bhx_RHA@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48862
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

On Thu, Aug 13, 2015 at 09:37:37AM +1000, Julian Calaby wrote:
> I.e. ~90% of this patch set seems to be just mechanically dropping
> BUG_ON()s and converting open coded stuff to use accessor functions
> (which should be macros or get inlined, right?) - and the remaining
> bit is not flushing if we don't have a physical page somewhere.

Which is was 90%.  By lines changed most actually is the diffs for
the cache flushing.

> Would it make sense to split this patch set into a few bits: one to
> drop all the useless BUG_ON()s, one to convert all the open coded
> stuff to accessor functions, then another to do the actual page-less
> sg stuff?

Without the ifs the BUG_ON() actually are useful to assert we
never feed the sort of physical addresses we can't otherwise support,
so I don't think that part is doable.

A simple series to make more use of sg_phys and add sg_pfn might
still be useful, though.
