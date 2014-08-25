Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Aug 2014 18:30:19 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:53885 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27006747AbaHYQaPld7wX (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 25 Aug 2014 18:30:15 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id s7PGUE7P001410;
        Mon, 25 Aug 2014 18:30:14 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id s7PGUE2B001409;
        Mon, 25 Aug 2014 18:30:14 +0200
Date:   Mon, 25 Aug 2014 18:30:14 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Kconfig: Select SMP symbols for CMP
Message-ID: <20140825163014.GF25892@linux-mips.org>
References: <1406017774-2187-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1406017774-2187-1-git-send-email-markos.chandras@imgtec.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42229
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

On Tue, Jul 22, 2014 at 09:29:34AM +0100, Markos Chandras wrote:

> CMP is an SMP implementation, and as a result of which, it needs
> to select the SYS_SUPPORTS_SMP and SMP symbols. This fixes the
> following build problem when CMP is enabled but SMP is not.
> 
> In file included from arch/mips/kernel/smp-cmp.c:34:0:
> ./arch/mips/include/asm/smp.h:26:0: error: "raw_smp_processor_id" redefined
> [-Werror]
>  #define raw_smp_processor_id() (current_thread_info()->cpu)
> [...]
> In file included from arch/mips/kernel/smp-cmp.c:34:0:
> ./arch/mips/include/asm/smp.h:59:20: error: redefinition of
> 'smp_send_reschedule'
> [...]
> ./arch/mips/include/asm/smp.h: In function 'smp_send_reschedule':
> ./arch/mips/include/asm/smp.h:63:8: error: dereferencing pointer to incomplete
> type
> 
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
>  arch/mips/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index 4e238e6e661c..9e3b67c65a32 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -2026,7 +2026,9 @@ config MIPS_CMP
>  	bool "MIPS CMP framework support (DEPRECATED)"
>  	depends on SYS_SUPPORTS_MIPS_CMP
>  	select MIPS_GIC_IPI
> +	select SMP
>  	select SYNC_R4K
> +	select SYS_SUPPORTS_SMP

It's always a bit inelegant to select a SYMBOL and its prerequisite -
but anyway, applied.

  Ralf
