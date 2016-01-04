Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 16:30:44 +0100 (CET)
Received: from casper.infradead.org ([85.118.1.10]:52462 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27008336AbcADPanNZaBV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 16:30:43 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by casper.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aG75o-00055v-LD; Mon, 04 Jan 2016 15:30:44 +0000
Received: by twins (Postfix, from userid 1000)
        id EFA3F1257A0D8; Mon,  4 Jan 2016 16:30:36 +0100 (CET)
Date:   Mon, 4 Jan 2016 16:30:36 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Davidlohr Bueso <dbueso@suse.de>,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH v2 20/32] metag: define __smp_xxx
Message-ID: <20160104153036.GG6344@twins.programming.kicks-ass.net>
References: <1451572003-2440-1-git-send-email-mst@redhat.com>
 <1451572003-2440-21-git-send-email-mst@redhat.com>
 <20160104134128.GZ6344@twins.programming.kicks-ass.net>
 <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160104152558.GD17861@jhogan-linux.le.imgtec.org>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50857
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peterz@infradead.org
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

On Mon, Jan 04, 2016 at 03:25:58PM +0000, James Hogan wrote:
> It is used along with the metag specific __global_lock1() (global
> voluntary lock between hw threads) whenever a write is performed, and by
> smp_mb/smp_rmb to try to catch other cases, but I've never been
> confident this fixes every single corner case, since there could be
> other places where multiple CPUs perform unsynchronised writes to the
> same memory location, and expect cache not to become incoherent at that
> location.

Ah, yuck, I thought blackfin was the only one attempting !coherent SMP.
And yes, this is bound to break in lots of places in subtle ways. We
very much assume cache coherency for SMP in generic code.

> It seemed to be sufficient to achieve stability however, and SMP on Meta
> Linux never made it into a product anyway, since the other hw thread
> tended to be used for RTOS stuff, so it didn't seem worth extending the
> generic barrier API for it.

*phew*, should we take it out then, just to be sure nobody accidentally
tries to use it then?
