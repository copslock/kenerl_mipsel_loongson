Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Nov 2013 17:42:11 +0100 (CET)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:43736 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822679Ab3KAQmFJFQoY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 Nov 2013 17:42:05 +0100
Received: by mail-wi0-f175.google.com with SMTP id hm4so1341965wib.2
        for <linux-mips@linux-mips.org>; Fri, 01 Nov 2013 09:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=rf6cBpE7gqo8hGFp/El04PDDUukgrk2IHpnNGsMlY6Y=;
        b=v+/RGjY57Rjc2DB1T1M+IZuvipXnFkGnLPCHzfPg4IUdzbsHpy6UtGb/C2UJlVIMgg
         +e3NlGLSG9jS1XbmopnVuHb/zzcTtCiaeS2bOoTMRvNz3geazi+06d7O6gGiiVGWC3zF
         ATStqRGcMQAO1LbF8XPCQN6dr8YG8uA5gEp2iTRDVThhvhfJe17Jq3Qfc5zrz92ewA9o
         68E9TiMqdXcAKQ8LYpgwPcGfCQDkCCQJND8uwXO/YVxgLveXeU3nto7Ncy9GRaaxJv8w
         4PFmJnRpgFdkJTB1E/8HeO1VyQFTWRGVhpDENxOCQlEWc6006l6uqLMDxKtlBwfcyQFv
         UeHw==
X-Received: by 10.195.13.45 with SMTP id ev13mr3064099wjd.20.1383324119788;
        Fri, 01 Nov 2013 09:41:59 -0700 (PDT)
Received: from [192.168.1.110] (093105185086.warszawa.vectranet.pl. [93.105.185.86])
        by mx.google.com with ESMTPSA id ey4sm9080889wic.11.2013.11.01.09.41.55
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 01 Nov 2013 09:41:59 -0700 (PDT)
Message-ID: <5273D9CD.2010800@gmail.com>
Date:   Fri, 01 Nov 2013 17:41:49 +0100
From:   Sylwester Nawrocki <sylvester.nawrocki@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:11.0) Gecko/20120412 Thunderbird/11.0.1
MIME-Version: 1.0
To:     Jonas Jensen <jonas.jensen@gmail.com>
CC:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Mike Turquette <mturquette@linaro.org>,
        linux-mips@linux-mips.org,
        Russell King - ARM Linux <linux@arm.linux.org.uk>,
        linux-sh@vger.kernel.org, jiada_wang@mentor.com,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kyungmin.park@samsung.com, laurent.pinchart@ideasonboard.com,
        uclinux-dist-devel@blackfin.uclinux.org
Subject: Re: [PATCH v7 0/5] clk: clock deregistration support
References: <1383076268-8984-1-git-send-email-s.nawrocki@samsung.com> <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
In-Reply-To: <CACmBeS2TiiTJ_n0bEzXGKN8B=U9EKXeVtrE2q0jgxsxf5TBivw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sylvester.nawrocki@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38441
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sylvester.nawrocki@gmail.com
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

Hi Jonas,

On 11/01/2013 02:56 PM, Jonas Jensen wrote:
> Hi,
>
> Just letting you know, the following warning from __clk_get is now
> printed, and not printed after revert (git revert
> 0b35b92fb3600a2f9ca114a6142db95f760d55f5).

It is recommended to quote also human readable patch summary line,
so it's more immediately clear which patch you refer to.

> Is the driver doing something it shouldn't be doing?

I don't think so. That is a known issue, it shouldn't be happening when
you apply $subject patch series onto todays -next. If it does please
let me know.

Is the warning still triggered when you apply this patch:
http://www.spinics.net/lists/arm-kernel/msg283550.html
onto next-20131031 instead of reverting ?

> moxart_of_pll_clk_init() source can be found here:
> http://www.spinics.net/lists/arm-kernel/msg278572.html

The driver seems OK from a brief look.  Thanks for the feedback.

> boot log:
> Uncompressing Linux... done, booting the kernel.
> [    0.000000] Booting Linux on physical CPU 0x0
> [    0.000000] Linux version 3.12.0-rc7-next-20131031+ (i@Ildjarn)

> [    0.000000] ------------[ cut here ]------------
> [    0.000000] WARNING: CPU: 0 PID: 0 at include/linux/kref.h:47
> __clk_get+0x54/0x68()
> [    0.000000] CPU: 0 PID: 0 Comm: swapper Not tainted
> 3.12.0-rc7-next-20131031+ #1043
> [    0.000000] [<c000d214>] (unwind_backtrace+0x0/0xf4) from
> [<c000b964>] (show_stack+0x18/0x1c)
> [    0.000000] [<c000b964>] (show_stack+0x18/0x1c) from [<c02715e0>]
> (dump_stack+0x20/0x28)
> [    0.000000] [<c02715e0>] (dump_stack+0x20/0x28) from [<c0013ab0>]
> (warn_slowpath_common+0x64/0x84)
> [    0.000000] [<c0013ab0>] (warn_slowpath_common+0x64/0x84) from
> [<c0013ba4>] (warn_slowpath_null+0x24/0x2c)
> [    0.000000] [<c0013ba4>] (warn_slowpath_null+0x24/0x2c) from
> [<c01e5c00>] (__clk_get+0x54/0x68)
> [    0.000000] [<c01e5c00>] (__clk_get+0x54/0x68) from [<c01e334c>]
> (of_clk_get+0x64/0x7c)
> [    0.000000] [<c01e334c>] (of_clk_get+0x64/0x7c) from [<c03508f0>]
> (moxart_of_pll_clk_init+0xd8/0x15c)
> [    0.000000] [<c03508f0>] (moxart_of_pll_clk_init+0xd8/0x15c) from
> [<c0350588>] (of_clk_init+0x48/0x70)
> [    0.000000] [<c0350588>] (of_clk_init+0x48/0x70) from [<c03425f0>]
> (moxart_init_time+0x14/0x1c)
> [    0.000000] [<c03425f0>] (moxart_init_time+0x14/0x1c) from
> [<c034005c>] (time_init+0x28/0x3c)
> [    0.000000] [<c034005c>] (time_init+0x28/0x3c) from [<c033e954>]
> (start_kernel+0x1d0/0x2dc)
> [    0.000000] [<c033e954>] (start_kernel+0x1d0/0x2dc) from
> [<00008040>] (0x8040)
> [    0.000000] ---[ end trace 3406ff24bd97382e ]---

Regards,
Sylwester
