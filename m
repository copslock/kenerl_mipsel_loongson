Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:47:52 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:48189 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903688Ab2BQQrr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Feb 2012 17:47:47 +0100
Message-ID: <4F3E84AA.9080204@openwrt.org>
Date:   Fri, 17 Feb 2012 17:47:38 +0100
From:   John Crispin <blogic@openwrt.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.20) Gecko/20110820 Icedove/3.1.12
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 9/9] WDT: MIPS: lantiq: convert watchdog driver to clkdev
 api
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-10-git-send-email-blogic@openwrt.org> <4F3E9129.9040704@mvista.com>
In-Reply-To: <4F3E9129.9040704@mvista.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 32461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


Hi Sergei,
> ( The comment doesn't match the essence of patch. )

> Again, you're doing something different.
>

sorry

>    Why not clk_get(&pdev->dev, NULL)?
>
> WBR, Sergei
>
>

clk_get_sys uses the clkdev lookup table, which is added by this series.
it makes the clock code consistent throughout the lantiq related files.
we use clk connections other places, which we cannot reference with
clk_get that easily

John
