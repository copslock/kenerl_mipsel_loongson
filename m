Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Apr 2017 13:05:09 +0200 (CEST)
Received: from mail-lf0-x230.google.com ([IPv6:2a00:1450:4010:c07::230]:36424
        "EHLO mail-lf0-x230.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990557AbdDGLFCRs4IE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Apr 2017 13:05:02 +0200
Received: by mail-lf0-x230.google.com with SMTP id s141so4697994lfe.3
        for <linux-mips@linux-mips.org>; Fri, 07 Apr 2017 04:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=gDRuDfX8qlhobmTaMd7ntSufC/Mb9aGA1MtxFiGg3rw=;
        b=P3PZDwI7xOLOgB5FzaOOTAHu3l7J3A+jFgATgLIJBddElklBViqdON6Q/X+pB2TCbW
         2iDF+6iKjQ9FskAVbHrtlY+BztcEAs+eU7ATlEuyiNbaeTuScqq7ghzROoUzDtyoeePl
         dKqJyQeFKIATAuCK+DJNUOV3rV3s2qDGu0WMMqx/15WvXvpGQWq94jZVlNrmJ7rtsNw3
         Qhh5rXee43CBuJQysYyC+cObBvdB0I34RPq4QOrUCsnGC7dlP6aB1ER0zJG/KMxvuU5t
         Z19TU+rxR0iUn/C4uAcBLBuD+vGnTNRCyL6LshbXWoHghtjOsqD2BzofqodZwzn7P1Tw
         NzYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=gDRuDfX8qlhobmTaMd7ntSufC/Mb9aGA1MtxFiGg3rw=;
        b=oIiYIxZ42bVJRkMD62BEsFQtEhEmj4x5cIsOVEYzAizOZdaVK+lEoKKApuHkhnkKZL
         EV4FmMtjqHMyHLeH7zk+SiXJH+cBZ86Co9LjyyUskYIJVAyO/suPDv2iOl+hdU7RMRTK
         B5I6r8kcoIPhCNlE9jpKsXK2biwvSHpgG3bFo50mr11AMfxfccwaX9kL7I+oDPG4zvQf
         o5zaN8q5usUHOFvK7H9ihzeo+0JhLK16vm1pJa7X8uIamc96T9crfIphE1/QntD8H2RI
         8tg12RHn4UuB0huLSUGDpe5Tz/823e+TB3fWhpebmv7Ad53JMqvF6T98FdL5vo5g+Fn1
         iYaA==
X-Gm-Message-State: AFeK/H3szZjD1HJIiwRh49KSAUw7xdih4RlYsJWnIvkwxf0nMFHfYAFe9b1PCDVcpQKu0Q==
X-Received: by 10.25.153.142 with SMTP id b136mr13050761lfe.85.1491563096902;
        Fri, 07 Apr 2017 04:04:56 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.80.223])
        by smtp.gmail.com with ESMTPSA id j15sm876104lfg.22.2017.04.07.04.04.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Apr 2017 04:04:56 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Use common outgoing-CPU-notification code
To:     Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>
References: <1491559974-20197-1-git-send-email-marcin.nowakowski@imgtec.com>
Cc:     linux-mips@linux-mips.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <57852660-ca40-0fb5-14b9-5e9e69cde907@cogentembedded.com>
Date:   Fri, 7 Apr 2017 14:04:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1491559974-20197-1-git-send-email-marcin.nowakowski@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57617
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

On 4/7/2017 1:12 PM, Marcin Nowakowski wrote:

> This commit removes the open-coded CPU-offline notification with new

    Replaces, perhaps?

> common code.  In particular, this change avoids calling scheduler code
> using RCU from an offline CPU that RCU is ignoring.
>
> Signed-off-by: Marcin Nowakowski <marcin.nowakowski@imgtec.com>
[...]

MBR, Sergei
