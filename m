Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Feb 2015 13:47:19 +0100 (CET)
Received: from mail-lb0-f180.google.com ([209.85.217.180]:34672 "EHLO
        mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007566AbbB0MrRTsmh9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Feb 2015 13:47:17 +0100
Received: by lbdu14 with SMTP id u14so16977585lbd.1
        for <linux-mips@linux-mips.org>; Fri, 27 Feb 2015 04:47:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=pHOvmLgDB/K+Pq/SA3+qUNPGtKhtWZcq2uGPshfB8r4=;
        b=WVqJ7BwyumEf6DzYia9czeKBHM+B6YyROOGA9VWD1FbnBPvhqN3AhlkU32v5j1ziKn
         P8cejyse7YpLsZlcjcCpr2uVlccuz9PMcQ8aE6iAz1/S76u0v2Wwn2+jLUr0QL24eg+U
         FoZsT9VYyAYdaNXwXfNzmFxuaDPlN6rcqkKiqg279KgEWjQXIRNLl6q8MYo8Qyd1L98g
         vLv2fN+3JUfSKKX8WnOgM+UcBWF81HesodtPmfNgUTx813XJGk8fE6wDgPeRZNQ2XovH
         J73J9ugR3JdRkERabEESxvQgsZloUQlzU96jsoKqnEbkvLRr34G1M0A7PxtoskDwv9pu
         tFAQ==
X-Gm-Message-State: ALoCoQl/NRM5CTbD3rAMMNeApY/25kvH8Z4WM0XqwCz2G3WjsMWsWc7ROe+uSflu2b+mLN7Aa8Qf
X-Received: by 10.152.42.238 with SMTP id r14mr12426007lal.13.1425041232401;
        Fri, 27 Feb 2015 04:47:12 -0800 (PST)
Received: from [192.168.3.154] (ppp85-141-192-100.pppoe.mtu-net.ru. [85.141.192.100])
        by mx.google.com with ESMTPSA id lf1sm819985lab.8.2015.02.27.04.47.09
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Feb 2015 04:47:11 -0800 (PST)
Message-ID: <54F0674D.7020804@cogentembedded.com>
Date:   Fri, 27 Feb 2015 15:47:09 +0300
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.5.0
MIME-Version: 1.0
To:     Valentin Rothberg <Valentin.Rothberg@lip6.fr>, ralf@linux-mips.org,
        taohl@lemote.com, chenhc@lemote.com, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] loongson-3/hpet.c: remove IRQF_DISABLED flag
References: <1425039262-20003-1-git-send-email-Valentin.Rothberg@lip6.fr>
In-Reply-To: <1425039262-20003-1-git-send-email-Valentin.Rothberg@lip6.fr>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46045
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 2/27/2015 3:14 PM, Valentin Rothberg wrote:

> The IRQF_DISABLED is a NOOP and scheduled to be removed.  According to Ingo
> Molnar (e58aa3d2d0cc01ad8d6f7f640a0670433f794922) running IRQ handlers with

    Please also specify that commit's summary line in parens, like this:

According to commit e58aa3d2d0cc01ad8d6f7f640a0670433f794922 (genirq: Run irq 
handlers with interrupts disabled)...

> interrupts enabled can cause stack overflows when the interrupt line of the
> issuing device is still active.

> Signed-off-by: Valentin Rothberg <Valentin.Rothberg@lip6.fr>

[...]

WBR, Sergei
