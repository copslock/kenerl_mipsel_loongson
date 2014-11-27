Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2014 12:10:53 +0100 (CET)
Received: from mail-lb0-f181.google.com ([209.85.217.181]:36984 "EHLO
        mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007356AbaK0LKwDx-8V (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2014 12:10:52 +0100
Received: by mail-lb0-f181.google.com with SMTP id 10so3873728lbg.40
        for <linux-mips@linux-mips.org>; Thu, 27 Nov 2014 03:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=Mc6JXMfuOJUOcrW15H0lQ2gTTUCiawE8cXE9w85x22Q=;
        b=BETEG8A/G3j+yrcthnhD29fC5iB79dsLKHtSoen2mg/vj17DA/jO0sH6Cb+ja3wlIf
         yxMATphrwxbpkGfHju2ALQOKKGQzM6NMSPV+NI42GBs+wDO1Jkz3Jk1ZFYhbVO0g6YkY
         hwighdvySU46kVbDPZrpftvNtDQz8AWYNZbxrO5oUNWups0fXFQql+srOmt4L5bhYZNk
         G0cJ18OYVnVg4TreN3PmXEG/1BwPvgzePiCjNaTAF+oAvqOLZOSMgs5XOfqwYCFCWM7y
         SYMNkG0hzvxpaNSHA59o54l5TZwOV9aVoTJhIaKsOs7NV5uEzIM9XuqnpLxotSNamkWo
         pYNw==
MIME-Version: 1.0
X-Received: by 10.152.205.11 with SMTP id lc11mr38667951lac.34.1417086646541;
 Thu, 27 Nov 2014 03:10:46 -0800 (PST)
Received: by 10.152.106.178 with HTTP; Thu, 27 Nov 2014 03:10:46 -0800 (PST)
In-Reply-To: <5475E4EC.7090309@hurleysoftware.com>
References: <1415825647-6024-1-git-send-email-cernekee@gmail.com>
        <1415825647-6024-2-git-send-email-cernekee@gmail.com>
        <20141125203431.GA9385@kroah.com>
        <CAJiQ=7DOxK2NzmC9gGsnARxGMN8wRQyGX+5u5YC_vt00ADVsDg@mail.gmail.com>
        <20141126133306.659E9C4099B@trevor.secretlab.ca>
        <5475E4EC.7090309@hurleysoftware.com>
Date:   Thu, 27 Nov 2014 12:10:46 +0100
X-Google-Sender-Auth: NPDlHFwxCMNFeUj9w5zEC7DZVxY
Message-ID: <CAMuHMdV7Uo7JBAXDa6z8R+9v7HaDYQ=QpKf8FMBqvmt372oSsA@mail.gmail.com>
Subject: Re: [PATCH V2 01/10] tty: Fallback to use dynamic major number
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Peter Hurley <peter@hurleysoftware.com>
Cc:     Grant Likely <grant.likely@linaro.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>, Rob Herring <robh@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, daniel@zonque.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        tushar.b@samsung.com
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Nov 26, 2014 at 3:34 PM, Peter Hurley <peter@hurleysoftware.com> wrote:
> On 11/26/2014 08:33 AM, Grant Likely wrote:
>> On Tue, 25 Nov 2014 15:37:16 -0800
>> , Kevin Cernekee <cernekee@gmail.com>
>>  wrote:
>>> On Tue, Nov 25, 2014 at 12:34 PM, Greg KH <gregkh@linuxfoundation.org> wrote:
>>>> On Wed, Nov 12, 2014 at 12:53:58PM -0800, Kevin Cernekee wrote:
>>>>> From: Tushar Behera <tushar.behera@linaro.org>
>>>>
>>>> This email bounces, so I'm going to have to reject this patch.  I can't
>>>> accept a patch from a "fake" person, let alone something that touches
>>>> core code like this.
>>>>
>>>> Sorry, I can't accept anything in this series then.
>>>
>>> Oops, guess I probably should have updated his address after the V1
>>> emails bounced...
>>>
>>> Before I send a new version, what do you think about the overall
>>> approach?  Should we try to make serial8250 coexist with the other
>>> "ttyS / major 4 / minor 64" drivers (possibly at the expense of
>>> compatibility) or is it better to start with a simpler, cleaner driver
>>> like serial/pxa?
>>
>> Co-existing really needs to be fixed.
>
> What are the requirements for co-existence?
> Is it sufficient to provide 1st come-1st served minor allocation?
>
> Anything done should be designed to solve this name problem forever,
> not some expeditious band-aid.

+1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
