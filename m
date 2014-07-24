Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2014 00:37:04 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49843 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6862591AbaGXWVmwBQxp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2014 00:21:42 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.95])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id C62A2988;
        Thu, 24 Jul 2014 22:21:34 +0000 (UTC)
Date:   Thu, 24 Jul 2014 15:21:33 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Max Filippov <jcmvbkbc@gmail.com>
Cc:     "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        "Linux/MIPS Mailing List" <linux-mips@linux-mips.org>,
        "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Chris Zankel <chris@zankel.net>,
        Marc Gauthier <marc@cadence.com>
Subject: Re: [PATCH v2] mm/highmem: make kmap cache coloring aware
Message-Id: <20140724152133.bd4556f632b9cbb506b168cf@linux-foundation.org>
In-Reply-To: <CAMo8BfJ0zC16ssBDGUxsLNwmVOpgnyk1PjikunB9u-C7x9uaOA@mail.gmail.com>
References: <1405616598-14798-1-git-send-email-jcmvbkbc@gmail.com>
        <20140723141721.d6a58555f124a7024d010067@linux-foundation.org>
        <CAMo8BfJ0zC16ssBDGUxsLNwmVOpgnyk1PjikunB9u-C7x9uaOA@mail.gmail.com>
X-Mailer: Sylpheed 3.2.0beta5 (GTK+ 2.24.10; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41581
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

On Thu, 24 Jul 2014 04:38:01 +0400 Max Filippov <jcmvbkbc@gmail.com> wrote:

> On Thu, Jul 24, 2014 at 1:17 AM, Andrew Morton
> <akpm@linux-foundation.org> wrote:
> > Fifthly, it would be very useful to publish the performance testing
> > results for at least one architecture so that we can determine the
> > patchset's desirability.  And perhaps to motivate other architectures
> > to implement this.
> 
> What sort of performance numbers would be relevant?
> For xtensa this patch enables highmem use for cores with aliasing cache,
> that is access to a gigabyte of memory (typical on KC705 FPGA board) vs.
> only 128MBytes of low memory, which is highly desirable. But performance
> comparison of these two configurations seems to make little sense.
> OTOH performance comparison of highmem variants with and without
> cache aliasing would show the quality of our cache flushing code.

I'd assumed the patch was making cache coloring available as a
performance tweak.  But you appear to be saying that the (high) memory
is simply unavailable for such cores without this change.  I think.

Please ensure that v3's changelog explains the full reason for the
patch.  Assume you're talking to all-the-worlds-an-x86 dummies, OK?
