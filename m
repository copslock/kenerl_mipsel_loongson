Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 17:08:52 +0100 (CET)
Received: from mail-qg0-f53.google.com ([209.85.192.53]:38951 "EHLO
        mail-qg0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006759AbbCBQIuUhXfv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 17:08:50 +0100
Received: by mail-qg0-f53.google.com with SMTP id j5so4404486qga.12
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 08:08:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=qFy5FGmMhlKWrO9nCTe2fLHOJDE6fLBI7zC93KRZdbc=;
        b=AJG+A/azuH/Yu9PSq2LW4SyYSnQWXlmRdhptPKRw17utoflEc+sPA7oO65oJSKupro
         wUglwepWtwKeGx5nmnI+635qDgwq9+UfgvNVMtoNzSjmYBDVjmmrzsn1JZZNGVZpDEzY
         uM2RhqS/gpWhtpkbr/JcAgZ9VO2iAyXbFMgvfEzDLEKLTxB+OZGxBkHWigymggfnyty9
         +LzGqIzuhncoAREjd7kFpGvjue+jYiX6OKwa1+g6PwKNnca+0jgaMu97p6/UNFmqX3bU
         b0H1AL8s2uAKzunwe4zY4tSnXhYr+r7tqd29wagYe59N2uVxHToDKacHq+W7tPoZ3gG/
         FHEA==
X-Gm-Message-State: ALoCoQlvDjjvmdE6HdFkJrCgRyIDO3uvtA42ek9viZGlZj1PUjpSgiB/he5hN+7AfUAClKPFSl+2
X-Received: by 10.229.111.197 with SMTP id t5mr20697811qcp.18.1425312524516;
        Mon, 02 Mar 2015 08:08:44 -0800 (PST)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id b74sm8596989qga.40.2015.03.02.08.08.43
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 08:08:43 -0800 (PST)
Message-ID: <54F48B03.5040205@hurleysoftware.com>
Date:   Mon, 02 Mar 2015 11:08:35 -0500
From:   Peter Hurley <peter@hurleysoftware.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     Kevin Cernekee <cernekee@gmail.com>
CC:     Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com> <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
In-Reply-To: <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: peter@hurleysoftware.com
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

On 03/02/2015 09:56 AM, Kevin Cernekee wrote:
> On Mon, Mar 2, 2015 at 5:14 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>> These apply to newly converted drivers, like serial8250/libahci/...
>>> The examples were adapted from the regmap bindings document.
>>>
>>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>> ---
>>>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>>>  1 file changed, 60 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
>>> new file mode 100644
>>> index 0000000..21044a4
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/common-properties.txt
>>> @@ -0,0 +1,60 @@
>>> +Common properties
>>> +
>>> +The ePAPR specification does not define any properties related to hardware
>>> +byteswapping, but endianness issues show up frequently in porting Linux to
>>> +different machine types.  This document attempts to provide a consistent
>>> +way of handling byteswapping across drivers.
>>> +
>>> +Optional properties:
>>> + - big-endian: Boolean; force big endian register accesses
>>> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
>>> +   know the peripheral always needs to be accessed in BE mode.
>>> + - little-endian: Boolean; force little endian register accesses
>>> +   unconditionally (e.g. readl/writel).  Use this if you know the
>>> +   peripheral always needs to be accessed in LE mode.  This is the
>>> +   default.
>>
>> There is a fundamental problem with specifying the default in DT bindings.
>> How can drivers which are currently native-endian support big-endian?
>>
>> If the driver is converted to support big-endian, every previous
>> devicetree will be invalid with the new kernel (because those devicetrees
>> don't specify 'native-endian').
>>
>> IOW, consider if the default were 'native-endian'. How would the 8250
>> driver support existing devicetrees?
> 
> Correct.  This scheme is intended for drivers like 8250 and libahci
> which currently default to little-endian by virtue of using
> readl/writel for MMIO accesses.  Drivers that default to native-endian
> should specify that in their bindings documents, similar to
> Documentation/devicetree/bindings/regmap/regmap.txt.

Which effectively means if a user can't upgrade their devicetree, they
can't upgrade their kernel. I don't think that flies.

It's exactly this kind of stuff that prompted Jonathan Corbet's article,
"Device trees as ABI"  http://lwn.net/Articles/561462

Why not leave the default unspecified?

Regards,
Peter Hurley

> In practice we might not see too many cases of native-endian drivers
> that need to be converted to work in forced big-endian mode anyway,
> because most uses of the __raw_* accessors are found in SoC-specific
> code.
