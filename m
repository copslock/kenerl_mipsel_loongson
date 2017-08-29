Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Aug 2017 06:55:48 +0200 (CEST)
Received: from mail-oi0-x241.google.com ([IPv6:2607:f8b0:4003:c06::241]:38610
        "EHLO mail-oi0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994901AbdH2Ezj1M9Ia (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 29 Aug 2017 06:55:39 +0200
Received: by mail-oi0-x241.google.com with SMTP id r203so2158595oih.5;
        Mon, 28 Aug 2017 21:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=nZqsS8hrHRi8dNGwjlVPtcEq9qW1+VVqt2CyKZGIN6A=;
        b=dEmYNFDe/13EQUKJk//AM+kkIk2WgFmLc8u3Q4RzJ3a96RO7MMC/zE30y+gvUszexd
         0PsKdPDE4zTbhn1GwszacOIp7n6RcbG5PiEyL0Blm+u1tDX74HL5scy8yUE/g4LvIQcP
         TAli+ButXuntwR2lS+B5VW2IvJa2BhWJg7MDfbLUqH4X1WzF73YDdHQwZoJcj9ZoZCLk
         JCYpF266OenE+JTYR/21nfxTK6nO/f3U2aYmfib14UTgcBkyjMcathm51+wJ7w7FXf5a
         Yu+9BYcGo8YIBqYeaCjUshfEt9VwAuTruO2G6FKh2p88LBmE+IwSrZJZk/ta0S1mqVvi
         uG8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nZqsS8hrHRi8dNGwjlVPtcEq9qW1+VVqt2CyKZGIN6A=;
        b=beG4vZSlQ9e6Po5ukMwBW24pJmGZw1iBfqanVoZYDUhAvZ7/GXidrg5p3LkHEM2XMz
         n94MWPn6pWAmVMrk8OzPbA5iksMovoONDL1BBKiEPlpuksNyujrR7eQWksDmwtOA+NXk
         nTawaB8MAr6Uw045z6MwwZAlJbUeUkKRlUFbxqaTnXmKYFe2e7c24+VisLe9uMLXFoiJ
         huWnbgLprloTTjM1blV55ehlJfcIjmnBa1xoKF9xaq+IQ9hEWZURygNfZL5hTaKjbYW2
         zzJpsuh23ePb8Ghya+cigDmpwZo7xhL9jmQkxXrmUDmpX1ZfiD2QVOihWPum3OJEa5cs
         ncRA==
X-Gm-Message-State: AHYfb5j+t5JZoNSDoGTkqIoNUlh7h8c6GiFQcmDGfSjyz0LQhp17x/Hl
        JgU7LLJYvjasww==
X-Received: by 10.202.245.67 with SMTP id t64mr2447975oih.19.1503982533528;
        Mon, 28 Aug 2017 21:55:33 -0700 (PDT)
Received: from ?IPv6:2001:470:d:73f:d42c:b86f:7c64:7fe4? ([2001:470:d:73f:d42c:b86f:7c64:7fe4])
        by smtp.gmail.com with ESMTPSA id c187sm2443220oih.52.2017.08.28.21.55.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Aug 2017 21:55:32 -0700 (PDT)
Subject: Re: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if
 MIPS_GENERIC
To:     Miodrag Dinic <Miodrag.Dinic@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Goran Ferenc <Goran.Ferenc@imgtec.com>,
        Aleksandar Markovic <Aleksandar.Markovic@imgtec.com>,
        Bo Hu <bohu@google.com>,
        Douglas Leung <Douglas.Leung@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Jin Qian <jinqian@google.com>,
        Paul Burton <Paul.Burton@imgtec.com>,
        Petar Jovanovic <Petar.Jovanovic@imgtec.com>,
        Raghu Gandham <Raghu.Gandham@imgtec.com>
References: <1503061833-26563-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1503061833-26563-9-git-send-email-aleksandar.markovic@rt-rk.com>
 <20170826105235.GF7433@linux-mips.org>
 <232DDC0A2B605E4F9E85F6904417885F015D956D48@BADAG02.ba.imgtec.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <98b6a367-657d-d6a6-b3c2-7fbebd9241f7@gmail.com>
Date:   Mon, 28 Aug 2017 21:55:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.2.1
MIME-Version: 1.0
In-Reply-To: <232DDC0A2B605E4F9E85F6904417885F015D956D48@BADAG02.ba.imgtec.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59841
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



On 08/28/2017 02:33 AM, Miodrag Dinic wrote:
> Hi Ralf,
> 
> Even though I agree with your approach in handling this issue is more appropriate,
> but the reason we isolated this option just for MIPS_GENERIC was because we
> are not quite sure which MIPS platforms were using this option (and effectively i8042 driver), except for Malta.
> So, we decided to go with a safer solution and deselect it only for platforms which we are most sure aren't going to use it.
> 
> If you prefer to have this option sprinkled across platforms which are using it, please indicate which those are.

FWIW, I had started something similar, see comments from Maciej:

https://patchwork.linux-mips.org/patch/16226/

> 
> Kind regards,
> Miodrag
> 
> ________________________________________
> From: Ralf Baechle [ralf@linux-mips.org]
> Sent: Saturday, August 26, 2017 12:52 PM
> To: Aleksandar Markovic
> Cc: linux-mips@linux-mips.org; Miodrag Dinic; Goran Ferenc; Aleksandar Markovic; Bo Hu; Douglas Leung; James Hogan; Jin Qian; Paul Burton; Petar Jovanovic; Raghu Gandham
> Subject: Re: [PATCH v4 8/8] MIPS: Unselect ARCH_MIGHT_HAVE_PC_SERIO if MIPS_GENERIC
> 
> On Fri, Aug 18, 2017 at 03:09:00PM +0200, Aleksandar Markovic wrote:
> 
>> From: Miodrag Dinic <miodrag.dinic@imgtec.com>
>>
>> This effectively disables i8042 driver for MIPS_GENERIC kernel platform.
>> Currently, only sead-3, boston and ranchu boards are supported by the
>> MIPS generic kernel and none of them require this driver.
>> More specifically, kernel would crash if it gets enabled, because
>> i8042 driver would try to read from an non-existent IO register.
> 
> And many more platforms would beneftig from disabling this option because
> let's face it, the i8042's heydays are over.  So rather than spreading
> random depenencies on MIPS_GENERIC or other platforms through Kconfig
> please push the select of ARCH_MIGHT_HAVE_PC_SERIO to the platforms.
> 
>   Ralf
> 

-- 
Florian
