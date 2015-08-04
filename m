Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 11:48:46 +0200 (CEST)
Received: from mail-wi0-f176.google.com ([209.85.212.176]:35323 "EHLO
        mail-wi0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012027AbbHDJsngMKqG (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 11:48:43 +0200
Received: by wibxm9 with SMTP id xm9so158124981wib.0
        for <linux-mips@linux-mips.org>; Tue, 04 Aug 2015 02:48:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=eCxbdJWaiIOybLpc7uiwII+CKPfGXy73NHzx7jRpaGg=;
        b=gp15bBg8NXmDel9MYWwkVyErhsOYgG8FeHB+3XwsGLGV49P7vqW+iTSkX/wSoUkod6
         e6zOMicc0oWmmeuKtAJjwMQq+02Fvc+HFgo9vs8vGXT86eG61lLunWNCryKBLjKhKmWz
         xIpOFCdlQksx1q7xbLNRSogEpCfGv4fGOnpRN7w8DYo1514frPnSd8rQ5TJYfoU4ePqs
         tkgu+YBYHcU5GfuPSSaU0Ru5mA2HLa+XPes9YdiekWqpT9dwsVhUrLxXetlt4GL9XQKT
         RZy+9M30+WsRwcFRQm7dv8MinW1iJtkf30qJQYLdPAP7M8nMnKI/HkoVjaJHDR6KjBa6
         nJzg==
X-Gm-Message-State: ALoCoQmSKX2FdMcd06oCR5yG6gt1vnNsmIRMHbeAMjFb9wb0KpD7JL/AV2y2RphWW3SMtsggwLPW
X-Received: by 10.194.63.20 with SMTP id c20mr6764879wjs.134.1438681718344;
        Tue, 04 Aug 2015 02:48:38 -0700 (PDT)
Received: from [192.168.1.150] (185.Red-213-96-199.staticIP.rima-tde.net. [213.96.199.185])
        by smtp.googlemail.com with ESMTPSA id bu12sm868379wjb.44.2015.08.04.02.48.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 02:48:37 -0700 (PDT)
Message-ID: <55C08A73.60505@linaro.org>
Date:   Tue, 04 Aug 2015 11:48:35 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v4 0/7] Clocksource changes for Pistachio CPUFreq.
References: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com> <20150728095128.GA23771@linux-mips.org>
In-Reply-To: <20150728095128.GA23771@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48564
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

On 07/28/2015 11:51 AM, Ralf Baechle wrote:
> Daniel,
>
> On Mon, Jul 27, 2015 at 03:00:11PM +0100, Govindraj Raja wrote:
>
>> From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>>
>> The purpose of this patchset is to support CPUFreq on Pistachio SoC.
>> However, given Pistachio uses the MIPS GIC clocksource and clockevent drivers
>> (clocked from the CPU), adding CPUFreq support needs some work.
>>
>> This patchset changes the MIPS GIC clockevent driver to update the frequency of
>> the per-cpu clockevents using a clock notifier.
>>
>> Then, we add a clocksource driver for IMG Pistachio SoC, based on the
>> general purpose timers. The SoC only provides four timers, so we can't
>> use them to implement the four clockevents and the clocksource.
>>
>> However, we can use one of these timers to provide a clocksource and a
>> sched clock. Given the general purpose timers are clocked from the peripheral
>> system clock tree, they are not affected by CPU rate changes.
>>
>> Patches 1 to 3 are just style cleaning and preparation work.
>> Patch 4 adds the clockevent frequency update.
>> Patches 5 and 6 add the new clocksource driver.
>> Patch 7 introduces an option to enable the timer based clocksource on Pistachio.
>
> if you're happy with this series feel free to add my ack to patch 7/7
> which is the only one that touches arch/mips.
>
> Alternatively I can carry this in the MIPS tree which would have tbe
> benefit of better testing.

Ok, go ahead.

For the series 1-4: Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>



-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
