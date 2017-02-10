Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Feb 2017 00:48:19 +0100 (CET)
Received: from mail-pg0-x235.google.com ([IPv6:2607:f8b0:400e:c05::235]:33983
        "EHLO mail-pg0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992236AbdBJXsMG8MhW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Feb 2017 00:48:12 +0100
Received: by mail-pg0-x235.google.com with SMTP id 14so14436291pgg.1
        for <linux-mips@linux-mips.org>; Fri, 10 Feb 2017 15:48:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=nI2KL/3JjvyQmKwwRCR4uslIF/2mEGxohVpR3hjjjoE=;
        b=VocU+jayxVDWelbqvT7Dv5B/ZIWnV+MqHXWQazgwqleN2LXrjIel34K4+lM926yf+A
         0YasPfUQ69IRQ2p169Z6OyMsX6rrljVGTdi7yAOcfQ7afBtGm/lyDdRl5Af/6KLMM6iD
         Nftdht1/Ql1UOdJtK2pT7zo0v5q7av2zjOpdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=nI2KL/3JjvyQmKwwRCR4uslIF/2mEGxohVpR3hjjjoE=;
        b=hOqwE4IU+2kQQqfyERKhMig7lqS+aM5HBzOhTiJHBHLkyJ64+I/sIFcjPl5WbWkz0Y
         4IojkFyHN/uMSUZQbr29PKDEyVag13o50rB19hVlcqkJlGU9O92C/M9kPLE54MY2pzdt
         eogK/bXjTwRsh0iu1NWLjW2oTFbs6RdHcEv8XOhplCUqI/qaRoChAabBwqnJIp3V0zSC
         QLxnbSbtedxtRCltsSt2HZtgM+LLR3mfZmMZnhZ/sA85XJTFoRizYvnqPFu7boC5KFKm
         BL1sVqq3Uvi8uHUAnE2DlD+957KC3QDkHANqCGAO16oxosvGNYjgZbF3BQJnTR8By3i4
         JwxA==
X-Gm-Message-State: AMke39n7Pu9opu2cmod/uDYZJyAR1jm2pIpl28LvwLNOkNNSf9isBYqnV4hpPKnslH6hUIpl
X-Received: by 10.98.133.202 with SMTP id m71mr13416695pfk.102.1486770486064;
        Fri, 10 Feb 2017 15:48:06 -0800 (PST)
Received: from [10.13.138.212] ([192.19.255.250])
        by smtp.gmail.com with ESMTPSA id w89sm1281869pfk.133.2017.02.10.15.48.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Feb 2017 15:48:05 -0800 (PST)
Subject: Re: [PATCH] MIPS: Fix cacheinfo overflow
To:     James Hogan <james.hogan@imgtec.com>
References: <20170208234523.GA13263@roeck-us.net>
 <20170210230120.21588-1-james.hogan@imgtec.com>
 <d63e0019-5861-ccca-7959-631916e6c882@broadcom.com>
 <20170210234437.GB9246@jhogan-linux.le.imgtec.org>
Cc:     linux-mips@linux-mips.org, Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com
From:   Justin Chen <justin.chen@broadcom.com>
Message-ID: <23127a9b-cd2e-93be-0d1b-994890d1cb60@broadcom.com>
Date:   Fri, 10 Feb 2017 15:48:04 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170210234437.GB9246@jhogan-linux.le.imgtec.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <justin.chen@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56770
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justin.chen@broadcom.com
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



On 02/10/2017 03:44 PM, James Hogan wrote:
> Hi Justin,
>
> On Fri, Feb 10, 2017 at 03:10:47PM -0800, Justin Chen wrote:
>> I actually submitted a v2 of the patch sometime back located here:
>> https://patchwork.linux-mips.org/patch/15107/
>>
>> The v2 had some code review changes from Matt Redfearn. These changes
>> indirectly got rid of the error, which was why I wasn't running into the
>> crash.
>
> Ah yes. It looks like Ralf applied the original patch on January 3rd,
> before the last 3 submissions of the patch.
>
> Incidentally, in future I'd recommend incrementing the patch version
> number each time you submit a new version, and mentioning what has
> changed in a comment at the bottom of the commit message (anything after
> "---" gets dropped when the patch is applied).
>
> A random example:
> https://patchwork.linux-mips.org/patch/15134/
Got it. Sorry, will do next time!
>
>>
>> Either way, whatever makes more sense, we can drop the other v1 patch
>> and add v2 or just add this patch on top.
>
> Since the patch has already been applied for a while and the merge
> window is imminent, I think its best to make do with fixup patches on
> top this time around.
Sounds good to me.
>
> Thanks
> James
>
