Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Aug 2015 18:08:52 +0200 (CEST)
Received: from bombadil.infradead.org ([198.137.202.9]:60160 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011129AbbHBQIuXw9IR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Aug 2015 18:08:50 +0200
Received: from 178-85-85-44.dynamic.upc.nl ([178.85.85.44] helo=twins)
        by bombadil.infradead.org with esmtpsa (Exim 4.80.1 #2 (Red Hat Linux))
        id 1ZLvo7-0000gm-0n; Sun, 02 Aug 2015 16:08:15 +0000
Received: by twins (Postfix, from userid 1000)
        id 8A1AC1257A0D8; Sun,  2 Aug 2015 18:08:09 +0200 (CEST)
Date:   Sun, 2 Aug 2015 18:08:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Andrey Konovalov <andreyknvl@google.com>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, "David S. Miller" <davem@davemloft.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
Message-ID: <20150802160809.GF25159@twins.programming.kicks-ass.net>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
User-Agent: Mutt/1.5.21 (2012-12-30)
Return-Path: <peterz@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48533
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

On Sun, Aug 02, 2015 at 05:11:04PM +0200, Andrey Konovalov wrote:
> Replace ACCESS_ONCE() macro in smp_store_release() and smp_load_acquire()
> with WRITE_ONCE() and READ_ONCE() on x86, arm, arm64, ia64, metag, mips,
> powerpc, s390, sparc and asm-generic since ACCESS_ONCE does not work
> reliably on non-scalar types.
> 
> WRITE_ONCE() and READ_ONCE() were introduced in the commits 230fa253df63
> ("kernel: Provide READ_ONCE and ASSIGN_ONCE") and 43239cbe79fc ("kernel:
> Change ASSIGN_ONCE(val, x) to WRITE_ONCE(x, val)").
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>

Thanks!
