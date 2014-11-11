Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 11:57:56 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:57570 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27013363AbaKKK5ycnV7V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 11 Nov 2014 11:57:54 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.8/8.14.8) with ESMTP id sABAvo75029224;
        Tue, 11 Nov 2014 11:57:50 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.8/8.14.8/Submit) id sABAvmPM029223;
        Tue, 11 Nov 2014 11:57:48 +0100
Date:   Tue, 11 Nov 2014 11:57:48 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        linux-mips@linux-mips.org, linux-pm@vger.kernel.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Hongliang Tao <taohl@lemote.com>
Subject: Re: [PATCH V2 12/12] MIPS: Loongson: Make CPUFreq usable for
 Loongson-3
Message-ID: <20141111105748.GK27259@linux-mips.org>
References: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1415081928-25899-1-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43989
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

On Tue, Nov 04, 2014 at 02:18:48PM +0800, Huacai Chen wrote:

> diff --git a/arch/mips/kernel/smp.c b/arch/mips/kernel/smp.c
> index c94c4e9..01d676a 100644
> --- a/arch/mips/kernel/smp.c
> +++ b/arch/mips/kernel/smp.c
> @@ -136,7 +136,8 @@ asmlinkage void start_secondary(void)
>  	calibrate_delay();
>  	preempt_disable();
>  	cpu = smp_processor_id();
> -	cpu_data[cpu].udelay_val = loops_per_jiffy;
> +	if (!cpu_data[cpu].udelay_val)
> +		cpu_data[cpu].udelay_val = loops_per_jiffy;

Why this?  Is the idea that the value of loops_per_jiffy which was set
on bootup may no longer match the actual clock frequency?

  Ralf
