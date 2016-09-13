Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Sep 2016 14:54:43 +0200 (CEST)
Received: from Galois.linutronix.de ([146.0.238.70]:49204 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992186AbcIMMydlydTf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Sep 2016 14:54:33 +0200
Received: from localhost ([127.0.0.1])
        by Galois.linutronix.de with esmtps (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1bjnCT-0004Z1-RL; Tue, 13 Sep 2016 14:52:34 +0200
Date:   Tue, 13 Sep 2016 14:50:12 +0200 (CEST)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Baoyou Xie <baoyou.xie@linaro.org>
cc:     ralf@linux-mips.org, mingo@redhat.com, hpa@zytor.com,
        x86@kernel.org, arnd@arndb.de, akpm@linux-foundation.org,
        paul.burton@imgtec.com, chenhc@lemote.com, david.daney@cavium.com,
        kumba@gentoo.org, yamada.masahiro@socionext.com,
        kirill.shutemov@linux.intel.com, dave.hansen@linux.intel.com,
        toshi.kani@hpe.com, dan.j.williams@intel.com, luto@kernel.org,
        JBeulich@suse.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        xie.baoyou@zte.com.cn
Subject: Re: [PATCH v2] mm: move phys_mem_access_prot_allowed() declaration
 to pgtable.h
In-Reply-To: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
Message-ID: <alpine.DEB.2.20.1609131449460.6233@nanos>
References: <1473751597-12139-1-git-send-email-baoyou.xie@linaro.org>
User-Agent: Alpine 2.20 (DEB 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

On Tue, 13 Sep 2016, Baoyou Xie wrote:

> We get 1 warning when building kernel with W=1:
> drivers/char/mem.c:220:12: warning: no previous prototype for 'phys_mem_access_prot_allowed' [-Wmissing-prototypes]
>  int __weak phys_mem_access_prot_allowed(struct file *file,
> 
> In fact, its declaration is spreading to several header files
> in different architecture, but need to be declare in common
> header file.
> 
> So this patch moves phys_mem_access_prot_allowed() to pgtable.h.
> 
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>
> ---
>  arch/mips/include/asm/pgtable.h      | 2 --
>  arch/x86/include/asm/pgtable_types.h | 2 --
>  include/asm-generic/pgtable.h        | 3 +++
>  3 files changed, 3 insertions(+), 4 deletions(-)

Acked-by: Thomas Gleixner <tglx@linutronix.de>
