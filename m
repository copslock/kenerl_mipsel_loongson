Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Jun 2016 22:48:35 +0200 (CEST)
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34734 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041722AbcFJUsdOEGG2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Jun 2016 22:48:33 +0200
Received: by mail-pf0-f195.google.com with SMTP id 66so3863439pfy.1
        for <linux-mips@linux-mips.org>; Fri, 10 Jun 2016 13:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=2L81vM3FnCkUjdkaUkvpOqScwEqE/o+HgyLMCzUijkA=;
        b=k7m5YXdJxdN9c4+BnB2YkVi7ZgQ5RMIZ2J7lZH8tSgB5ZQiB67bXSsfJeeE9C5wd8l
         yEOY8plJEWXmCUNLv6/LMcHH1tyG+Ryyw//T1UAZXq9xoUwdTmnE6uhfSqDH0WFyO/hZ
         VsjtX0pt/z3a00reQl5d55e0qnAgHMYVySiZfawOFW5jW/CBJ/0C9Si4u8Oz47lJiyGN
         3QCBDksn4AY3HYvcofekYuI2C/h0C9LAPixIpmLyNKyaAt0br5viFhDHKvCRJq4buEfq
         lSwLXRaTtMpqqsN/1ZJ/tipPKeRGJ7FZATMAf4UVYjdZhIV08bWoIzh7bmw4F6xKXwUU
         6lPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=2L81vM3FnCkUjdkaUkvpOqScwEqE/o+HgyLMCzUijkA=;
        b=AKRB/UK44753MkY8fxieMCcTJJyCc6KRGHM82wyTlRYHpM4JLnrknp7Sed1Xtm/lXB
         XPkAZKiCsyHeZtI32QNdMeqW+jkFggp282cMm7VIGPaYs4PBEu1WVPrYMXQ0dvMEnrsL
         Osgf+VJcMZhkJOf4KuE7XNC301uqAnNBKLWCDdPjtT4tgseZyq6MMbh1+9dM5PpMjYh+
         thPwFqIyXJm55eh3KB4sQXWtaf5kEfRdmo3PI3RqMyxfsBnRKRigBcju+bels7+vzAS0
         cnTcWAGT9GzNy+JbHcSjT1RgZggdd+8HmbXJF0n0P1nw/YEqwDg1QYk61NR6MzB1N1kg
         Kffw==
X-Gm-Message-State: ALyK8tKKDhgcZ/4qMt7dMm3IiNhf+ps0u9dtG0cp/sbB7GT5bi0oDT+lOuCzxpdXVudShw==
X-Received: by 10.98.81.3 with SMTP id f3mr4140400pfb.132.1465591706955;
        Fri, 10 Jun 2016 13:48:26 -0700 (PDT)
Received: from [10.112.156.249] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id k69sm19746495pfc.41.2016.06.10.13.48.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jun 2016 13:48:25 -0700 (PDT)
Subject: Re: [PATCH] serial/bcm63xx_uart: use correct alias naming
To:     Jonas Gorski <jogo@openwrt.org>, linux-serial@vger.kernel.org
References: <1465380523-7385-1-git-send-email-jogo@openwrt.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        =?UTF-8?Q?=c3=81lvaro_Fern=c3=a1ndez_Rojas?= <noltari@gmail.com>,
        Simon Arlott <simon@fire.lp0.eu>, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <575B2798.9000801@gmail.com>
Date:   Fri, 10 Jun 2016 13:48:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.8.0
MIME-Version: 1.0
In-Reply-To: <1465380523-7385-1-git-send-email-jogo@openwrt.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54019
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 06/08/2016 03:08 AM, Jonas Gorski wrote:
> The bcm63xx_uart driver uses the of alias for determing its id. Recent
> changes in dts files changed the expected 'uartX' to the recommended
> 'serialX', breaking serial output. Fix this by checking for a 'serialX'
> alias as well.
> 
> Fixes: e3b992d028f8 ("MIPS: BMIPS: Improve BCM6328 device tree")
> Fixes: 2d52ee82b475 ("MIPS: BMIPS: Improve BCM6368 device tree")
> Fixes: 7537d273e2f3 ("MIPS: BMIPS: Add device tree example for BCM6358")
> Signed-off-by: Jonas Gorski <jogo@openwrt.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

A future improvement could be to completely get rid of the id and
instead just dynamically allocate the ports structure.
-- 
Florian
