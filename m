Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Apr 2014 18:38:40 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:47181 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816906AbaDGQiaXSspv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Apr 2014 18:38:30 +0200
Received: by mail-pb0-f49.google.com with SMTP id jt11so6883890pbb.8
        for <multiple recipients>; Mon, 07 Apr 2014 09:38:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=yOQ3n/xfgB4cZTaahCYz1N08kb7+jNGJdETNAhrfSao=;
        b=LVqljXRB+Rra3wPsZP+E6GUhEmh7CyHJxW5/ojk0QwrciBr+9fOPRCM+cuoDrmsnWi
         DOXzILnAO8fE4PFJK6Lb1MaxoCGW2qYp4zhAk+rkVuPozfGqjcW812LYj/GL3kxLaNRR
         FNZKmNiHLIBLF/Bx7g/u/7MS6ytGbbt0VQ136x6eKgpAewIA3EufO7ZYYc2b8ouq3qWT
         ekPXwUCYL3aVUmndvFdkPhO8rXMzcrF1q0shhbQEkvgy6gmP2Y10UG2CcMIAyG9W4th1
         Id61zENU3MY9aQj3vKxY+Bs5nXwV3grBSVXiPnaI+xwwu0hHK/4MUBsb+lv7gKGRWh1X
         OLwg==
X-Received: by 10.68.143.34 with SMTP id sb2mr4043479pbb.135.1396888703496;
 Mon, 07 Apr 2014 09:38:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Mon, 7 Apr 2014 09:37:42 -0700 (PDT)
In-Reply-To: <20140407162857.GQ17197@linux-mips.org>
References: <1396868224-252888-1-git-send-email-manuel.lauss@gmail.com>
 <1396868224-252888-2-git-send-email-manuel.lauss@gmail.com>
 <20140407135315.GX14803@pburton-linux.le.imgtec.org> <20140407162857.GQ17197@linux-mips.org>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Mon, 7 Apr 2014 09:37:42 -0700
X-Google-Sender-Auth: hjWEu7kejYbk2SLAA0XbNzbDuxg
Message-ID: <CAGVrzcbV0sta4PyOoO+jMyOGc6rbT=hNjZTY_iDbi77ZjfUTfQ@mail.gmail.com>
Subject: Re: [RFC PATCH v4 2/2] MIPS: make FPU emulator optional
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Manuel Lauss <manuel.lauss@gmail.com>,
        Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39682
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014-04-07 9:28 GMT-07:00 Ralf Baechle <ralf@linux-mips.org>:
> On Mon, Apr 07, 2014 at 02:53:15PM +0100, Paul Burton wrote:
>
>> On Mon, Apr 07, 2014 at 12:57:04PM +0200, Manuel Lauss wrote:
>> > This small patch makes the MIPS FPU emulator optional. The kernel
>> > kills float-users on systems without a hardware FPU by sending a SIGILL.
>>
>> One issue with this is that if someone runs a kernel with the FPU
>> emulator disabled on hardware that has an FPU, they're likely to hit
>> seemingly odd behaviour where FP works just fine until they hit a
>> condition the hardware doesn't support. To make it clear that using FP
>> without the emulator is a bad idea, perhaps it would be safer to disable
>> FP entirely rather than only the emulator? Then userland can die the
>> first time it uses FP instead of when it happens to operate on a
>> denormal.
>>
>> Unless there are FPUs which never generate an unimplemented operation
>> exception, in which case perhaps more Kconfig is needed to identify such
>> systems & allow the emulator to be disabled for those only.
>
> The original reason for me to remove the FPU emulator option was that I
> was getting flooded by bogus bug reports because users thought they could
> remove the FPU emulator with a hardware FPU present.

We have had the same problems in OpenWrt, but we now output a big fat
warning to say "hey your kernel does not have FPU".

>
> Another pain point is that soft-FPU establishes another ABI variant so
> I'd not mind to see soft-FPU go.
>
> Some of the tradeoffs involved were a bit bogus at times.  Soft-fp
> application code can be much bigger than hard-fp - to the point where the
> 50k or so for the kernel FP software are a good investment.

There are some braindead bootloaders out there that will only allow
for a small kernel partition, while the rootfs partition can virtually
span the remainder of the available flash space... and all sorts of
crazy designs like these.

>
> But I don't mind making the FPU emulator selectable again - but this
> time with nasty kernel messages and killing of processes that happen to
> dare to execute a FPU instruction.

I think it is good to offer this as an option (hint: just like what
ARM does) along with the necessary warnings/messages to make sure that
bug filters can be easily filtered out.
-- 
Florian
