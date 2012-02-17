Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Feb 2012 17:54:27 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:38289 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903690Ab2BQQyX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Feb 2012 17:54:23 +0100
Received: by bkcjk13 with SMTP id jk13so4358075bkc.36
        for <linux-mips@linux-mips.org>; Fri, 17 Feb 2012 08:54:18 -0800 (PST)
Received: by 10.204.13.82 with SMTP id b18mr4629721bka.88.1329497658428;
        Fri, 17 Feb 2012 08:54:18 -0800 (PST)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru. [213.79.90.226])
        by mx.google.com with ESMTPS id ez5sm23661825bkc.15.2012.02.17.08.54.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 17 Feb 2012 08:54:17 -0800 (PST)
Message-ID: <4F3E9423.2000502@mvista.com>
Date:   Fri, 17 Feb 2012 20:53:39 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:10.0.1) Gecko/20120208 Thunderbird/10.0.1
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-serial@vger.kernel.org
Subject: Re: [PATCH 7/9] SERIAL: MIPS: lantiq: convert serial driver to clkdev
 api
References: <1329474800-20979-1-git-send-email-blogic@openwrt.org> <1329474800-20979-8-git-send-email-blogic@openwrt.org> <4F3E90C4.8010904@mvista.com> <4F3E84B3.1030201@openwrt.org>
In-Reply-To: <4F3E84B3.1030201@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQk4KrOiXNKklPo2Xd6oNoyHJqZ7H5iAWfSYNRmlkTYlFc4kYodQc0GQjoon/ify8IoEi9hs
X-archive-position: 32464
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Hello.

On 02/17/2012 07:47 PM, John Crispin wrote:

>>     The comment doesn't match the essence of patch.

> sorry

>>     Why not just clk_get(&pdev->dev, NULL)?

>> WBR, Sergei

> clk_get_sys uses the clkdev lookup table, which is added by this series.

    clk_get() does the same, indirectly.

> it makes the clock code consistent throughout the lantiq related files.
> we use clk connections other places, which we cannot reference with
> clk_get that easily

    clkdev assumes you don't need to use connection ID if the clock is bound to 
be matched by device ID via the lookup table. clk_get() is a common case when 
using clkdev, that's why your use of clk_get_sys() stands out as something 
unusual. I'll have to have a look at your lookup tables...

> John

WBR, Sergei
