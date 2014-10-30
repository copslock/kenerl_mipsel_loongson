Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 10:01:32 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.17.13]:62891 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011905AbaJ3JBZnBk0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 10:01:25 +0100
Received: from wuerfel.localnet (HSI-KBW-134-3-133-35.hsi14.kabel-badenwuerttemberg.de [134.3.133.35])
        by mrelayeu.kundenserver.de (node=mreue102) with ESMTP (Nemesis)
        id 0LbrjI-1YSgjq1Y0a-00jGuZ; Thu, 30 Oct 2014 10:00:54 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     f.fainelli@gmail.com, tglx@linutronix.de, jason@lakedaemon.net,
        ralf@linux-mips.org, lethal@linux-sh.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 02/15] sh: Eliminate unused irq_reg_{readl,writel} accessors
Date:   Thu, 30 Oct 2014 10:00:53 +0100
Message-ID: <2294092.AHz8W66sEP@wuerfel>
User-Agent: KMail/4.11.5 (Linux/3.16.0-10-generic; KDE/4.11.5; x86_64; ; )
In-Reply-To: <1414635488-14137-3-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com> <1414635488-14137-3-git-send-email-cernekee@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V02:K0:e3TtAz2L9mLbIRap6VmEIxNB0pAGCkL7rgiCN6la9qN
 LEU493gLcJoel3khvC/egfUOs22deG2U92iY1ImEg9bkw1o8Os
 TNPrEpbgbm2iE7zo8dwncRdtUaySMO/p9NeE/XNbF1SxtmDXtS
 nShMuaOpkNSWu/sCGVurcGhVfkbwGfLXodw1DMXDqKslG/17FN
 DdB6uPfgLX4XdEYsHzib2JRlkYG9F/Yi2fhuKxKYHv5odaYnAb
 kWTaLnQjxW0a2ogZPBDORlnJ3ctkpFRVM9mU3chfuCa9JGl+94
 cZSRsgTTyXQU/2fEm7fDtAxnb5dcFaEYtJHFAfFDT/0Z2HAtCi
 U0CZJrYIuBqYOECqgj30=
X-UI-Out-Filterresults: notjunk:1;
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wednesday 29 October 2014 19:17:55 Kevin Cernekee wrote:
> Defining these macros way down in arch/sh/.../irq.c doesn't cause
> kernel/irq/generic-chip.c to use them.  As far as I can tell this code
> has no effect.
> 
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Actually it overrides the 32-bit accessors with 16-bit accessors,
which does seem intentional and certainly has an effect.

	Arnd

>  arch/sh/boards/mach-se/7343/irq.c | 3 ---
>  arch/sh/boards/mach-se/7722/irq.c | 3 ---
>  2 files changed, 6 deletions(-)
> 
> diff --git a/arch/sh/boards/mach-se/7343/irq.c b/arch/sh/boards/mach-se/7343/irq.c
> index 7646bf0..1087dba 100644
> --- a/arch/sh/boards/mach-se/7343/irq.c
> +++ b/arch/sh/boards/mach-se/7343/irq.c
> @@ -14,9 +14,6 @@
>  #define DRV_NAME "SE7343-FPGA"
>  #define pr_fmt(fmt) DRV_NAME ": " fmt
>  
> -#define irq_reg_readl  ioread16
> -#define irq_reg_writel iowrite16
> -
>  #include <linux/init.h>
>  #include <linux/irq.h>
>  #include <linux/interrupt.h>
