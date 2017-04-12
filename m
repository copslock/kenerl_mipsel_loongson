Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Apr 2017 21:50:45 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:57554 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23993932AbdDLTuhoGyQg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 12 Apr 2017 21:50:37 +0200
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id v3CJoaRB031491;
        Wed, 12 Apr 2017 21:50:36 +0200
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id v3CJoaWl031490;
        Wed, 12 Apr 2017 21:50:36 +0200
Date:   Wed, 12 Apr 2017 21:50:36 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, trivial@kernel.org
Subject: Re: [PATCH] MIPS: Remove CONFIG_ARCH_HAS_ILOG2_U{32,64}
Message-ID: <20170412195036.GA31446@linux-mips.org>
References: <20170330205200.25635-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170330205200.25635-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.8.0 (2017-02-23)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57679
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

Thanks, applied.

  Ralf

On Thu, Mar 30, 2017 at 01:51:59PM -0700, Paul Burton wrote:
> Date:   Thu, 30 Mar 2017 13:51:59 -0700
> From: Paul Burton <paul.burton@imgtec.com>
> To: Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
> CC: Paul Burton <paul.burton@imgtec.com>, trivial@kernel.org
> Subject: [PATCH] MIPS: Remove CONFIG_ARCH_HAS_ILOG2_U{32,64}
> Content-Type: text/plain
> 
> We declare CONFIG_ARCH_HAS_ILOG2_U32 & CONFIG_ARCH_HAS_ILOG2_U64 in
> Kconfig, but they are always false since nothing ever selects them. The
> generic fls-based implementation is efficient for MIPS anyway. Remove
> the redundant Kconfig entries.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> Cc: trivial@kernel.org
> 
> ---
> 
>  arch/mips/Kconfig | 8 --------
>  1 file changed, 8 deletions(-)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index a008a9f03072..33bc84ffd6b2 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1040,14 +1040,6 @@ config RWSEM_GENERIC_SPINLOCK
>  config RWSEM_XCHGADD_ALGORITHM
>  	bool
>  
> -config ARCH_HAS_ILOG2_U32
> -	bool
> -	default n
> -
> -config ARCH_HAS_ILOG2_U64
> -	bool
> -	default n
> -
>  config GENERIC_HWEIGHT
>  	bool
>  	default y
> -- 
> 2.12.1
> 
