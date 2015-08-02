Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 03:40:03 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:36590 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012007AbbHCBkA6gJEN (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 3 Aug 2015 03:40:00 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 2F994ABC6;
        Mon,  3 Aug 2015 01:39:57 +0000 (UTC)
Message-ID: <1438548631.2249.125.camel@stgolabs.net>
Subject: Re: [PATCH v2] arch: use WRITE_ONCE/READ_ONCE in
 smp_store_release/smp_load_acquire
From:   Davidlohr Bueso <dave@stgolabs.net>
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
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Duyck <alexander.h.duyck@redhat.com>,
        Andre Przywara <andre.przywara@arm.com>,
        "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
        Borislav Petkov <bp@suse.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-ia64@vger.kernel.org, linux-metag@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-arch@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <1438528264-714-1-git-send-email-andreyknvl@google.com>
References: <1438528264-714-1-git-send-email-andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Date:   Sun, 02 Aug 2015 13:50:31 -0700
Mime-Version: 1.0
X-Mailer: Evolution 3.12.11 
Content-Transfer-Encoding: 7bit
Return-Path: <dave@stgolabs.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48535
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dave@stgolabs.net
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

On Sun, 2015-08-02 at 17:11 +0200, Andrey Konovalov wrote:
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

Acked-by: Davidlohr Bueso <dbueso@suse.de>
