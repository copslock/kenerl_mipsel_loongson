Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:44:03 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:56190 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992911AbdKNPnzkJk30 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 16:43:55 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEFhsoi018189;
        Tue, 14 Nov 2017 16:43:54 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEFhs2Z018188;
        Tue, 14 Nov 2017 16:43:54 +0100
Date:   Tue, 14 Nov 2017 16:43:54 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, Chad Reese <kreese@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 01/11] MIPS: Add nudges to writes for bit unlocks.
Message-ID: <20171114154354.GC16044@linux-mips.org>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-2-git-send-email-steven.hill@cavium.com>
 <20171114153958.GA16044@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171114153958.GA16044@linux-mips.org>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60924
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

On Tue, Nov 14, 2017 at 04:39:58PM +0100, Ralf Baechle wrote:

> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
>  arch/mips/include/asm/barrier.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
> index a5eb1bb199a7..0e8e6afbf80a 100644
> --- a/arch/mips/include/asm/barrier.h
> +++ b/arch/mips/include/asm/barrier.h
> @@ -216,7 +216,7 @@
>  #else
>  #define smp_mb__before_llsc() smp_llsc_mb()
>  #define __smp_mb__before_llsc() smp_llsc_mb()
> -#define nudge_writes() mb()
> +#define nudge_writes() do { } while (0)
>  #endif
>  
>  #define __smp_mb__before_atomic()	__smp_mb__before_llsc()

And patchwork once again failed to recognice this as a new patch and
filed it as a reply to a previous patch.

Which is not so bad if it's my patch but it may easily cause others'
submissions to be missed.

  Ralf
