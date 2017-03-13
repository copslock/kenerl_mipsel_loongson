Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Mar 2017 09:57:52 +0100 (CET)
Received: from mail-lf0-x232.google.com ([IPv6:2a00:1450:4010:c07::232]:36557
        "EHLO mail-lf0-x232.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990522AbdCMI5lZHl0O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Mar 2017 09:57:41 +0100
Received: by mail-lf0-x232.google.com with SMTP id y193so60624890lfd.3
        for <linux-mips@linux-mips.org>; Mon, 13 Mar 2017 01:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=EkJ5Q9ruPgDar66BVWtK5D8zEnCLOAxvgRjvoecoAI4=;
        b=lhhIHcm6QRmEIUmTvHzXOboVqk/zENxzG/JlkFA7HFvxrG4HVPmAADYAfYZmQ7re5v
         8YRPulV7B9RRaNJDdUFMCOhnFujiFUxl0F6NEUmU9VwOFkFg1wO1A5hPNH7Sz8g/ID63
         V+GlCi4sQFqHJSumhCc2dqsI1/wywBs0vWOgimfb+WC7qXb4xKaT0UU+9S+rCHRQS68e
         xrLLCdScvU4QEmkq5E+ScMxLAD1GCQfCrOxRcEC6+7/TzM5UD+cCrgnsEAK9xP1+G8hZ
         NIxRGslaa3v+ADI2esEd8L5QkGoDY+Smzl5mB55URQcwc3R+jrxFuf4GEslkJj1B6UUh
         MzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=EkJ5Q9ruPgDar66BVWtK5D8zEnCLOAxvgRjvoecoAI4=;
        b=I4B63ytVKnNDkiMRa/bN1e0sG/Vzs8H9xeTne6JhWsKheMtq9ZyzMUgtKBCiBwCWbj
         V2RPuHceWpyZa5mohCyuhuLEtJY9IRt7Cb0fxncQ6PWnEbPhk1ZOTD7pVrjUuKAqWX7n
         Fvf9vHztkpg7rTKh60+ZCLWr7l8lUyR3kwOSkTgKWaQIQ6OJkMcFY7jr3ta6BbPH1mJt
         wqla+brZoQGVnxJ/sO4TJdIb1qX4WGcbAvSLtSh2+Cj/kjX/oRJZOoBv+jGgErje2bHF
         gczcQIvRLsF5WZHUn+aFWhJFQRpG3eEdPvzGA8HsZN6fvDz0bMIF6mGcQLTL25/Sqbn1
         OvHQ==
X-Gm-Message-State: AMke39mTfD4cthRGoAo956aCcUySt47qgC+vJp9nlFQo2OK956suGNd0IlwsZsdP1+eXhQ==
X-Received: by 10.46.9.75 with SMTP id 72mr9492802ljj.10.1489395456012;
        Mon, 13 Mar 2017 01:57:36 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.64])
        by smtp.gmail.com with ESMTPSA id d77sm3506054lfd.26.2017.03.13.01.57.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Mar 2017 01:57:35 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Lantiq: fix missing xbar kernel panic
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org,
        james.hogan@imgtec.com
References: <20170312181633.23453-1-hauke@hauke-m.de>
Cc:     linux-mips@linux-mips.org, "# 4 . 4 . x-" <stable@vger.kernel.org>,
        John Crispin <john@phrozen.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <b43e6a66-872b-38ca-3197-7327a155096a@cogentembedded.com>
Date:   Mon, 13 Mar 2017 11:57:36 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170312181633.23453-1-hauke@hauke-m.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57146
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

Hello!

On 3/12/2017 9:16 PM, Hauke Mehrtens wrote:

> Commit 08b3c894e5 "MIPS: lantiq: Disable xbar fpi burst mode"

    Also need parens around the commit summary. And 12 hex digits for the 
commit ID.

> accidentally requested the resources from the pmu address region
> instead of the xbar registers region, but the check for the returns

    s/returns/return/?

> value of request_mem_region() was wrong. Commit 98ea51cb0c8 "MIPS:
> Lantiq: Fix another request_mem_region() return code check" fixed the

    Same here...

> check of the return value of request_mem_region() which made the kernel
> panics.
> This patch now makes use of the correct memory region for the cross bar.
>
> Fixes: 08b3c894e5 ("MIPS: lantiq: Disable xbar fpi burst mode")
> Cc: <stable@vger.kernel.org> # 4.4.x-
> Cc: John Crispin <john@phrozen.org>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
[...]

MBR, Sergei
