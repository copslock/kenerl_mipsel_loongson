Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Feb 2016 01:50:00 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38021 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27010189AbcBYAt7AtO4x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Feb 2016 01:49:59 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 6C96D62C74C85;
        Thu, 25 Feb 2016 00:49:49 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 25 Feb 2016
 00:49:52 +0000
Date:   Thu, 25 Feb 2016 00:49:52 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Huacai Chen <chenhc@lemote.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        <linux-mips@linux-mips.org>, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH V3 5/5] MIPS: Loongson-3: Introduce
 CONFIG_LOONGSON3_ENHANCEMENT
In-Reply-To: <1456324384-18118-8-git-send-email-chenhc@lemote.com>
Message-ID: <alpine.DEB.2.00.1602250046480.15885@tp.orcam.me.uk>
References: <1456324384-18118-1-git-send-email-chenhc@lemote.com> <1456324384-18118-8-git-send-email-chenhc@lemote.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52225
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Wed, 24 Feb 2016, Huacai Chen wrote:

> This patch introduce a config option, CONFIG_LOONGSON3_ENHANCEMENT, to
> enable those enhancements which cannot be probed at run time. If you
> want a generic kernel to run on all Loongson 3 machines, please say 'N'
> here. If you want a high-performance kernel to run on new Loongson 3
> machines only, please say 'Y' here.
[...]
> diff --git a/arch/mips/include/asm/irqflags.h b/arch/mips/include/asm/irqflags.h
> index 65c351e..9d3610b 100644
> --- a/arch/mips/include/asm/irqflags.h
> +++ b/arch/mips/include/asm/irqflags.h
> @@ -41,7 +41,12 @@ static inline unsigned long arch_local_irq_save(void)
>  	"	.set	push						\n"
>  	"	.set	reorder						\n"
>  	"	.set	noat						\n"
> +#if defined(CONFIG_CPU_LOONGSON3)
> +	"	mfc0	%[flags], $12					\n"
> +	"	di							\n"
> +#else
>  	"	di	%[flags]					\n"
> +#endif
>  	"	andi	%[flags], 1					\n"
>  	"	" __stringify(__irq_disable_hazard) "			\n"
>  	"	.set	pop						\n"

 This part does not appear related to CONFIG_LOONGSON3_ENHANCEMENT -- 
please either fold it into one of the other changes in the set, if there's 
one it really belongs to, or make it an entirely separate change 
otherwise.

  Maciej
