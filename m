Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Feb 2016 19:12:12 +0100 (CET)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:36827 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012408AbcBOSMIK17Ir (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Feb 2016 19:12:08 +0100
Received: by mail-lb0-f174.google.com with SMTP id x1so3920892lbj.3
        for <linux-mips@linux-mips.org>; Mon, 15 Feb 2016 10:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:organization:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jzUkj+GBMdsL9+AuI+LwTlfxFOCvKrpR62RGqBJZtls=;
        b=U1H0sS2J5shslXa9PQCj4FLK2Hfyd4OJOm7X0gINUtUSgI+V01GZ4p3VzaegId7vE9
         iAxxNlLHh/KILtqtLPbRpbN7Wd76EJfihj4XE94aZ2Vc+PHeugBObP9gVwPcjpFWtwZq
         Kgtmhrwbb6df/xJEdbZbMlWIb8NWlwajCfcbGaoXP341dAXZIfHIRz0PaLi4sI61FV9z
         Kdwz4sqarPda3/94VO2jq2XI0yPTbi6wBkyOyehbuFY5xY7Y4HNzbkPVAMl5iYHvEGI4
         YiIBWtI4MUjO1phzvFgkVcEMqi58EaQ2RNc8xLeOtd2nRHzAJPIZWIWerIHfuybD7aZB
         O7PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=jzUkj+GBMdsL9+AuI+LwTlfxFOCvKrpR62RGqBJZtls=;
        b=AUHQyMCee/whr31qeznY9d7XmtM28/a2Yjj0scfYL1nHbvuc/pyqg2ZXKhitExyyXl
         moVusCEvYZ8kO4+h7RyaMuBHAzJspdrICP2rM9yhCsYY7ZtLvAJNOzKe7vmV1OoK01GD
         Dw8CQG9Z5IAzfvJQxhUBNQDWBJ8a6QYtzqDGV89MXR6RhTwL50LFSiKHrEYHB0ff/TAl
         c0Wdkl/bQiICzcwPc9cs+A70baFz87Nh6h/fqZsF8JdhwAbmClFBYilt+paHtqECjGd/
         P0x+XLP/QXIj5UgCEspqeYJVIO5NAlYfVte8h+F6zZ76k+zlGp1MVgqLAkjFPA0WM08P
         kBoA==
X-Gm-Message-State: AG10YORRhhgoQiESTy/3bDS3UQJ4U904pUXfZmFy28U9YMVYLwm3e4Z1fcrWt2VwROXq8Q==
X-Received: by 10.112.199.197 with SMTP id jm5mr6041138lbc.109.1455559922770;
        Mon, 15 Feb 2016 10:12:02 -0800 (PST)
Received: from wasted.cogentembedded.com ([31.173.80.236])
        by smtp.gmail.com with ESMTPSA id f196sm2584210lfb.49.2016.02.15.10.11.59
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 15 Feb 2016 10:12:01 -0800 (PST)
Subject: Re: [PATCH 1/1] MIPS: DTS: cavium-octeon: provide model attribute
To:     Heinrich Schuchardt <xypron.glpk@gmx.de>,
        Arnd Bergmann <arnd@arndb.de>
References: <1455513977-934-1-git-send-email-xypron.glpk@gmx.de>
 <56C1B3A0.4090301@cogentembedded.com> <56C21054.4070702@gmx.de>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andrew Bresticker <abrestic@chromium.org>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
Message-ID: <56C214EE.5050200@cogentembedded.com>
Date:   Mon, 15 Feb 2016 21:11:58 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.5.0
MIME-Version: 1.0
In-Reply-To: <56C21054.4070702@gmx.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52067
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

On 02/15/2016 08:52 PM, Heinrich Schuchardt wrote:

>>> Downstream packages like Debian flash-kernel rely on
>>> /proc/device-tree/model
>>> to determine how to install an updated kernel image.
>>>
>>> Most dts files provide this property.
>>> It is suggested by IEEE Std 1275-1994.
>>>
>>> This patch adds a model attribute for Octeon CPUs.
>>>
>>> Signed-off-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>>> ---
>>>    arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts | 1 +
>>>    arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts | 1 +
>>>    2 files changed, 2 insertions(+)
>>>
>>> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>>> b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>>> index 9c48e05..a746678 100644
>>> --- a/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>>> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_3xxx.dts
>>> @@ -8,6 +8,7 @@
>>>     */
>>>    / {
>>>        compatible = "cavium,octeon-3860";
>>> +    model = "Cavium Octeon 3XXX";
>>>        #address-cells = <2>;
>>>        #size-cells = <2>;
>>>        interrupt-parent = <&ciu>;
>>> diff --git a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>>> b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>>> index 79b46fc..c8a292a 100644
>>> --- a/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>>> +++ b/arch/mips/boot/dts/cavium-octeon/octeon_68xx.dts
>>> @@ -8,6 +8,7 @@
>>>     */
>>>    / {
>>>        compatible = "cavium,octeon-6880";
>>> +    model = "Cavium Octeon 68XX";
>>>        #address-cells = <2>;
>>>        #size-cells = <2>;
>>>        interrupt-parent = <&ciu2>;
>>
>>      The ePAPR 1.1 standard says:
>>
>> 2.3.2 model
>>
>> Property: model
>> Value type: <string>
>> Description:
>>      The model property value is a <string> that specifies the
>>       manufacturer’s model number of the device.
>>
>>      The recommended format is: “manufacturer,model”, where manufacturer
>>      is a string describing the name of the manufacturer (such as a stock
>>      ticker symbol), and model specifies the model number.
>>
>> Example:
>>      model = “fsl,MPC8349EMITX”;
[...]

> Hello Sergei, hello Arnd,
>
> thank you for reviewing.
>
> IEEE Std 1275-1994 says stock symbols should be in upper case.
>
> I guess international standards should have precedence over papers valid
> for a single architecture (power.org).
>
> Would you support a patch having the following strings?
>
> model = "CAVM, Octeon 3860";
> model = "CAVM, Octeon 6880";
>
> Otherwise, please, make a suggestion.

    Documentation/devicetree/bindings/vendor-prefixes.txt already has the 
vendor prefix for Cavium, and it's (surprise!) "cavium".
    Otherwise, the names look much better -- just remove space after comma please.

> Best regards
>
> Heinrich Schuchardt

MBR, Sergei
