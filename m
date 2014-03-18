Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Mar 2014 16:52:26 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:32867 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6867611AbaCRPwY5FILU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Mar 2014 16:52:24 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s2IFqIsE027616;
        Tue, 18 Mar 2014 16:52:18 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s2IFqGws027615;
        Tue, 18 Mar 2014 16:52:16 +0100
Date:   Tue, 18 Mar 2014 16:52:16 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>
Subject: Re: [PATCH V19 11/13] MIPS: Loongson 3: Add Loongson-3 SMP support
Message-ID: <20140318155216.GF17197@linux-mips.org>
References: <1392537690-5961-1-git-send-email-chenhc@lemote.com>
 <1392537690-5961-12-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1392537690-5961-12-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39496
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

On Sun, Feb 16, 2014 at 04:01:28PM +0800, Huacai Chen wrote:

> diff --git a/arch/mips/loongson/common/init.c b/arch/mips/loongson/common/init.c
> index 81ba3b4..a7c521b 100644
> --- a/arch/mips/loongson/common/init.c
> +++ b/arch/mips/loongson/common/init.c
> @@ -33,6 +33,9 @@ void __init prom_init(void)
>  
>  	/*init the uart base address */
>  	prom_init_uart_base();
> +#if defined(CONFIG_SMP)
> +	register_smp_ops(&loongson3_smp_ops);
> +#endif

For the non-CONFIG_CPU case register_smp_ops() is defined as

static inline void register_smp_ops(struct plat_smp_ops *ops)
{
}

So this #ifdef should not be required and the reference to loongson3_smp_ops
be dropped.

  Ralf
