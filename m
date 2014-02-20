Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 14:53:15 +0100 (CET)
Received: from mail-wg0-f50.google.com ([74.125.82.50]:33943 "EHLO
        mail-wg0-f50.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871402AbaBTNxMfPIv- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 14:53:12 +0100
Received: by mail-wg0-f50.google.com with SMTP id z12so1460512wgg.17
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 05:53:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=krWV4wIwMt2vOOVchccY7t0usiOpH3rJHPT/DMVPLjI=;
        b=HOLlNNhK+9hlunecztg6ZJKQNjq6y4+OCPO30yAgkXHfa8Ntv3ailtFBYKD8xMtabz
         NVQsVgzAVvzwlCaI6Ub+8pCWPAEVC8vg8JFR5ZJw8aC3aqUP6J7bJd9x+zcD+gNEanMG
         TM/GBm8ulZPvxsrG//NG0bbaD4yio9HSk992w6CJ6M1nNeRNBDPBTmd8W3W3EgetKLcf
         9ZF4fvtv5yrMRq4rhFdL8bk0hD9uEHH+9b0cx6gAfhNy3iT5S+j6Qj8j32OCXDvIEINV
         Yhxe7KV112kUsx/LJIxxUdxgsjDRO3oBjVJaw8EX+rMfxXGkiFfzDYeUk8JfHRnCFEIO
         hSpg==
X-Gm-Message-State: ALoCoQmWW4HgtlosmWTsGTLLcpX1cY4KFOSGJZpNVDTycgqPcBMrqzIGwTjt66dJZ6DTmFqQmZes
X-Received: by 10.194.62.206 with SMTP id a14mr2285975wjs.26.1392904387251;
        Thu, 20 Feb 2014 05:53:07 -0800 (PST)
Received: from [192.168.1.150] (AToulouse-654-1-343-25.w90-55.abo.wanadoo.fr. [90.55.62.25])
        by mx.google.com with ESMTPSA id br10sm9114518wjb.3.2014.02.20.05.53.05
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Feb 2014 05:53:06 -0800 (PST)
Message-ID: <530608C2.3070507@linaro.org>
Date:   Thu, 20 Feb 2014 14:53:06 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com> <53060496.6000303@linaro.org> <20140220134118.GT25765@pburton-linux.le.imgtec.org>
In-Reply-To: <20140220134118.GT25765@pburton-linux.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39354
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

On 02/20/2014 02:41 PM, Paul Burton wrote:
> On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
>> On 01/15/2014 02:55 PM, Paul Burton wrote:
>>> Declaring this allows drivers which need to initialise each struct
>>> cpuidle_device at initialisation time to make use of the structures
>>> already defined in cpuidle.c, rather than having to wastefully define
>>> their own.
>>>
>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> Cc: linux-pm@vger.kernel.org
>>> ---
>>>   include/linux/cpuidle.h | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>> index 50fcbb0..bab4f33 100644
>>> --- a/include/linux/cpuidle.h
>>> +++ b/include/linux/cpuidle.h
>>> @@ -84,6 +84,7 @@ struct cpuidle_device {
>>>   };
>>>
>>>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>>> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>>
>>
>> Nak. When a device is registered, it is assigned to the cpuidle_devices
>> pointer and the backend driver should use it.
>>
>
> Yes, but then if the driver needs to initialise the coupled_cpus mask
> then it cannot do so until after the device has been registered. During
> registration the cpuidle_coupled_register_device will then see the empty
> coupled_cpus mask & do nothing. The only other ways around this would be
> for the driver to define its own per-cpu struct cpuidle_device (which as
> I state in the commit message seems wasteful when cpuidle already
> defined them), or for cpuidle_coupled_register_device to be called later
> after the driver had a chance to modify devices via the cpuidle_devices
> pointers.

Yeah. I understand why you wanted to declare these cpu variables.

The mips cpuidle driver sounds like a bit particular. I believe I need 
some clarification on the behavior of the hardware to understand 
correctly the driver. Could you explain how the couples act vs the cpu ? 
And why cpu_sibling is used instead of cpu_possible_mask ?



>> --
>>   <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs
>>
>> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
>> <http://twitter.com/#!/linaroorg> Twitter |
>> <http://www.linaro.org/linaro-blog/> Blog
>>
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
