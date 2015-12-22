Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Dec 2015 23:05:31 +0100 (CET)
Received: from mail-pa0-f42.google.com ([209.85.220.42]:34510 "EHLO
        mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008656AbbLVWF3KMDdh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Dec 2015 23:05:29 +0100
Received: by mail-pa0-f42.google.com with SMTP id uo6so18114702pac.1;
        Tue, 22 Dec 2015 14:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=n+m17SjwhJoId5Tnm2G4Kr4rZTnXPMirs4EgF3AAhUQ=;
        b=WwdpZlIaSfClkW5F9S+0aI1PwxE1VcsSVmOA+/e01fP0Fq67LnZplFX/6nRoYfGbAF
         PBw+LIHyPPi6bibLUBEpdwqBqwMDKpaMFHRRr4xkGHXdkaVeAg94V6dwU31IpAKLDGQK
         gsv6+TbSg2t/MQC1LcWyLmM5z6bePtAC+qVb8NG1UZsm+Ru6KRw6AjFNDqj5Unh582GT
         n4hbu3Hyu0LhmaCw8BDJx9qVUxf+UkrF9s9LGv+ublWNK5H8W9fgMjuXRS855k/DUOa4
         +CZKWcKp/F82/LYyza/pTJdJnCGZb6ef1byNsfigeebzaTUsn3r0fMmXh2AnqkJoPSlI
         2nJg==
X-Received: by 10.66.218.170 with SMTP id ph10mr39345770pac.58.1450821923118;
        Tue, 22 Dec 2015 14:05:23 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id g68sm6302065pfd.55.2015.12.22.14.05.21
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 22 Dec 2015 14:05:22 -0800 (PST)
Message-ID: <5679C90F.7070401@gmail.com>
Date:   Tue, 22 Dec 2015 14:05:03 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
CC:     Alban Bedel <albeu@free.fr>
Subject: Re: [PATCH 37/54] mips: ar7/gpio: Be sure to clamp return value
References: <1450795227-27411-1-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1450795227-27411-1-git-send-email-linus.walleij@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50739
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

On 22/12/15 06:40, Linus Walleij wrote:
> As we want gpio_chip .get() calls to be able to return negative
> error codes and propagate to drivers, we need to go over all
> drivers and make sure their return values are clamped to [0,1].
> We do this by using the ret = !!(val) design pattern.
> 
> Cc: linux-mips@linux-mips.org
> Cc: Alban Bedel <albeu@free.fr>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>
-- 
Florian
