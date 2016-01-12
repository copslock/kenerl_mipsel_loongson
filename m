Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jan 2016 10:27:40 +0100 (CET)
Received: from bombadil.infradead.org ([198.137.202.9]:42095 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009116AbcALJ1ibD8MM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 12 Jan 2016 10:27:38 +0100
Received: from j217066.upc-j.chello.nl ([24.132.217.66] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1aIvEP-0001fy-Oa; Tue, 12 Jan 2016 09:27:14 +0000
Received: by twins (Postfix, from userid 1000)
        id 3ED6A1257A0D8; Tue, 12 Jan 2016 10:27:11 +0100 (CET)
Date:   Tue, 12 Jan 2016 10:27:11 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        Joe Perches <joe@perches.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ralf Baechle <ralf@linux-mips.org>,
        Ingo Molnar <mingo@kernel.org>, ddaney.cavm@gmail.com,
        will.deacon@arm.com, james.hogan@imgtec.com
Subject: Re: [v3,11/41] mips: reuse asm-generic/barrier.h
Message-ID: <20160112092711.GP6344@twins.programming.kicks-ass.net>
References: <1452426622-4471-12-git-send-email-mst@redhat.com>
 <56945366.2090504@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <56945366.2090504@imgtec.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51069
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

On Mon, Jan 11, 2016 at 05:14:14PM -0800, Leonid Yegoshin wrote:

> This statement doesn't fit MIPS barriers variations. Moreover, there is a
> reason to extend that even more specific, at least for smp_store_release and
> smp_load_acquire, look into
> 
>     http://patchwork.linux-mips.org/patch/10506/

Dude, that's one horrible patch.

1) you do not make such things selectable; either the hardware needs
them or it doesn't. If it does you _must_ use them, however unlikely.

2) the changelog _completely_ fails to explain the sync 0x11 and sync
0x12 semantics nor does it provide a publicly accessible link to
documentation that does.

3) it really should have explained what you did with
smp_llsc_mb/smp_mb__before_llsc() in _detail_.

And I agree that ideally it should be split into parts.

Seriously, this is _NOT_ OK.
