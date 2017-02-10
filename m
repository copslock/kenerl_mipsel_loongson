Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 20:45:09 +0100 (CET)
Received: from mail-qt0-x241.google.com ([IPv6:2607:f8b0:400d:c0d::241]:35466
        "EHLO mail-qt0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992110AbdBJTpARfetX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 20:45:00 +0100
Received: by mail-qt0-x241.google.com with SMTP id s58so5799033qtc.2;
        Fri, 10 Feb 2017 11:45:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=ZZHlTqjERK50H5JjsyUbRVAdBhCWlDVGhFsTEHZw9Mg=;
        b=M6yGyGpRuFAjtlKj5cYkgrXLBAIBIvvcxbYGAhkLUxi+gtV/ha4GqpyvaAwqnt2BsE
         zMUwnVzzw/Xk4UTMmcuCtiXzplv6/kDsM4R2hMIAmInA+Dwry700jdKzVBCc9dC4z6Y+
         KSZcgTm3QLJi/JyFVIYkadiUoshHLdca57nfuGe/x374orrnDamRccjKieH0s8ia74Rg
         KfQ486NOw3xIdd1KtCVTt1tAdkRNjwwwYRs5xwaRGPa91mq22bzQGC1mIqLmwJSi64oW
         UyA85e7WW3Ik7nsyRsy7LmgxOJHrgsjV703H/5WaS321eHJOkLQf8n7Ua5YeCQ0S36QZ
         pNYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=ZZHlTqjERK50H5JjsyUbRVAdBhCWlDVGhFsTEHZw9Mg=;
        b=mFd14lDWkD5OKZ1OurnNhPmBHIuciyG54nh/A+oFSDnMO2wensROrEGudFQTvmy5M7
         8LhvmDnuWlVgheB44300gxEepMCZvxwMpr5bfBgfnxKPhPT7gy/VFBrevpoByIeOfhhu
         BHsOHntadzR1M49PgQV/L0xghGDcGE9TPqzfZu/C2aDfHAUV0oFAzSVep2b+slTbDppo
         vd3St9HuuopUa9AUn0T6eI7YllGT1+rgExKwZ8NkHVY1VqDUegmSAWAV6hWXGew/by9O
         9Dd4AIYoGJMoQXPvDEFdaugX42mN+IfCB7h4xHw7+8ydWVBwWVDkp8E2CVDtRNnL4jYr
         lw4w==
X-Gm-Message-State: AMke39liTBx0e7T3n5bJZ2E80mdBbBvegORJ/otuuL0cIiDxAJU/b10XfJ0WFsDz2+KY+Q==
X-Received: by 10.200.38.142 with SMTP id 14mr9492354qto.190.1486755894500;
        Fri, 10 Feb 2017 11:44:54 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id c82sm522655qka.69.2017.02.10.11.44.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 11:44:53 -0800 (PST)
Subject: Re: [PATCH net-next v2 00/12] net: dsa: remove unnecessary phy.h
 include
To:     David Miller <davem@davemloft.net>, kvalo@codeaurora.org
References: <87h944ll0w.fsf@kamboji.qca.qualcomm.com>
 <5fe312c8-e59e-669c-cd29-f6773adcd8e5@gmail.com>
 <877f4zjw01.fsf@kamboji.qca.qualcomm.com>
 <20170210.135138.2084086346069765205.davem@davemloft.net>
Cc:     netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-nfs@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
        target-devel@vger.kernel.org, andrew@lunn.ch,
        anna.schumaker@netapp.com, derek.chickles@caviumnetworks.com,
        felix.manlunas@caviumnetworks.com, bfields@fieldses.org,
        jlayton@poochiereds.net, jirislaby@gmail.com,
        mcgrof@do-not-panic.com, madalin.bucur@nxp.com,
        UNGLinuxDriver@microchip.com, nab@linux-iscsi.org,
        mickflemm@gmail.com, nicolas.ferre@atmel.com,
        raghu.vatsavayi@caviumnetworks.com, ralf@linux-mips.org,
        satananda.burla@caviumnetworks.com,
        thomas.petazzoni@free-electrons.com, timur@codeaurora.org,
        trond.myklebust@primarydata.com,
        vivien.didelot@savoirfairelinux.com, woojung.huh@microchip.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <68d8c792-5d09-7cdc-4a94-8437bfb0299e@gmail.com>
Date:   Fri, 10 Feb 2017 11:44:49 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210.135138.2084086346069765205.davem@davemloft.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56762
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

On 02/10/2017 10:51 AM, David Miller wrote:
> From: Kalle Valo <kvalo@codeaurora.org>
> Date: Thu, 09 Feb 2017 16:10:06 +0200
> 
>> Florian Fainelli <f.fainelli@gmail.com> writes:
>>
>>>>> If not, for something like this it's a must:
>>>>>
>>>>> drivers/net/wireless/ath/wil6210/cfg80211.c:24:30: error: expected ‘)’ before ‘bool’
>>>>>  module_param(disable_ap_sme, bool, 0444);
>>>>>                               ^
>>>>> drivers/net/wireless/ath/wil6210/cfg80211.c:25:34: error: expected ‘)’ before string constant
>>>>>  MODULE_PARM_DESC(disable_ap_sme, " let user space handle AP mode SME");
>>>>>                                   ^
>>>>> Like like that file needs linux/module.h included.
>>>>
>>>> Johannes already fixed a similar (or same) problem in my tree:
>>>>
>>>> wil6210: include moduleparam.h
>>>>
>>>> https://git.kernel.org/cgit/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=949c2d0096753d518ef6e0bd8418c8086747196b
>>>>
>>>> I'm planning to send you a pull request tomorrow which contains that
>>>> one.
>>>
>>> Thanks Kalle!
>>>
>>> David, can you hold on this series until Kalle's pull request gets
>>> submitted? Past this error, allmodconfig builds fine with this patch
>>> series (just tested). Thanks!
>>
>> Just submitted the pull request:
>>
>> https://patchwork.ozlabs.org/patch/726133/
> 
> I've retried this patch series, and will push it out assuming the build
> completes properly.

I see it merged in net-next/master, thanks a lot this is going to save a
lot of cycles in the future, thanks David!
-- 
Florian
