Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Nov 2014 10:04:35 +0100 (CET)
Received: from mail-qa0-f46.google.com ([209.85.216.46]:62386 "EHLO
        mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013493AbaKLJEehJ8y- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Nov 2014 10:04:34 +0100
Received: by mail-qa0-f46.google.com with SMTP id n8so8104924qaq.5
        for <linux-mips@linux-mips.org>; Wed, 12 Nov 2014 01:04:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OJ0cPatBC6yXa3L5jAGfBz8wB828pI5aPiBrjdj+Qd8=;
        b=OEKykpo12xMP7IDA/1nOb2V/aiZ4R56JPjqw8RKyGVs19NnvxFicc0YFcRABPvBNx2
         ttYTRr3w7YGHKoYFSLXoLn/rFgAixHzrUCwTRCO5qxJ1c0WWFTxSc54K3+eLTzZPO7SE
         JqEVrEnLA5oiLzKoJrW7T2lDDP+jAAcKvkJ8A3Ki15pE0dkNE0kO3stfE98gxWgJNrKG
         nfLSritVBhsCcBFi1C+c6btLKwy1idPOzM24V7pI6NGIvrJqpCVZxq2Ax/u4uzfRB3dX
         P6nkGz2smiA3bZqVY2BUnIhEcZJ50UqfuE64Ww7qsiI4a2nyIMVlHM6MdkbIvyZzGrgV
         6p0w==
X-Received: by 10.140.48.11 with SMTP id n11mr32906541qga.1.1415783068849;
 Wed, 12 Nov 2014 01:04:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.140.89.113 with HTTP; Wed, 12 Nov 2014 01:04:08 -0800 (PST)
In-Reply-To: <54631F64.8080009@suse.cz>
References: <1415781993-7755-1-git-send-email-cernekee@gmail.com>
 <1415781993-7755-4-git-send-email-cernekee@gmail.com> <54631F64.8080009@suse.cz>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Wed, 12 Nov 2014 01:04:08 -0800
Message-ID: <CAJiQ=7ADy1U60R-o1soMyqYWXqw2OqQg7vfB9L5pzeac+Yv=SA@mail.gmail.com>
Subject: Re: [PATCH/RFC 3/8] of: Add helper function to check MMIO register endianness
To:     Jiri Slaby <jslaby@suse.cz>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Rob Herring <robh@kernel.org>, tushar.behera@linaro.org,
        daniel@zonque.org, haojian.zhuang@gmail.com,
        robert.jarzmik@free.fr, Grant Likely <grant.likely@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44040
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

On Wed, Nov 12, 2014 at 12:50 AM, Jiri Slaby <jslaby@suse.cz> wrote:
>>  /**
>> + *  of_device_is_big_endian - check if a device has BE registers
>> + *
>> + *  @device: Node to check for availability

Oops, just noticed a copy/paste error here.

>> + *
>> + *  Returns 1 if the device has a "big-endian" property, or if the kernel
>> + *  was compiled for BE *and* the device has a "native-endian" property.
>> + *  Returns 0 otherwise.
>> + *
>> + *  Callers would nominally use ioread32be/iowrite32be if
>> + *  of_device_is_big_endian() == 1, or readl/writel otherwise.
>> + */
>> +int of_device_is_big_endian(const struct device_node *device)
>> +{
>> +     if (of_property_read_bool(device, "big-endian"))
>> +             return 1;
>> +     if (IS_ENABLED(CONFIG_CPU_BIG_ENDIAN) &&
>> +         of_property_read_bool(device, "native-endian"))
>> +             return 1;
>> +     return 0;
>> +}
>
> This should actually return bool and use true/false.

Well, the other APIs currently return an int:

extern int of_device_is_compatible(const struct device_node *device,
                                   const char *);
extern int of_device_is_available(const struct device_node *device);
[...]
extern int of_machine_is_compatible(const char *compat);

Do you think it is best to change all of them at once, or just the
newly introduced function?
