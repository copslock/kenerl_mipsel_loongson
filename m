Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Mar 2017 11:51:16 +0200 (CEST)
Received: from mail-lf0-x236.google.com ([IPv6:2a00:1450:4010:c07::236]:32919
        "EHLO mail-lf0-x236.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993875AbdC3JvDi8jZT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Mar 2017 11:51:03 +0200
Received: by mail-lf0-x236.google.com with SMTP id h125so22594186lfe.0
        for <linux-mips@linux-mips.org>; Thu, 30 Mar 2017 02:51:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=E5lMb0nH/Vdj6bfCrA38S3yLwNqg44V71OEGQkc2+sw=;
        b=bDY1XjECaH4uRQWfrfB32l9prxhmItDZ9hLFcqcFFEhcVkcsV5T9EYPwu3S0vTLOVl
         hSXi2FlJYBnmoqhZARqzKXmHQqQ3hodOjpnGl+eYJaMh+4ufOe1Ru0Un3720NgNDx5Mv
         th+Dg1AyhigFRxF5Wlm8yc57/QG40Upm0Oi4AnEly432kf9pMkzuiwmL4OljOonRAldf
         3V4oEdr6OTxQywFyUdHkIW1gINt9ErRZLw+LQnJRZZCZ7WA3L44RNx0WROp20g/kh8Pm
         lAdek8VOoPqjp3rQhCXTtoMZ2s+NOaT8oPIDUWJFXspn+jMZx4TDxI2aOX8LoD9dukeT
         6PlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=E5lMb0nH/Vdj6bfCrA38S3yLwNqg44V71OEGQkc2+sw=;
        b=aSo+goZm0QGcQyTTHy1Sro7OM8NwHE9Jm5GAXrWu7wbrMmBECrb2opTpC86LH0Wn9j
         v/PJ8mxaZ4jNSVmZpFk9aBspJg93BwBcQf6+qoqlkmytJAC9u7G0Kb1K1WeDa2P7ZoNV
         jgHoO725GPqSZRiVIBoF0OlKJPZMf7scKcuXF/YtY7F1pIDxkRKlnCtq5FsmUdUcVWKh
         WSbn+EjXjKhSStqsuxwnlpccdYfg7MiIEXQLH+8qtcqfiaddllVqx1jLFtQGNtwMjmDj
         Cdt02wEP4wxTFw1ZamdHhkmd4MlIIiCJOM8AgdRY0Kqfn417o8J2BCeWkYcaG0i9DbLV
         FGfA==
X-Gm-Message-State: AFeK/H1m5Z2Y0bqHARMV069jF0pNS6+ChpmgDHXX7B4W5Z8Lo0k+yW4KWtJNT2WIvmr2yg==
X-Received: by 10.25.193.8 with SMTP id r8mr1289480lff.127.1490867458144;
        Thu, 30 Mar 2017 02:50:58 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.87.108])
        by smtp.gmail.com with ESMTPSA id f2sm288681ljb.20.2017.03.30.02.50.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Mar 2017 02:50:57 -0700 (PDT)
Subject: Re: [PATCH v6 1/8] MIPS: Loongson: Merge PRID macro for
 Loongson-1A/1B/1C
To:     Binbin Zhou <zhoubb@lemote.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@imgtec.com>
References: <1490841889-13450-1-git-send-email-zhoubb@lemote.com>
 <1490841889-13450-2-git-send-email-zhoubb@lemote.com>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Kelvin Cheung <keguang.zhang@gmail.com>,
        Yang Ling <gnaygnil@gmail.com>,
        =?UTF-8?B?6LCi6Ie06YKm?= <Yeking@Red54.com>,
        linux-mips@linux-mips.org, HuaCai Chen <chenhc@lemote.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <273c2b54-05df-687b-1633-36ee40a83a5d@cogentembedded.com>
Date:   Thu, 30 Mar 2017 12:50:55 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <1490841889-13450-2-git-send-email-zhoubb@lemote.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57479
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

On 3/30/2017 5:44 AM, Binbin Zhou wrote:

> As we all know, the Loongson-1 series CPUs(1A/1B/1C) share the same PRID macro.
> so I rename them for more readable.

    "Better readability", perhaps?

> Signed-off-by: Binbin Zhou <zhoubb@lemote.com>
> Signed-off-by: HuaCai Chen <chenhc@lemote.com>
[...]

MBR, Sergei
