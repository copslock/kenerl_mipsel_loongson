Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 07:45:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60056 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010483AbbHRFpt5N2Pg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Aug 2015 07:45:49 +0200
Received: from localhost (c-67-161-9-76.hsd1.ca.comcast.net [67.161.9.76])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id AB4E2305;
        Tue, 18 Aug 2015 05:45:42 +0000 (UTC)
Date:   Mon, 17 Aug 2015 22:45:52 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-Id: <20150817224552.43d7267d.akpm@linux-foundation.org>
In-Reply-To: <20150818053825.GA20771@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
        <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
        <20150818053825.GA20771@lst.de>
X-Mailer: Sylpheed 2.7.1 (GTK+ 2.18.9; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48928
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Tue, 18 Aug 2015 07:38:25 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Mon, Aug 17, 2015 at 02:24:29PM -0700, Andrew Morton wrote:
> > 110254 bytes saved, shrinking the kernel by a whopping 0.17%. 
> > Thoughts?
> 
> Sounds fine to me.

OK, I'll clean it up a bit, check that each uninlining actually makes
sense and then I'll see how it goes.

> > 
> > I'll merge these 5 patches for 4.3.  That means I'll release them into
> > linux-next after 4.2 is released.
> 
> So you only add for-4.3 code to -next after 4.2 is odd?  Isn't thast the
> wrong way around?

Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is
supposed to contain only 4.2 material.  Once 4.2 is released,
linux-next is open for 4.3 material.
