Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Mar 2015 17:29:20 +0100 (CET)
Received: from mail-qc0-f172.google.com ([209.85.216.172]:41557 "EHLO
        mail-qc0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007876AbbCBQ3Swu3KN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Mar 2015 17:29:18 +0100
Received: by qcvs11 with SMTP id s11so25422592qcv.8
        for <linux-mips@linux-mips.org>; Mon, 02 Mar 2015 08:29:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cghGAaNPN8Oldb938uIWqPbPjBg6oawE65XytDtJKq8=;
        b=g8NGdmdgS5G04eBboju3SmgapBVk/4W89Sb5WGFnG4WgUHD/umLsXMEL4FPPWrfLjW
         GORjYf5QunpbJI2bfwBpLVogx4isq+YWtUvF9AVfFqp6BehK9rJFEmKWVLZuIgAx91Q6
         fW4PVkuog1L4lJndSkJdRdbA1nTZXbHiBwP+G1rGuCrKHUM/Se4x/UKcRkF856GMSwbx
         qS6ZMHGNG/M4L3+BKEFZ8Nmesb4icxaeqkMqJRUs2tbm7YEUO01FMN6gODJ0Idf3CS7c
         gKU7cAjDuaGVyFx+vl+/FU2o9KEidaVad1YK0xZmcWKDicd7ULlPuv0Z8aCwM18Hrwyh
         mToA==
X-Received: by 10.140.234.17 with SMTP id f17mr54304497qhc.64.1425313753705;
 Mon, 02 Mar 2015 08:29:13 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.43.10 with HTTP; Mon, 2 Mar 2015 08:28:53 -0800 (PST)
In-Reply-To: <54F48B03.5040205@hurleysoftware.com>
References: <1416872182-6440-1-git-send-email-cernekee@gmail.com>
 <1416872182-6440-4-git-send-email-cernekee@gmail.com> <54F4624D.6000909@hurleysoftware.com>
 <CAJiQ=7DQ6CRWddii_9HZqH0a_1ixos6FBQRzb+HM+YAh1jmkBA@mail.gmail.com> <54F48B03.5040205@hurleysoftware.com>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Mon, 2 Mar 2015 08:28:53 -0800
Message-ID: <CAJiQ=7CKE5Nw=maewN_ChkySh1NReoUnddLO_ohOJQfwo_FXAg@mail.gmail.com>
Subject: Re: [PATCH V3 3/7] of: Document {little,big,native}-endian bindings
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Rob Herring <robh@kernel.org>,
        Grant Likely <grant.likely@linaro.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Arnd Bergmann <arnd@arndb.de>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46074
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

On Mon, Mar 2, 2015 at 8:08 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 03/02/2015 09:56 AM, Kevin Cernekee wrote:
>> On Mon, Mar 2, 2015 at 5:14 AM, Peter Hurley <peter@hurleysoftware.com> wrote:
>>> On 11/24/2014 06:36 PM, Kevin Cernekee wrote:
>>>> These apply to newly converted drivers, like serial8250/libahci/...
>>>> The examples were adapted from the regmap bindings document.
>>>>
>>>> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
>>>> ---
>>>>  .../devicetree/bindings/common-properties.txt      | 60 ++++++++++++++++++++++
>>>>  1 file changed, 60 insertions(+)
>>>>  create mode 100644 Documentation/devicetree/bindings/common-properties.txt
>>>>
>>>> diff --git a/Documentation/devicetree/bindings/common-properties.txt b/Documentation/devicetree/bindings/common-properties.txt
>>>> new file mode 100644
>>>> index 0000000..21044a4
>>>> --- /dev/null
>>>> +++ b/Documentation/devicetree/bindings/common-properties.txt
>>>> @@ -0,0 +1,60 @@
>>>> +Common properties
>>>> +
>>>> +The ePAPR specification does not define any properties related to hardware
>>>> +byteswapping, but endianness issues show up frequently in porting Linux to
>>>> +different machine types.  This document attempts to provide a consistent
>>>> +way of handling byteswapping across drivers.
>>>> +
>>>> +Optional properties:
>>>> + - big-endian: Boolean; force big endian register accesses
>>>> +   unconditionally (e.g. ioread32be/iowrite32be).  Use this if you
>>>> +   know the peripheral always needs to be accessed in BE mode.
>>>> + - little-endian: Boolean; force little endian register accesses
>>>> +   unconditionally (e.g. readl/writel).  Use this if you know the
>>>> +   peripheral always needs to be accessed in LE mode.  This is the
>>>> +   default.
>>>
>>> There is a fundamental problem with specifying the default in DT bindings.
>>> How can drivers which are currently native-endian support big-endian?
>>>
>>> If the driver is converted to support big-endian, every previous
>>> devicetree will be invalid with the new kernel (because those devicetrees
>>> don't specify 'native-endian').
>>>
>>> IOW, consider if the default were 'native-endian'. How would the 8250
>>> driver support existing devicetrees?
>>
>> Correct.  This scheme is intended for drivers like 8250 and libahci
>> which currently default to little-endian by virtue of using
>> readl/writel for MMIO accesses.  Drivers that default to native-endian
>> should specify that in their bindings documents, similar to
>> Documentation/devicetree/bindings/regmap/regmap.txt.
>
> Which effectively means if a user can't upgrade their devicetree, they
> can't upgrade their kernel. I don't think that flies.

This doesn't change the behavior of pre-existing drivers that
implement the *-endian properties in a different way.  There are not
many of these drivers and they can be documented as special cases.

> It's exactly this kind of stuff that prompted Jonathan Corbet's article,
> "Device trees as ABI"  http://lwn.net/Articles/561462
>
> Why not leave the default unspecified?

The document aims to provide a consistent way of handling DT
endianness properties across (compliant) drivers.  It is confusing if
one new driver defaults to little-endian, and another new driver
defaults to native-endian.

And since most of the commonly used drivers already implement
little-endian MMIO accesses, that is the default.  My personal
preference would have been native-endian since that seems more common
on the hardware side, but defaulting to little-endian prevents
breaking the device tree "ABI" on existing systems.
