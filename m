Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2018 12:59:40 +0200 (CEST)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:39203
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994553AbeFRK7cWc8nC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 18 Jun 2018 12:59:32 +0200
Received: by mail-lf0-x243.google.com with SMTP id t2-v6so17546638lfd.6;
        Mon, 18 Jun 2018 03:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=RqspwjyWW5d1MpGjILadsGerXh6vodVcZI2gsZCaqdo=;
        b=pCJlympPtgSmJqm4YVSEE05siiWyCLgTvJwL6m72jitgjwbMQ4+dag49K7BszhixYi
         0T3leTIMjcXy0DN7Y5svJJyOjUBCKh66Tc+Zk0eqRG2AgTRuWR3c6vjtaZnfhRLTOQqN
         BO5zXdkGdydQdeMW7oryULbojFFLulpNmzZezENasb9DKk88NEjiiXnhrUbMY2IDD0A1
         Zw2H8KJTjpuVd6NWUg7z59irfJtQ0Y1uNRCJ1+7P/hQv/SS9LGWxkfVuw+jogcdtqSjO
         ed1gWp4fgeGhObcAT8E63RvS3ToYpOMnnxoMPTxONnY4CsXei+BbdlSMJ+wdLkm6TJDm
         op8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=RqspwjyWW5d1MpGjILadsGerXh6vodVcZI2gsZCaqdo=;
        b=M0vOiEr/50Pn4HtHjXtW9YnSjHOet7ijg8RbkHX6l9r5q7wBSwyuOV6TTO74YRvypq
         N6tiwzI0uvkCRb22nx0v0jcMVHy35ozAJHKNI+5vErUyV0i60fh/uNh79rjGqOBnsDZP
         EeGsFtMfDEsvL+4EBZU4l3SVFRulKFMVwY4QoCBhdreAfMSw89c7XqRibJTz5Jaahazo
         WqvfRvzXXQyCzMNZWMv++SKYeXHmNoTPZsfJYjwdIIzD1+SdMVDsLMl9tmmcXSSXYH3u
         XBJt/fDbdKa0TcAP1KXxtc5I+fcq7Lx/gOuS0+eZP5nVf0uB46gTie0I86PyYCnhk00s
         DZTA==
X-Gm-Message-State: APt69E0d2lQGNPI4OeSmzBVXdtL+FRZJa6a1pXKDot1XUMd5uz0lqkEk
        nCsWQjufQyuOpydOvi2i2nYxpd2A9LNeg9Gtolk=
X-Google-Smtp-Source: ADUXVKJMgXWeh9+X3zdwaoqccLsssoMFt3j5Ctj5FUgJ+S8iT4cxXMrzFCdABOQeiAxdDbuXFhWUd8ONOdKjMqYKfaA=
X-Received: by 2002:a2e:40d9:: with SMTP id r86-v6mr7852423lje.19.1529319565609;
 Mon, 18 Jun 2018 03:59:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a2e:56c8:0:0:0:0:0 with HTTP; Mon, 18 Jun 2018 03:59:24
 -0700 (PDT)
In-Reply-To: <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
References: <20180612054034.4969-1-songjun.wu@linux.intel.com>
 <20180612054034.4969-2-songjun.wu@linux.intel.com> <CAK8P3a1=CBahrEE2uDRfdrSi=ALc5LBED1=KbLbLa40c9H8dmQ@mail.gmail.com>
 <539411c1-82b7-cf76-71cf-d50f3303f50f@linux.intel.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 18 Jun 2018 12:59:24 +0200
X-Google-Sender-Auth: gu4KI2rTFfqxs5zpg0x6cE7uD9o
Message-ID: <CAK8P3a0WVxHU98zjY6d8jN0bDtwabFkrbcxr3a7xRkxSjD2ZLg@mail.gmail.com>
Subject: Re: [PATCH 1/7] MIPS: dts: Add aliases node for lantiq danube serial
To:     "Wu, Songjun" <songjun.wu@linux.intel.com>
Cc:     hua.ma@linux.intel.com, yixin.zhu@linux.intel.com,
        chuanhua.lei@intel.com,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        qi-ming.wu@intel.com, linux-clk <linux-clk@vger.kernel.org>,
        linux-serial@vger.kernel.org, DTML <devicetree@vger.kernel.org>,
        James Hogan <jhogan@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Rob Herring <robh+dt@kernel.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Mon, Jun 18, 2018 at 11:42 AM, Wu, Songjun
<songjun.wu@linux.intel.com> wrote:
> On 6/14/2018 6:03 PM, Arnd Bergmann wrote:
>>
>> On Tue, Jun 12, 2018 at 7:40 AM, Songjun Wu <songjun.wu@linux.intel.com>
>> wrote:
>>>
>>> Previous implementation uses a hard-coded register value to check if
>>> the current serial entity is the console entity.
>>> Now the lantiq serial driver uses the aliases for the index of the
>>> serial port.
>>> The lantiq danube serial dts are updated with aliases to support this.
>>>
>>> Signed-off-by: Songjun Wu <songjun.wu@linux.intel.com>
>>> ---
>>>
>>>   arch/mips/boot/dts/lantiq/danube.dtsi | 6 +++++-
>>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> index 2dd950181f8a..7a9e15da6bd0 100644
>>> --- a/arch/mips/boot/dts/lantiq/danube.dtsi
>>> +++ b/arch/mips/boot/dts/lantiq/danube.dtsi
>>> @@ -4,6 +4,10 @@
>>>          #size-cells = <1>;
>>>          compatible = "lantiq,xway", "lantiq,danube";
>>>
>>> +       aliases {
>>> +               serial0 = &asc1;
>>> +       };
>>> +
>>
>> You generally want the aliases to be part of the board specific file,
>> not every board numbers their serial ports in the same way.
>>
>
> In this chip only asc1 can be used as console,  so serial0 is defined in
> chip specific file.

This was a more general comment about 'aliases' being board specific
in principle (though we've had exceptions in the past). Even if there
is only one uart on the chip, I'd recommend following the same
conventions as the other chips that have more than one uart.

       Arnd
