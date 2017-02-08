Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 08 Feb 2017 20:45:29 +0100 (CET)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:36316
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992209AbdBHTpXEmg4Y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 8 Feb 2017 20:45:23 +0100
Received: by mail-qk0-x244.google.com with SMTP id i34so19282318qkh.3;
        Wed, 08 Feb 2017 11:45:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=yb+fntn2yTlI/TMPuoumya2O4Cp9kTaZrB/acDElYxI=;
        b=G5M+ztWaJhzjn3MiKmQskfVrytisBeaUDJ5XHH8fj4jCyUq9Hkhn0BMQTIqGk39Ci9
         UkM9Pvew6QyUPuDuYkW/IrzqmFo5ArO3IIXR4tTtw+RPvAnZBQsuRlDn4uAQASUg7y1J
         NcNI5GKASy374AReRMZ5EPaKs38o3q0aAiJBd+q9SEJ5oc6qZ2YYQuBGxZRKjS3hmguG
         yOfJcznyHVF9tv4LaIGb2mMmozPe4r1+3OpVpq5Xy9As8e/yFxkJpJX0SsfuB1W5qAlv
         J0yzlClZg9gHkz4K8FwNhQhzcWAm5s7/g29x0GXMVTbCuBL78Mh/D1ZSwkBY8Kzlxk+A
         QiUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=yb+fntn2yTlI/TMPuoumya2O4Cp9kTaZrB/acDElYxI=;
        b=i71ba8cRr6aJs5AznLOFX354Yd3cuxABTPSnpCwupJz8oKF3jZxm2g4YRG1rwyFF0k
         o0E/qYEcLW0QlQ8k4Vbffu6lfvD5994V3tqbpEYx500tTkLqSKw6c6uww+S6VkN8sD9j
         bmMkaNe/yjwAPxyCB37JmG4aqXRy59otKH8p+jA32SCIc9SMgtG4PMG6IGFNBIkX8HPD
         j+UkFxE89g7eiSR8tvpgscgiuvbJ8pUnb9gJdZYQgifh+4VY4sBWuj4JzG0fQfdTrWY4
         jijFG1lIBw7jYR7MwdkAI1YqR/aZbUto0+so7XCwLLMqvgaDl0pjvoZVrb+6PZcBgT7q
         hOSw==
X-Gm-Message-State: AMke39lpy34xVm8z0ztypn3Y9NiCR9mhdf1S49yncCmGk/uuMh1WfM4+v+ybBCyHzVOnPw==
X-Received: by 10.55.79.146 with SMTP id d140mr20714453qkb.69.1486583117336;
        Wed, 08 Feb 2017 11:45:17 -0800 (PST)
Received: from [10.112.156.244] ([192.19.255.250])
        by smtp.googlemail.com with ESMTPSA id q145sm7030486qke.37.2017.02.08.11.45.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 Feb 2017 11:45:16 -0800 (PST)
Subject: Re: [PATCH net-next v2 00/12] net: dsa: remove unnecessary phy.h
 include
To:     Kalle Valo <kvalo@codeaurora.org>,
        David Miller <davem@davemloft.net>
References: <20170207230305.18222-1-f.fainelli@gmail.com>
 <20170208.110626.346978547122180233.davem@davemloft.net>
 <87h944ll0w.fsf@kamboji.qca.qualcomm.com>
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
Message-ID: <5fe312c8-e59e-669c-cd29-f6773adcd8e5@gmail.com>
Date:   Wed, 8 Feb 2017 11:45:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <87h944ll0w.fsf@kamboji.qca.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56736
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

On 02/08/2017 08:11 AM, Kalle Valo wrote:
> David Miller <davem@davemloft.net> writes:
> 
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> Date: Tue,  7 Feb 2017 15:02:53 -0800
>>
>>> I'm hoping this doesn't conflict with what's already in net-next...
>>>
>>> David, this should probably go via your tree considering the diffstat.
>>
>> I think you need one more respin.  Are you doing an allmodconfig build?

I did not, instead tried to test each driver individually in different
configurations...

>> If not, for something like this it's a must:
>>
>> drivers/net/wireless/ath/wil6210/cfg80211.c:24:30: error: expected ‘)’ before ‘bool’
>>  module_param(disable_ap_sme, bool, 0444);
>>                               ^
>> drivers/net/wireless/ath/wil6210/cfg80211.c:25:34: error: expected ‘)’ before string constant
>>  MODULE_PARM_DESC(disable_ap_sme, " let user space handle AP mode SME");
>>                                   ^
>> Like like that file needs linux/module.h included.
> 
> Johannes already fixed a similar (or same) problem in my tree:
> 
> wil6210: include moduleparam.h
> 
> https://git.kernel.org/cgit/linux/kernel/git/kvalo/wireless-drivers-next.git/commit/?id=949c2d0096753d518ef6e0bd8418c8086747196b
> 
> I'm planning to send you a pull request tomorrow which contains that
> one.

Thanks Kalle!

David, can you hold on this series until Kalle's pull request gets
submitted? Past this error, allmodconfig builds fine with this patch
series (just tested). Thanks!
-- 
Florian
