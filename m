Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 18:45:43 +0100 (CET)
Received: from mail-qc0-f175.google.com ([209.85.216.175]:42295 "EHLO
        mail-qc0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007876AbbCBRplM47VW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 18:45:41 +0100
Received: by qcvp6 with SMTP id p6so25926703qcv.9
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 09:45:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=JZaftKOX72yaw7NY7+EaHBBjCWiMS8gn8e8WkhIqTLo=;
        b=eVa1uK6TGRKNqG4kc8pri5/EbixvO6JC88WiUDAH6mqwEaCAjpyycWv7d3fIlbdQnx
         AbSwCAyycTeT7CD26yK55qW9FDwaRRqVx8V0dgv6W4+hs7DKcGmCVymXa2pdou+7K9ND
         fwveuk0HpabSs3zgTbq1oZOqhw5wqSRLZVszhVMrtIQjM25NZ/g3UfEBXU8bjtXsGC0B
         9lgupRzb5twiCd0NEkxUWCoUfbNVWDNa54Vhtnbe7EIKL5hK77Ggcp6phfWohD0KZhXB
         nODDHokhmjCG8ahTkB79R+Vm8rfeltoN0jgv07t6T6Uch8IvnYOhSYzVps0eyY1m9Hxc
         l8XQ==
X-Gm-Message-State: ALoCoQnGokNUBW2Yp1WC8DocaXm0kWd02yGCbg3CjIsTwN2G7tRvbkkRO2s2EDrHaCvsfCpy3dGi
X-Received: by 10.140.131.19 with SMTP id 19mr53512098qhd.20.1425318335772;
        Mon, 02 Mar 2015 09:45:35 -0800 (PST)
Received: from [192.168.1.139] (h96-61-87-245.cntcnh.dsl.dynamic.tds.net. [96.61.87.245])
        by mx.google.com with ESMTPSA id 7sm8767994qhv.44.2015.03.02.09.45.34
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2015 09:45:35 -0800 (PST)
Message-ID: <54F4A1B6.8030701@hurleysoftware.com>
Date:   Mon, 02 Mar 2015 12:45:26 -0500
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
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com> <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com> <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com> <54F48B03.5040205@hurleysoftware.com> <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
In-Reply-To: <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <peter@hurleysoftware.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46075
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

On 03/02/2015 11:28 AM, Kevin Cernekee wrote:
> On Mon, Mar 2, 2015 at 8:08 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>> On 03/02/2015 09:56 AM, Kevin Cernekee wrote:
>>> On Mon, Mar 2, 2015 at 5:14 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>>>> These apply to newly converted drivers, like serial8250/libahci/...
>>>>> The examples were adapted from the regmap bindings document.
>>>>>
>>>>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>>>> ---
>>>>>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>>>>>  1 file changed, 60 insertions(+)
>>>>>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
>>>>>
>>>>> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
>>>>> new file mode 100644
>>>>> index 0000000..21044a4
>>>>> --- /dev/null
>>>>> +++ b/Documentation/devicetree/bindings/common-properties.txt
>>>>> @@ -0,0 +1,60 @@
>>>>> +Common properties
>>>>> +
>>>>> +The ePAPR specification does not define any properties related to hardware
>>>>> +byteswapping, but endianness issues show up frequently in porting Linux to
>>>>> +different machine types.  This document attempts to provide a consistent
>>>>> +way of handling byteswapping across drivers.
>>>>> +
>>>>> +Optional properties:
>>>>> + - big-endian: Boolean; force big endian register accesses
>>>>> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
>>>>> +   know the peripheral always needs to be accessed in BE mode.
>>>>> + - little-endian: Boolean; force little endian register accesses
>>>>> +   unconditionally (e.g. readl/writel).  Use this if you know the
>>>>> +   peripheral always needs to be accessed in LE mode.  This is the
>>>>> +   default.
>>>>
>>>> There is a fundamental problem with specifying the default in DT bindings.
>>>> How can drivers which are currently native-endian support big-endian?
>>>>
>>>> If the driver is converted to support big-endian, every previous
>>>> devicetree will be invalid with the new kernel (because those devicetrees
>>>> don't specify 'native-endian').
>>>>
>>>> IOW, consider if the default were 'native-endian'. How would the 8250
>>>> driver support existing devicetrees?
>>>
>>> Correct.  This scheme is intended for drivers like 8250 and libahci
>>> which currently default to little-endian by virtue of using
>>> readl/writel for MMIO accesses.  Drivers that default to native-endian
>>> should specify that in their bindings documents, similar to
>>> Documentation/devicetree/bindings/regmap/regmap.txt.
>>
>> Which effectively means if a user can't upgrade their devicetree, they
>> can't upgrade their kernel. I don't think that flies.
> 
> This doesn't change the behavior of pre-existing drivers that
> implement the *-endian properties in a different way.  There are not
> many of these drivers and they can be documented as special cases.

Yeah, ok, as long as there's no expectation that existing drivers
meet this criteria when they add big-endian support.

>> It's exactly this kind of stuff that prompted Jonathan Corbet's article,
>> "Device trees as ABI"  http://lwn.net/Articles/561462
>>
>> Why not leave the default unspecified?
> 
> The document aims to provide a consistent way of handling DT
> endianness properties across (compliant) drivers.  It is confusing if
> one new driver defaults to little-endian, and another new driver
> defaults to native-endian.

Ok. How many 4.0 driver + DT submissions that are native-endian are
declaring this binding?


> And since most of the commonly used drivers already implement
> little-endian MMIO accesses, that is the default.  My personal
> preference would have been native-endian since that seems more common
> on the hardware side, but defaulting to little-endian prevents
> breaking the device tree "ABI" on existing systems.

That was basically my point; there's no way to meet these goals
for existing, native-endian drivers without breakage (just as there
would have been no way if native-endian had been the default).

Regards,
Peter Hurley
