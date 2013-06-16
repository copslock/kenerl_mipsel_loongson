Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Jun 2013 13:22:23 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:38007 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822678Ab3FPLWU156RV (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 16 Jun 2013 13:22:20 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5GBMFCZ028438;
        Sun, 16 Jun 2013 13:22:15 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5GBMCTJ028437;
        Sun, 16 Jun 2013 13:22:12 +0200
Date:   Sun, 16 Jun 2013 13:22:12 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     linux-mips@linux-mips.org, kvm@vger.kernel.org,
        Sanjay Lal <sanjayl@kymasys.com>, linux-kernel@vger.kernel.org,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH 21/31] mips/kvm: Allow set_except_vector() to be used
 from MIPSVZ code.
Message-ID: <20130616112211.GC20046@linux-mips.org>
References: <1370646215-6543-1-git-send-email-ddaney.cavm@gmail.com>
 <1370646215-6543-22-git-send-email-ddaney.cavm@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1370646215-6543-22-git-send-email-ddaney.cavm@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jun 07, 2013 at 04:03:25PM -0700, David Daney wrote:

> From: David Daney <david.daney@cavium.com>
> 
> We need to move it out of __init so we don't have section mismatch problems.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>
> ---
>  arch/mips/include/asm/uasm.h | 2 +-
>  arch/mips/kernel/traps.c     | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/include/asm/uasm.h b/arch/mips/include/asm/uasm.h
> index 370d967..90b4f5e 100644
> --- a/arch/mips/include/asm/uasm.h
> +++ b/arch/mips/include/asm/uasm.h
> @@ -11,7 +11,7 @@
>  
>  #include <linux/types.h>
>  
> -#ifdef CONFIG_EXPORT_UASM
> +#if defined(CONFIG_EXPORT_UASM) || IS_ENABLED(CONFIG_KVM_MIPSVZ)
>  #include <linux/export.h>
>  #define __uasminit
>  #define __uasminitdata

I'd rather keep KVM bits out of uasm.h.  A select EXPORT_UASM in Kconfig
would have been cleaner - but read below.

> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index f008795..fca0a2f 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1457,7 +1457,7 @@ unsigned long ebase;
>  unsigned long exception_handlers[32];
>  unsigned long vi_handlers[64];
>  
> -void __init *set_except_vector(int n, void *addr)
> +void __uasminit *set_except_vector(int n, void *addr)

A __uasminit tag is a bit unobvious because set_except_vector is not part of
uasm.  I could understand __cpuinit - but of course that doesn't sort your
problem.  Maybe we should just drop the __init tag alltogether?  Or if we
really want set_except_vector to become part of the uasm subsystem, then
probably it's declaration should move from setup.h to uasm.h.

  Ralf
