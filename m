Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Mar 2009 16:47:17 +0000 (GMT)
Received: from h155.mvista.com ([63.81.120.155]:8735 "EHLO imap.sh.mvista.com")
	by ftp.linux-mips.org with ESMTP id S21366146AbZCQQrK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 17 Mar 2009 16:47:10 +0000
Received: from [192.168.1.234] (unknown [10.150.0.9])
	by imap.sh.mvista.com (Postfix) with ESMTP
	id AB6893EC9; Tue, 17 Mar 2009 09:47:06 -0700 (PDT)
Message-ID: <49BFD438.3070805@ru.mvista.com>
Date:	Tue, 17 Mar 2009 19:47:52 +0300
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Shinya Kuribayashi <shinya.kuribayashi@necel.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: MIPS: Enable prefetch option for VR5500 processor
References: <49ACF2EF.3080903@necel.com> <49BF4410.8080006@necel.com>
In-Reply-To: <49BF4410.8080006@necel.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

Shinya Kuribayashi wrote:

> MIPS: Enable prefetch option for VR5500 processor

> Signed-off-by: Shinya Kuribayashi <shinya.kuribayashi@necel.com>
> ---
> Hi Ralf,

> I haven't finished fixing up for VR5500 processor support, sigh :-(
> I hope this is the last one, and don't miss anything essential.

>  Shinya

> diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
> index c43f4b2..b42b9d2 100644
> --- a/arch/mips/mm/c-r4k.c
> +++ b/arch/mips/mm/c-r4k.c
> @@ -781,6 +781,7 @@ static void __cpuinit probe_pcache(void)
>         c->dcache.waybit = 0;
> 
>         c->options |= MIPS_CPU_CACHE_CDEX_P;
> +        c->options |= MIPS_CPU_PREFETCH;

    Why not:

         c->options |= MIPS_CPU_CACHE_CDEX_P | MIPS_CPU_PREFETCH;

WBR, Sergei
