Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Feb 2014 15:39:37 +0100 (CET)
Received: from mail-wi0-f180.google.com ([209.85.212.180]:60557 "EHLO
        mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827297AbaBYOjedS3kR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Feb 2014 15:39:34 +0100
Received: by mail-wi0-f180.google.com with SMTP id hm4so815191wib.1
        for <linux-mips@linux-mips.org>; Tue, 25 Feb 2014 06:39:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=G2i3NOsQzSgDiFrnhwrfAOcB3zQV4fRHJpayeJlWWv4=;
        b=jSLay6nP1ArVa7CqHH83HAGjUC7uWf+UKTalsmDqaUOyUCdwZrZjISCXeA2V1hcmNY
         SxRUcRbuTvmiANWvx2T+Hy8XPc675V1FcAX1MPkIbCmnaBjOt1aG9sD7ss5NZ/bZmYGm
         +IVRFsRBm/jxRbIw2XqIzqWOENjw70J94NNQfh9D+xriRil8l0+ylpwK7bgELf+FXX1h
         ZVQRXxGJqvVA7aKm2FOQC6zIF4CodAvnCc5VSTjuOFMaMFkK5Y8oie9Rr5m616ICgaYI
         LiVkC8sudLXn55s1StPHHrbU6CnEsNu3zmB+O61O96brpBkfRDgMznmAjbebE1NXoIue
         WCvg==
X-Gm-Message-State: ALoCoQmqPk3PUKCu8ViF8OyQw/l7gUT2EV+s8Mlkq6QJ+vFCaCubSPFGxVmp8uME0KA+3mHi5AtD
X-Received: by 10.180.219.44 with SMTP id pl12mr3489717wic.12.1393339168794;
        Tue, 25 Feb 2014 06:39:28 -0800 (PST)
Received: from [192.168.1.150] (AToulouse-654-1-343-25.w90-55.abo.wanadoo.fr. [90.55.62.25])
        by mx.google.com with ESMTPSA id br10sm51255266wjb.3.2014.02.25.06.39.27
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Tue, 25 Feb 2014 06:39:28 -0800 (PST)
Message-ID: <530CAB22.5030506@linaro.org>
Date:   Tue, 25 Feb 2014 15:39:30 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>
CC:     linux-mips@linux-mips.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com> <53060496.6000303@linaro.org> <20140220134118.GT25765@pburton-linux.le.imgtec.org> <530608C2.3070507@linaro.org> <20140220140033.GU25765@pburton-linux.le.imgtec.org>
In-Reply-To: <20140220140033.GU25765@pburton-linux.le.imgtec.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39379
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

On 02/20/2014 03:00 PM, Paul Burton wrote:
> On Thu, Feb 20, 2014 at 02:53:06PM +0100, Daniel Lezcano wrote:
>> On 02/20/2014 02:41 PM, Paul Burton wrote:
>>> On Thu, Feb 20, 2014 at 02:35:18PM +0100, Daniel Lezcano wrote:
>>>> On 01/15/2014 02:55 PM, Paul Burton wrote:
>>>>> Declaring this allows drivers which need to initialise each struct
>>>>> cpuidle_device at initialisation time to make use of the structures
>>>>> already defined in cpuidle.c, rather than having to wastefully define
>>>>> their own.
>>>>>
>>>>> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
>>>>> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
>>>>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>>>> Cc: linux-pm@vger.kernel.org
>>>>> ---
>>>>>   include/linux/cpuidle.h | 1 +
>>>>>   1 file changed, 1 insertion(+)
>>>>>
>>>>> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
>>>>> index 50fcbb0..bab4f33 100644
>>>>> --- a/include/linux/cpuidle.h
>>>>> +++ b/include/linux/cpuidle.h
>>>>> @@ -84,6 +84,7 @@ struct cpuidle_device {
>>>>>   };
>>>>>
>>>>>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
>>>>> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);
>>>>
>>>>
>>>> Nak. When a device is registered, it is assigned to the cpuidle_devices
>>>> pointer and the backend driver should use it.
>>>>
>>>
>>> Yes, but then if the driver needs to initialise the coupled_cpus mask
>>> then it cannot do so until after the device has been registered. During
>>> registration the cpuidle_coupled_register_device will then see the empty
>>> coupled_cpus mask & do nothing. The only other ways around this would be
>>> for the driver to define its own per-cpu struct cpuidle_device (which as
>>> I state in the commit message seems wasteful when cpuidle already
>>> defined them), or for cpuidle_coupled_register_device to be called later
>>> after the driver had a chance to modify devices via the cpuidle_devices
>>> pointers.
>>
>> Yeah. I understand why you wanted to declare these cpu variables.
>>
>> The mips cpuidle driver sounds like a bit particular. I believe I need some
>> clarification on the behavior of the hardware to understand correctly the
>> driver. Could you explain how the couples act vs the cpu ? And why
>> cpu_sibling is used instead of cpu_possible_mask ?
>>
>>
>
> Sure. The CPUs that are coupled are actually VPEs (Virtual Processor
> Elements) within a single core. They share the compute resource (ALUs
> etc) of the core but have their own register state, ie. they're a form
> of simultaneous multithreading.
>
> Coherence within a MIPS Coherent Processing System is a property of the
> core rather than of an individual VPE (since the VPEs within a core
> share the same L1 caches). So for idle states which are non-coherent the
> VPEs within the core are coupled. That covers all idle states beyond a
> simple "wait" instruction - clock gating or powering down a core
> requires it to become non-coherent first.
>
> cpu_sibling_mask is already setup to indicate which CPUs (VPEs) are
> within the same core as each other, which is why it is simply copied for
> coupled_cpus.

Hi Paul,

thanks for the explanation.

   -- Daniel




-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
