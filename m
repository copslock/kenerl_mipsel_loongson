Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Jan 2018 21:03:21 +0100 (CET)
Received: from mail-qt0-x243.google.com ([IPv6:2607:f8b0:400d:c0d::243]:45011
        "EHLO mail-qt0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992956AbeARUDORt6nc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Jan 2018 21:03:14 +0100
Received: by mail-qt0-x243.google.com with SMTP id m59so33340074qte.11;
        Thu, 18 Jan 2018 12:03:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=SjmhoRvhS24QK1Dw9CVJWW9/BsweWxRcOdezY+Jw8i4=;
        b=D53tPRWrBM3JK+1PiHAhkapesAq0awcS/27lImvf/22hJ0Xq39K8XmncHMqG/sEXGA
         bpz6vcepuYScX8ORgKZx7Z/e/8MshCmr4q+NlM8QW+CoNed3FnOmDgvavu1HIMafQkom
         wMAxQAJDclrU2Y78/6Wl9OZb1L0T7NYIo1B10hELSlWXTY6g8LhuAfpW1a0XGmZUXXQr
         IB9COfZ4TvgNnUU2Eqn3ED/RpdgT5RD6dSuF+Fr5wWIITYIvEQc04LZX3HMzFm9Zbpbt
         QUv+bvas4vs4MkFtgU7A0u/qD3mP58BQx+BWTICNVTXaNdADsGTC34iO0qpPudwUfQMn
         gaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SjmhoRvhS24QK1Dw9CVJWW9/BsweWxRcOdezY+Jw8i4=;
        b=P8J/gTaP0i2wXAr6h668xxqlUtQY0nLWBU7SVa8zcqNUCv4OLvDhmF3IP9K/HSWw4p
         NnNgIrjmXXk/pr2SfAX3Dqq67lnKmeqT3T0ygMZIv62QEg7NfuRZfcEVQ6joC4FKkTR5
         7eULTKHkToXlhdoaS/5B4q6qB7K11k691Oo1XBrZ8kS3Dx1KPjmB2WxIvAob3bpTCds8
         sEyJE1xCwAhu4RRWF/CWzpPLZRBu5RRF4aVbf5/yvbsjQWU2REEuDdP4nOWFqPbAyc+0
         Q7l54W/NuzQLfJNDwkMxlNstCu3xnz/AwwMYNwUezRb2cSkkn/K9TBXw4Q4SrzkZdv6N
         Gifw==
X-Gm-Message-State: AKwxyte/xdQAAFhOkTuNbnrT1Lcdvotwp5ltHwkFl6OvvX+QRuYMOTyC
        ywoRP5OwwSd/BPJgUNwv954=
X-Google-Smtp-Source: ACJfBovBOzAHiWpKYU2cNFkXHl0yc9KXgsPBdAOVDJvzf3hyGRZQm/dYEZyh0GFHe0d3j9tBOcI6bQ==
X-Received: by 10.55.12.133 with SMTP id 127mr57669580qkm.69.1516305787986;
        Thu, 18 Jan 2018 12:03:07 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id p31sm5369434qta.77.2018.01.18.12.03.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Jan 2018 12:03:06 -0800 (PST)
Subject: Re: [PATCH 11/14] MIPS: memblock: Print out kernel virtual mem layout
To:     Serge Semin <fancer.lancer@gmail.com>, ralf@linux-mips.org,
        miodrag.dinic@mips.com, jhogan@kernel.org, goran.ferenc@mips.com,
        david.daney@cavium.com, paul.gortmaker@windriver.com,
        paul.burton@mips.com, alex.belits@cavium.com,
        Steven.Hill@cavium.com
Cc:     alexander.sverdlin@nokia.com, matt.redfearn@mips.com,
        kumba@gentoo.org, marcin.nowakowski@mips.com, James.hogan@mips.com,
        Peter.Wotton@mips.com, Sergey.Semin@t-platforms.ru,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20180117222312.14763-1-fancer.lancer@gmail.com>
 <20180117222312.14763-12-fancer.lancer@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <cce36f73-4381-f830-3422-1cef8ad9e622@gmail.com>
Date:   Thu, 18 Jan 2018 12:03:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20180117222312.14763-12-fancer.lancer@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62240
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

On 01/17/2018 02:23 PM, Serge Semin wrote:
> It is useful to have the kernel virtual memory layout printed
> at boot time so to have the full information about the booted
> kernel. In some cases it might be unsafe to have virtual
> addresses freely visible in logs, so the %pK format is used if
> one want to hide them.
> 
> Signed-off-by: Serge Semin <fancer.lancer@gmail.com>

I personally like having that information because that helps debug and
have a quick reference, but there appears to be a trend to remove this
in the name of security:

https://patchwork.kernel.org/patch/10124007/

maybe hide this behind a configuration option?
-- 
Florian
