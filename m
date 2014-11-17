Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Nov 2014 22:29:15 +0100 (CET)
Received: from mail-wg0-f45.google.com ([74.125.82.45]:43470 "EHLO
        mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013874AbaKQV3KaA5jH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Nov 2014 22:29:10 +0100
Received: by mail-wg0-f45.google.com with SMTP id x12so25916194wgg.4
        for <linux-mips@linux-mips.org>; Mon, 17 Nov 2014 13:29:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=R5ph7gXRIrG608tU9XczeEzV+xKsIos0j40MW2odLAo=;
        b=K4vjzXFLZIKSLBxdZ1lRyKvsNxdEX+nv1kGQ/ZpNd5EZ2JyzwN/j/q4JUvcI83ATov
         iQLOd5amTQvhhOxrgT3ZgWHpKzQqfxEirQSqB0aFMgrFZxh0dyEF8YkN1SaNF09rZypV
         h/RQLESfkd+OYqpXVCeiSf/CbwTwrU2eenw9sTpbfAPnPaZIJiZVLfQq7ThHPri/EjA2
         XDDDu0kt9rWiuobu89Iquvnn7/kpc5A7j7ZBhG0wvAcOct5Xj+flN68FDFzgojxHX+Bi
         4vOvGvf1P5zqXc5lheiGr1O1eGEOv+Q0BTIk/RjeqWOinqTJzYw1eetGZPUiWleh93L4
         ojDw==
X-Gm-Message-State: ALoCoQk5ijAL5frGxIWg0Qve1rmV7jTWXyXef49M/EdaNb7ct0TZz6Ji0D3+VPAe0HZqz/IlmyP4
X-Received: by 10.194.150.148 with SMTP id ui20mr42056849wjb.90.1416259745307;
        Mon, 17 Nov 2014 13:29:05 -0800 (PST)
Received: from [192.168.1.15] (AToulouse-656-1-820-36.w109-215.abo.wanadoo.fr. [109.215.21.36])
        by mx.google.com with ESMTPSA id cz3sm53140672wjb.23.2014.11.17.13.29.03
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Nov 2014 13:29:04 -0800 (PST)
Message-ID: <546A689E.3050207@linaro.org>
Date:   Mon, 17 Nov 2014 22:29:02 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
MIME-Version: 1.0
To:     Andrew Bresticker <abrestic@chromium.org>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V5 4/4] clocksource: mips-gic: Add device-tree support
References: <1415821419-26974-1-git-send-email-abrestic@chromium.org>   <1415821419-26974-5-git-send-email-abrestic@chromium.org>       <546A66EA.3090107@linaro.org> <CAL1qeaHpK0a+ONK3bhVrRk-G7iwRw_HwpjtLwi6E6EJ+rccbww@mail.gmail.com>
In-Reply-To: <CAL1qeaHpK0a+ONK3bhVrRk-G7iwRw_HwpjtLwi6E6EJ+rccbww@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44253
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 11/17/2014 10:26 PM, Andrew Bresticker wrote:
> On Mon, Nov 17, 2014 at 1:21 PM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> On 11/12/2014 08:43 PM, Andrew Bresticker wrote:
>>>
>>> Parse the GIC timer frequency and interrupt from the device-tree.
>>>
>>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>
>>
>> Hi Andrew,
>>
>> through which tree is this patch supposed to go ?
>>
>> Is there any dependency ?
>
> There are quite a few dependencies, so this series and all the other
> MIPS GIC stuff is going through the MIPS tree.

Ok thanks.

   -- Daniel


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
