Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 May 2013 19:05:14 +0200 (CEST)
Received: from mail-pa0-f50.google.com ([209.85.220.50]:60611 "EHLO
        mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835067Ab3EWRFJtauGJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 May 2013 19:05:09 +0200
Received: by mail-pa0-f50.google.com with SMTP id fb11so1824200pad.23
        for <multiple recipients>; Thu, 23 May 2013 10:05:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=HGoZHkErC6WiTA5GWcHVOx3Y0/+puCLEa74J2vShXVA=;
        b=TsVL59GpleyY8NGJevAdecxpoED4fvjKfqPhi0ZpghGAHhL5g2IhLg0Ka4ZGl6xJXU
         h1hwaGt9tgrOqq4KEdJ0ut4CeLWiLy3G3B4Tph+TDpwyMdJLMlzKJp88nPJ+R1jW7fyT
         rPSnPENJzMR05u0N4778kJ1uqyDS/IXvw8tiqQ7OO/4a/NZ+qwDWRlggwNjL6YV4SDwl
         WNwqL19Nh48N32Z7rXvzjyANk40SLubCbXh1cBZM9Xms8w6kR83gJBLSK0ZbBkQy2qqq
         sV86CDQa3k2DweZWUKlSRxdaezfi6fkokjPJHBdNEDKvBbOwmecZjWp6w9Ab0r70jZp5
         SHaA==
X-Received: by 10.68.254.225 with SMTP id al1mr14157420pbd.69.1369328703248;
        Thu, 23 May 2013 10:05:03 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id if5sm12407698pbb.31.2013.05.23.10.05.01
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 23 May 2013 10:05:01 -0700 (PDT)
Message-ID: <519E4C3C.7010400@gmail.com>
Date:   Thu, 23 May 2013 10:05:00 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130311 Thunderbird/17.0.4
MIME-Version: 1.0
To:     Wladislav Wiebe <wladislav.kw@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, david.daney@cavium.com,
        Maxim Uvarov <muvarov@gmail.com>, davem@davemloft.net,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] MIPS: Octeon: fix for held reboot_mutex lock at
 task exit time
References: <519DDF8D.70700@gmail.com>
In-Reply-To: <519DDF8D.70700@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/23/2013 02:21 AM, Wladislav Wiebe wrote:
> When kernel halt's will reboot_mutex lock still hold at exit.
> It will issue with 'halt' command:
> $ halt
> ..
> Sent SIGKILL to all processes
> Requesting system halt
> [66.729373] System halted.
> [66.733244]
> [66.734761] =====================================
> [66.739473] [ BUG: lock held at task exit time! ]
> [66.744188] 3.8.7-0-sampleversion-fct #49 Tainted: G           O
> [66.750202] -------------------------------------
> [66.754913] init/21479 is exiting with locks still held!
> [66.760234] 1 lock held by init/21479:
> [66.763990]  #0:  (reboot_mutex){+.+...}, at: [<ffffffff801776c8>] SyS_reboot+0xe0/0x218
> [66.772165]
> [66.772165] stack backtrace:
> [66.776532] Call Trace:
> [66.778992] [<ffffffff805780a8>] dump_stack+0x8/0x34
> [66.783972] [<ffffffff801618b0>] do_exit+0x610/0xa70
> [66.788948] [<ffffffff801777a8>] SyS_reboot+0x1c0/0x218
> [66.794186] [<ffffffff8013d6a4>] handle_sys64+0x44/0x64
>
>
[...]
>
> Acked-by: Maxim Uvarov <muvarov@gmail.com>
> Signed-off-by: Wladislav Wiebe <wladislav.kw@gmail.com>
> ---
>   arch/mips/cavium-octeon/setup.c |    4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index b0baa29..04ce396 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -457,6 +457,10 @@ static void octeon_halt(void)
>   	}
>
>   	octeon_kill_core(NULL);
> +
> +	/* We stop here */
> +	while (1)
> +		;

I want to put a WAIT here so we don't burn so much power.

I will send a patch to do that instead.

>   }
>
>   /**
>
