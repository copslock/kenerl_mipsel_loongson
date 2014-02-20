Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 14:35:27 +0100 (CET)
Received: from mail-wg0-f47.google.com ([74.125.82.47]:59864 "EHLO
        mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871402AbaBTNfYW2VmP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 14:35:24 +0100
Received: by mail-wg0-f47.google.com with SMTP id k14so1471810wgh.14
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 05:35:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=rvoChHw4bHmNthag4F+/1Ik+aycD6FbBfVIYq94TN1I=;
        b=GXfhJXA4if3+vZH7t/8zPlgGSg65r3jvtXpxs5DHLXtiZ1uvBgw8Wz5KX/iv+F7Atl
         D5hZwewA5s/YVTpgG7U6rLvG823XWdIZ66EOGeTYfdWNogU7ipHW/SVcd23U4oz9ts7T
         GA2OK0vEKHELDKOx9xSRxUx8mVwr2eqKCDqeRc6aIB8EPXGypmeyCPP/4s4fcmu980/0
         EzDroKj1um+B8MMPpeu1YOc4pLOCxx64QKF+AyM5DOVyIwuiFfpJTlzCcygYtPlOjcUX
         L8kRM1xevJ/3ozXrjs10OyebV8UjadkmTD51t0itrPsl5MX553sOVt4KL2gbUbquOvxN
         1OmA==
X-Gm-Message-State: ALoCoQkGPncKVN193Iy/FGSF1g2EqrIAbPMhsjtxQtSr+X6lIvPjX0+aNJGuV92+fIMvHQitR9tE
X-Received: by 10.180.211.239 with SMTP id nf15mr7138478wic.9.1392903319062;
        Thu, 20 Feb 2014 05:35:19 -0800 (PST)
Received: from [192.168.1.150] (AToulouse-654-1-343-25.w90-55.abo.wanadoo.fr. [90.55.62.25])
        by mx.google.com with ESMTPSA id ha1sm8961461wjc.23.2014.02.20.05.35.17
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 20 Feb 2014 05:35:18 -0800 (PST)
Message-ID: <53060496.6000303@linaro.org>
Date:   Thu, 20 Feb 2014 14:35:18 +0100
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
CC:     "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Subject: Re: [PATCH 09/10] cpuidle: declare cpuidle_dev in cpuidle.h
References: <1389794137-11361-1-git-send-email-paul.burton@imgtec.com> <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
In-Reply-To: <1389794137-11361-10-git-send-email-paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39351
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

On 01/15/2014 02:55 PM, Paul Burton wrote:
> Declaring this allows drivers which need to initialise each struct
> cpuidle_device at initialisation time to make use of the structures
> already defined in cpuidle.c, rather than having to wastefully define
> their own.
>
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> Cc: linux-pm@vger.kernel.org
> ---
>   include/linux/cpuidle.h | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
> index 50fcbb0..bab4f33 100644
> --- a/include/linux/cpuidle.h
> +++ b/include/linux/cpuidle.h
> @@ -84,6 +84,7 @@ struct cpuidle_device {
>   };
>
>   DECLARE_PER_CPU(struct cpuidle_device *, cpuidle_devices);
> +DECLARE_PER_CPU(struct cpuidle_device, cpuidle_dev);


Nak. When a device is registered, it is assigned to the cpuidle_devices 
pointer and the backend driver should use it.



-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
