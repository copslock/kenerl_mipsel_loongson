Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Feb 2016 18:52:14 +0100 (CET)
Received: from mail-lf0-f43.google.com ([209.85.215.43]:36562 "EHLO
        mail-lf0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012139AbcBCRwMzerhz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Feb 2016 18:52:12 +0100
Received: by mail-lf0-f43.google.com with SMTP id 78so19483926lfy.3
        for <linux-mips@linux-mips.org>; Wed, 03 Feb 2016 09:52:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fEowbdCNQGa/tUVEmBPMoN6hJi7zteUR5dqLy56KxIQ=;
        b=P6W9uLks8CoNWK2OXwxAka4l1JyRETY1Pk3S2SPNi2304GYFerojPQa7Bux7IW3fwe
         gPXMt3u65yJendOXhQs8acDpbVPRsENR11mzlOW52Xw6O092Wgd8V2nA65VhwK059kfy
         gwKfRRVD4j76VixOEClYHsSvORBkZE20UNrYSDgZMb9RiK3/ICs+Xf6EqTIkuvWbYHS0
         rlV7WlE97xGkKxup/x42buT1tg6phNIRRJRKfglzj1LefueXwxgbJMT47ELUVDs8/JAl
         cRkbxb2azsCSzAovS7W3VKOxKfElK8cz1a6IknCf9qx6ZCHFag2bPQ0QK89pug+/i0kw
         HW9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=fEowbdCNQGa/tUVEmBPMoN6hJi7zteUR5dqLy56KxIQ=;
        b=dweAMRSO7oodqiXw6nPxDxYxnbMfZEWM9hcB4vqpC+f4QIR8Kpuv5jK0bVV7ChEJwt
         Q03uKQm+VqsdVRaVADDlYiVeO4Cv+Ez9cNnIFMA7RGIAn6tr+12+NMLmDWmu5P891mXV
         q6Kpor/M/HdzhfKK3nDwoYar0KoYfJSl3vmCIP8rct7Vv21VupvPaDxjBiLv9cHZ+dxa
         jqKT8KJbBCzqTuOLnuxGSy8owr0SosbfdhZKGau8+nPkX0G3p+8vtkHsxjmHpQcznHFU
         B9L5D0iZfmMgjuarfoCDNIVmFJlNE/fNy722d5KKu7TBAm4WiRrR/bobRuCK8SZc2O0f
         m/zw==
X-Gm-Message-State: AG10YOSJknw4PRh18y/vkWUCwXJOxP4kh2HxPd0kYwl7Mgd8HI7dC9Rx1UbWlsYJxfQssw==
X-Received: by 10.25.170.203 with SMTP id t194mr1246160lfe.48.1454521927565;
        Wed, 03 Feb 2016 09:52:07 -0800 (PST)
Received: from wasted.cogentembedded.com ([83.149.9.100])
        by smtp.gmail.com with ESMTPSA id a67sm1041467lfe.6.2016.02.03.09.52.05
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 03 Feb 2016 09:52:06 -0800 (PST)
Subject: Re: [PATCH] MIPS: Octeon: Add Octeon III CN7XXX interface detection
To:     Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>,
        david.daney@cavium.com
References: <1454412318-27213-1-git-send-email-Zubair.Kakakhel@imgtec.com>
 <56B09528.1030902@cogentembedded.com> <56B23CB2.5090805@imgtec.com>
Cc:     janne.huttunen@nokia.com, aaro.koskinen@nokia.com,
        ralf@linux-mips.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56B23E44.7080304@cogentembedded.com>
Date:   Wed, 3 Feb 2016 20:52:04 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <56B23CB2.5090805@imgtec.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51707
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

On 02/03/2016 08:45 PM, Zubair Lutfullah Kakakhel wrote:

>>> Add basic CN7XXX interface detection.
>>>
>>> This allows the kernel to boot with ethernet working as it initializes
>>> the ethernet ports with SGMII instead of defaulting to RGMII routines.
>>>
>>> Tested on the utm8 from Rhino Labs with a CN7130.
>>>
>>> Signed-off-by: Zubair Lutfullah Kakakhel <Zubair.Kakakhel@imgtec.com>
>>> ---
>>>   arch/mips/cavium-octeon/executive/cvmx-helper.c | 41
>>> +++++++++++++++++++++++++
>>>   1 file changed, 41 insertions(+)
>>>
>>> diff --git a/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>> b/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>> index 376701f..1a28009 100644
>>> --- a/arch/mips/cavium-octeon/executive/cvmx-helper.c
>>> +++ b/arch/mips/cavium-octeon/executive/cvmx-helper.c
>> [...]
>>> @@ -260,6 +262,39 @@ static cvmx_helper_interface_mode_t
>>> __cvmx_get_mode_octeon2(int interface)
>>>   }
>>>
>>>   /**
>>> + * @INTERNAL
>>> + * Return interface mode for CN7XXX.
>>> + */
>>> +static cvmx_helper_interface_mode_t __cvmx_get_mode_cn7xxx(int interface)
>>
>>     Not *unsigned*?
>
> The rest of the instances in the file don't have unsigned.
>
> Probably because it is an enum..

    I meant the parameter, of course.

[...]

> (⌐▀͡ ̯ʖ▀)
>
> Thanks
> ZubairLK

[...]

MBR, Sergei
