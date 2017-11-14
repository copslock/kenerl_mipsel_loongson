Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 16:40:09 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55406 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S23992780AbdKNPkAjq7a0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 14 Nov 2017 16:40:00 +0100
Received: from h7.dl5rb.org.uk (localhost [127.0.0.1])
        by h7.dl5rb.org.uk (8.15.2/8.14.8) with ESMTP id vAEFdwMv018065;
        Tue, 14 Nov 2017 16:39:59 +0100
Received: (from ralf@localhost)
        by h7.dl5rb.org.uk (8.15.2/8.15.2/Submit) id vAEFdwV7018060;
        Tue, 14 Nov 2017 16:39:58 +0100
Date:   Tue, 14 Nov 2017 16:39:58 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     "Steven J. Hill" <steven.hill@cavium.com>
Cc:     linux-mips@linux-mips.org, Chad Reese <kreese@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>
Subject: Re: [PATCH v3 01/11] MIPS: Add nudges to writes for bit unlocks.
Message-ID: <20171114153958.GA16044@linux-mips.org>
References: <1510633827-23548-1-git-send-email-steven.hill@cavium.com>
 <1510633827-23548-2-git-send-email-steven.hill@cavium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1510633827-23548-2-git-send-email-steven.hill@cavium.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60922
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

On Mon, Nov 13, 2017 at 10:30:17PM -0600, Steven J. Hill wrote:

> From: Chad Reese <kreese@caviumnetworks.com>
> 
> Flushing the writes lets other CPUs waiting for the lock to get it
> sooner.
> 
> Signed-off-by: Chad Reese <kreese@caviumnetworks.com>
> Signed-off-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Steven J. Hill <steven.hill@cavium.com>
> ---
>  arch/mips/include/asm/bitops.h | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/mips/include/asm/bitops.h b/arch/mips/include/asm/bitops.h
> index fa57cef..da1b871 100644
> --- a/arch/mips/include/asm/bitops.h
> +++ b/arch/mips/include/asm/bitops.h
> @@ -456,6 +456,7 @@ static inline void __clear_bit_unlock(unsigned long nr, volatile unsigned long *
>  {
>  	smp_mb__before_llsc();
>  	__clear_bit(nr, addr);
> +	nudge_writes();
>  }

Hmm...

This patch looks ok, it's more the definition of nudge_writes() which I'm
concerned about.  __clear_bit_unlock() does not need a memory barrier
after __clear_bit() but for non-Octeon processors nudge_writes() expands
into one anyway.

The good news is nudge_writes() is currently unused anyway so we can
change the definition to something like nudge_writes do { } while (0)
for the Octeon.  Suggested patch below.

The Octeon definition of nudge_writes() has a memory clobber and I'm
wondering if that one is actually required or if we could make things a
little easier on the compiler by removing it.

  Ralf

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

 arch/mips/include/asm/barrier.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/barrier.h b/arch/mips/include/asm/barrier.h
index a5eb1bb199a7..0e8e6afbf80a 100644
--- a/arch/mips/include/asm/barrier.h
+++ b/arch/mips/include/asm/barrier.h
@@ -216,7 +216,7 @@
 #else
 #define smp_mb__before_llsc() smp_llsc_mb()
 #define __smp_mb__before_llsc() smp_llsc_mb()
-#define nudge_writes() mb()
+#define nudge_writes() do { } while (0)
 #endif
 
 #define __smp_mb__before_atomic()	__smp_mb__before_llsc()
