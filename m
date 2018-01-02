Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jan 2018 17:18:07 +0100 (CET)
Received: from mail-it0-x242.google.com ([IPv6:2607:f8b0:4001:c0b::242]:36702
        "EHLO mail-it0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeABQR7iJTN1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jan 2018 17:17:59 +0100
Received: by mail-it0-x242.google.com with SMTP id d16so39882283itj.1;
        Tue, 02 Jan 2018 08:17:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=ItTZOdFoQgr9KKDIcJSBYFBfNSbE+/oI/Ovh2qkJslM=;
        b=u1HIJIys+1vDKKY++8RHMHiXiE5ayMa4QopQhW7ZtCbVoJpMUEhr3uxbeovczG1tR4
         RCcgZl0VxX4eYbpaQ79GYIKqwXI3p3MJ1r8RGKWyZo0+7+bbMGI/nd4oaH2pqW1MC2CF
         DGiZBJgBjVcIe1SznKnHKivw+Z/AZK6/tm2kZI9JVS+q6XyKUc6lwXhTr59Qxp91rNhT
         r0eZM4WoMnKhM5AJrq7Lt8lawxckvbtrRVxLrdeFDEoT+xEek8W3TSW+J9nIoOF5Q4hb
         9QpZVSd1A7t41dei4g1bh3WzFGa78mufhepFsbwB/q/GXynbGkilDbWZvMQorfCjIZZZ
         aOsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=ItTZOdFoQgr9KKDIcJSBYFBfNSbE+/oI/Ovh2qkJslM=;
        b=EdBnzqO6P2eInLw22HgloHA1tgEE1/m0H95khCfk0nWton/RQHfW/s0ORyslNlENfo
         ssn4Ik8F+Oz+eitYT+DyoTlvUfWHa0MLogMK0zEdbWCkLz7k97XSsCIx7C7np7S85wuu
         PFz+4AnEfyHV7VKkmI3NsW1bkMj1CnTnog1+YQgy1zxZ9A+cG7IlMKDLFXslp3hv7XRE
         ZKaIpJbSHSdElNo1sPUcyT5/s1JaPCgSQvUSXzjvMei1Np+/Smlk34uwwxW7JONFj7bA
         Vc0iWqgv/lEfFD7cEhD1ctdbdQfYY0+HFi6FsiREF1sBlcirsAREUbj/GhXXFNeASarL
         g82A==
X-Gm-Message-State: AKGB3mKiWRb3WdfVHq/hLKLxE+1CpnaWKJx0clwQqPv16d0lCOD3JpWm
        6cIe0c2E9evbiRCjGj/Xx9maUcA+vTwvd62kaFVYydVO
X-Google-Smtp-Source: ACJfBovQv8P9l3WoIqlZPK7uVoJ0RCLsxYW0Q5bS+7s8R76ZEBt1IdIuTcHudtXxrE2kS3qEVQNMogNEYf9qeoUMoxQ=
X-Received: by 10.36.236.4 with SMTP id g4mr46700508ith.33.1514909873497; Tue,
 02 Jan 2018 08:17:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.144.208 with HTTP; Tue, 2 Jan 2018 08:17:53 -0800 (PST)
In-Reply-To: <3ec9ddab-f855-8c39-4d75-d35be7bd6731@linaro.org>
References: <20171228212954.2922-1-malat@debian.org> <20171228212954.2922-2-malat@debian.org>
 <3ec9ddab-f855-8c39-4d75-d35be7bd6731@linaro.org>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Tue, 2 Jan 2018 21:47:53 +0530
Message-ID: <CANc+2y7_Bx7APkD2pDEQUT9cJqXEUCPkDQuzO_GP1qENabnNeQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] nvmem: add driver for JZ4780 efuse
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Mathieu Malaterre <malat@debian.org>,
        Marcin Nowakowski <marcin.nowakowski@mips.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Zubair.Kakakhel@mips.com, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        open list <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61850
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Srini,

On 2 January 2018 at 17:32, Srinivas Kandagatla
<srinivas.kandagatla@linaro.org> wrote:
>
>
> On 28/12/17 21:29, Mathieu Malaterre wrote:
>>
>> From: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>>
>> This patch brings support for the JZ4780 efuse. Currently it only expose
>> a read only access to the entire 8K bits efuse memory.
>>
>> Tested-by: Mathieu Malaterre <malat@debian.org>
>> Signed-off-by: PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
>> Signed-off-by: Mathieu Malaterre <malat@debian.org>
>> ---
>
> Please split this patch, as you are mixing code, documentation, dts and
> MAINTAINER changes here.
>
> Without which patch can not be reviewed!!

Sure, will do it soon.

>
> Thanks,
> Srini
>
>>   .../ABI/testing/sysfs-driver-jz4780-efuse          |  16 ++
>
>
>>   .../bindings/nvmem/ingenic,jz4780-efuse.txt        |  17 ++
>>   MAINTAINERS                                        |   5 +
>>   arch/mips/boot/dts/ingenic/jz4780.dtsi             |  40 ++-
>>   drivers/nvmem/Kconfig                              |  10 +
>>   drivers/nvmem/Makefile                             |   2 +
>>   drivers/nvmem/jz4780-efuse.c                       | 305
>> +++++++++++++++++++++
>>   7 files changed, 383 insertions(+), 12 deletions(-)
>
> ...

Regards,
PrasannaKumar
