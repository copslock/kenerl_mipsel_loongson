Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Sep 2016 16:23:14 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:45252 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990522AbcIKOXHvNI8D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Sep 2016 16:23:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=LDRSTQHgMOvl4OON2oObbStzQojse/NohxTrxrAI9cE=; b=0wsb9fbmq2H2v/M0yDobKMI3S5
        6PQTgjl10pLqjaEWgiFPMxr8bWym3O6heE/VoqwfiwTxzUbdKPw+m4FBA9CMZBlq4CeStR2upClJ2
        440s3hRy8FPtsA5gJ+xBDErtwk5mj5tetZNAvpUYWkDUoUIohST5lccsv48aZNAKt1Yz84nXpqetE
        k6/ixaKvskq55JVdvrAO5ShSBi/f45OkBmozes3Hd/+r2qZZXgMOTpDNzhNCegMklmBVkI55clC0v
        Sbg5ezskZ6zPfEJJLbYXZb6BGmarKA1kwyLkbQACP5Cq/ONHQPsHFL2QyzVKnXXGoRD7Dx3XCvc4d
        cZchEwqg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:40704 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bj5er-002AN1-Gt; Sun, 11 Sep 2016 14:22:57 +0000
Subject: Re: [PATCH v2 0/2] MIPS: TXx9: Common Clock Framework Conversion
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <c00b671b-8824-b054-5ee1-fbd02e993e1e@roeck-us.net>
Date:   Sun, 11 Sep 2016 07:22:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1473584398-12942-1-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55096
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 09/11/2016 01:59 AM, Geert Uytterhoeven wrote:
> 	Hi Ralf, Nemoto-san, Wim,
>
> This patch series converts the Toshiba TXx9 platforms from their own
> custom minimal clock implementation to the Common Clock Framework.
>
>   - Patch 1 adds missing clock (un)prepare calls to the TXx9 watchdog
>     driver,
>   - Patch 2 replaces the custom clock implementation by a CCF-based one,
>     providing a minimal set of clocks.
>
> This has been tested with the watchdog on RBTX4927.
>
> Changes since v1:
>   - Dropped "spi: spi-txx9: Add missing clock (un)prepare calls for
>     CCF", which has been accepted in spi/for-next,
>   - Protect the TX4938_REV_PCODE() check by #ifdef CONFIG_CPU_TX49XX,
>   - Use new clk_hw-centric clock registration API,
>   - Add Reviewed-by.
>
> Dependencies:
>   - Patch 1 can be applied independently,
>   - Patch 2 depends on patch 1 and on "spi: spi-txx9: Add missing clock
>     (un)prepare calls for CCF" in spi/for-next,
>   - The error path in patch 2 depends on "clkdev: Detect errors in
>     clk_hw_register_clkdev() for mass registration", but this is less
>     critical.
>
> Wim: Can you please appply patch 1 directly, so we can get at least the
> hard dependencies in v4.9?
>

It is in my watchdog-next branch, and it has my Reviewed-by:, which
normally means that Wim will apply it.

Thanks,
Guenter
