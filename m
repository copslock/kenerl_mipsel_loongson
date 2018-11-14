Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Nov 2018 22:52:08 +0100 (CET)
Received: from foss.arm.com ([217.140.101.70]:40634 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992494AbeKNVv1I24zI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Nov 2018 22:51:27 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BBF4F1596;
        Wed, 14 Nov 2018 13:51:24 -0800 (PST)
Received: from brain-police (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A48543F5A0;
        Wed, 14 Nov 2018 13:51:23 -0800 (PST)
Date:   Wed, 14 Nov 2018 21:51:13 +0000
From:   Will Deacon <will.deacon@arm.com>
To:     Douglas Anderson <dianders@chromium.org>
Cc:     Jason Wessel <jason.wessel@windriver.com>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net,
        Peter Zijlstra <peterz@infradead.org>,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org,
        sparclinux@vger.kernel.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Hogan <jhogan@kernel.org>, linux-hexagon@vger.kernel.org,
        x86@kernel.org, Vineet Gupta <vgupta@synopsys.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michal Hocko <mhocko@suse.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-snps-arc@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Burton <paul.burton@mips.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Huang Ying <ying.huang@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Rich Felker <dalias@libc.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Paul Mackerras <paulus@samba.org>,
        Richard Kuo <rkuo@codeaurora.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v4 1/4] kgdb: Remove irq flags from roundup
Message-ID: <20181114215112.GA4044@brain-police>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-2-dianders@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181112182659.245726-2-dianders@chromium.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Return-Path: <will.deacon@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67295
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: will.deacon@arm.com
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

On Mon, Nov 12, 2018 at 10:26:55AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

I'm hopeful that you'll keep hacking on kgdb, because it definitely needs
some love in its current state.

Will
