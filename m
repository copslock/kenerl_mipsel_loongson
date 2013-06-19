Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Jun 2013 19:32:16 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:51698 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6835004Ab3FSRcOgDwWP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Jun 2013 19:32:14 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.5/8.14.4) with ESMTP id r5JHW9rD000954;
        Wed, 19 Jun 2013 19:32:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.5/8.14.5/Submit) id r5JHW8ia000953;
        Wed, 19 Jun 2013 19:32:08 +0200
Date:   Wed, 19 Jun 2013 19:32:07 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org, sibyte-users@bitmover.com
Subject: Re: [PATCH 1/7] MIPS: sibyte: Fix build for SIBYTE_BW_TRACE
Message-ID: <20130619173207.GA741@linux-mips.org>
References: <1371477641-7989-1-git-send-email-markos.chandras@imgtec.com>
 <1371477641-7989-2-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1371477641-7989-2-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37013
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

On Mon, Jun 17, 2013 at 03:00:35PM +0100, Markos Chandras wrote:

> The M_BCM1480_SCD_TRACE_CFG_FREEZE macro removed in
> 8deab1144b553548fb2f1b51affdd36dcd652aaa
> "[MIPS] Updated Sibyte headers"
> 
> This broke the build for the sibyte platfrom when
> SIBYTE_BW_TRACE is enabled:
> arch/mips/mm/cerr-sb1.c:186:2: error: 'M_BCM1480_SCD_TRACE_CFG_FREEZE'
> undeclared (first use in this function)
> 
> We fix this by replacing it with the M_BCM1480_SYS_RESERVED4 macro
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>
> Cc: sibyte-users@bitmover.com
> ---
>  arch/mips/mm/cerr-sb1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
> index 576add3..1a24534 100644
> --- a/arch/mips/mm/cerr-sb1.c
> +++ b/arch/mips/mm/cerr-sb1.c
> @@ -183,7 +183,7 @@ asmlinkage void sb1_cache_error(void)
>  #ifdef CONFIG_SIBYTE_BW_TRACE
>  	/* Freeze the trace buffer now */
>  #if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
> -	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
> +	csr_out32(M_BCM1480_SYS_RESERVED4, IOADDR(A_SCD_TRACE_CFG));
>  #else
>  	csr_out32(M_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
>  #endif

I think this is the correct solution.

Unfortunately nobody at Broadcom seems to care about the Sibyte SOCs
these days though they're still very important for a bunch of Linux
distributions.

  Ralf

  CC      arch/mips/mm/cerr-sb1.o
arch/mips/mm/cerr-sb1.c: In function ‘sb1_cache_error’:
arch/mips/mm/cerr-sb1.c:186:98: error: ‘M_BCM1480_SCD_TRACE_CFG_FREEZE’ undeclared (first use in this function)
arch/mips/mm/cerr-sb1.c:186:98: note: each undeclared identifier is reported only once for each function it appears in
make[1]: *** [arch/mips/mm/cerr-sb1.o] Error 1

This happens because 8deab1144b553548fb2f1b51affdd36dcd652aaa [[MIPS]
Updated Sibyte headers] changed the headers but not all the users.

Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Reported-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/mm/cerr-sb1.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/mips/mm/cerr-sb1.c b/arch/mips/mm/cerr-sb1.c
index 576add3..ee5c1ff 100644
--- a/arch/mips/mm/cerr-sb1.c
+++ b/arch/mips/mm/cerr-sb1.c
@@ -182,11 +182,7 @@ asmlinkage void sb1_cache_error(void)
 
 #ifdef CONFIG_SIBYTE_BW_TRACE
 	/* Freeze the trace buffer now */
-#if defined(CONFIG_SIBYTE_BCM1x55) || defined(CONFIG_SIBYTE_BCM1x80)
-	csr_out32(M_BCM1480_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
-#else
 	csr_out32(M_SCD_TRACE_CFG_FREEZE, IOADDR(A_SCD_TRACE_CFG));
-#endif
 	printk("Trace buffer frozen\n");
 #endif
 
