Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Mar 2018 12:36:12 +0100 (CET)
Received: from mail-ua0-x241.google.com ([IPv6:2607:f8b0:400c:c08::241]:34841
        "EHLO mail-ua0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990405AbeCJLgFGTAn- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 10 Mar 2018 12:36:05 +0100
Received: by mail-ua0-x241.google.com with SMTP id c40so3948099uae.2
        for <linux-mips@linux-mips.org>; Sat, 10 Mar 2018 03:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=P8ooc8j4348DmAaTuaK4NckA2ZnupFj/v+I1UsUwpmU=;
        b=p1cTHIdTQ4T0TfbwJQNFADCAA4enLXD/qIi6XVBtdbcwQck1cluTF3GOCVPFc9xN/1
         eaPOz5IdMUbIJd1HWMXZrBxuEkEVMp9PIMtyANpCp86IoxrHa5WSzb7zG6Reep04XAGE
         TmkudILr9cGsxaOaiRksEdOv1kkJ0mXF+q8T02CPnR4leyGdiICnibBHb0TnTUpHAJTs
         NYxDi5QIQjEzgxSaDlrkW2NUm8WzbKHSD+36LJh++iILFEZmgi3dOVxqeteJSSazOTLL
         b3NqQUNxuZZyE015mI6sT7zQaCgGvN6MdNkyuoXHyEWqneG1/M3htbM6TR3BLwJM7Uxw
         J87w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=P8ooc8j4348DmAaTuaK4NckA2ZnupFj/v+I1UsUwpmU=;
        b=EilD4G8kcoCV2fUQT1BLHQBBu3C6X2Jsh3++EPqS0HYNjvy1fuiAutoRUYvancSfj9
         kfv4BEGsbdi90NP4VFbcRPUMLNyp0FJwwBdY/hifUdTjvtAOmZg9/Yn5jvhnDdSmh7x5
         CvtOjiiO/s5qw2wYOF3AYt60HyQ20W9Rznt9KPj5LFan2TAjMhGxGXDSPnaTmI5shMbR
         TnXbBG15+PzWX1scG+mRk2O8jpLTSMjFcz4dCADTuOq9UNYpq27yU/NIcNERsait/hLn
         LgD+bUaZrkokjSULl8Onw8MJYN6lx+3IbDIYvdCmzXijepchvowTjy8FOxsuxT4VarB/
         WIZg==
X-Gm-Message-State: AElRT7GW/5b6H0JTGQB2mYHda6yW6KAg7VZYqX1BZNMn4Xa4jEnCTVUv
        n49KcIbpmimfyLcrYEHZadDUzIBz4uXEXX89rE0=
X-Google-Smtp-Source: AG47ELsltc7GWC8yFRf/uJZF26bs3GkdY7VTMlW+piCTv0cqZmL72b+oBjC2YFNcYORRu3o9Z7hirXiqmdCYlnvf97U=
X-Received: by 10.159.54.38 with SMTP id r35mr1074526uad.133.1520681758923;
 Sat, 10 Mar 2018 03:35:58 -0800 (PST)
MIME-Version: 1.0
Received: by 10.176.81.166 with HTTP; Sat, 10 Mar 2018 03:35:37 -0800 (PST)
In-Reply-To: <7a1695c0-45cf-e3d6-8524-8d2aeccc6490@mips.com>
References: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
 <87lgfcnkey.fsf@kamboji.qca.qualcomm.com> <c5929bb5-c50f-e73e-3117-fb0a862bb0fc@lwfinger.net>
 <7a1695c0-45cf-e3d6-8524-8d2aeccc6490@mips.com>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Sat, 10 Mar 2018 12:35:37 +0100
Message-ID: <CAOiHx=n7R35yfPZgGt9pq39y-jMYpH44eAGGSvNJ=sM5Rf5H3A@mail.gmail.com>
Subject: Re: [PATCH v2] bcma: Prevent build of PCI host features in module
To:     Matt Redfearn <matt.redfearn@mips.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-wireless@vger.kernel.org,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62901
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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

Hi,

On 8 March 2018 at 13:00, Matt Redfearn <matt.redfearn@mips.com> wrote:
> Hi,
>
>
> On 02/03/18 17:56, Larry Finger wrote:
>>
>> On 03/01/2018 04:45 AM, Kalle Valo wrote:
>>>
>>> Matt Redfearn <matt.redfearn@mips.com> writes:
>>>
>>>> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
>>>> a build error due to use of symbols not exported from vmlinux:
>>>>
>>>> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
>>>> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
>>>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>>>
>>>> To prevent this, don't allow the host mode feature to be built if
>>>> CONFIG_BCMA=m
>>>>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v2:
>>>> Rebase on v4.16-rc1
>>>>
>>>>   drivers/bcma/Kconfig | 2 +-
>>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
>>>> index ba8acca036df..cb0f1aad20b7 100644
>>>> --- a/drivers/bcma/Kconfig
>>>> +++ b/drivers/bcma/Kconfig
>>>> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>>>>   config BCMA_DRIVER_PCI_HOSTMODE
>>>>       bool "Driver for PCI core working in hostmode"
>>>> -    depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
>>>> +    depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY && BCMA =
>>>> y
>>>
>>>
>>> Due to the recent regression in bcma I would prefer extra careful review
>>> before I apply this. So does this look ok to everyone?
>>
>>
>> I have a preference for wireless device drivers to be modules. For that
>> reason, I would have submitted a patch exporting those two missing globals
>> rather than forcing bcma to be built in. That said, it seems that the patch
>> will do no further harm.
>
>
>
> This patch was purely intended to fix the build breakage caused by
> attempting to build host-mode PCI into a module, which fails due to
> necessary symbols not being exported by the kernel for use by modules.
>
> Making it possible to build the driver including host mode may not be as
> trivial as "lets just export the symbols", and testing that it works
> correctly once it can be built as a module will require hardware with this
> device present (which I don't have).
>
> So I would propose that this patch be merged as is, since as you say, it
> does no further harm - it should just fix build breakage - and if the
> driver, including this host mode feature, is really required as a module,
> perhaps someone with access to the hardware could spin a patch to implement
> that.


These aren't the actual wireless drivers, just the bus drivers. The
actual wireless drivers (b43 / brcmsmac) can still be built as a
module.

Also those systems that use/need the pci host driver of ssb/bcma
actually need ssb/bcma built-in anyway, as it also provides serial
console, interrupt routing, flash access, and other early init stuff.
At best one could rewrite the pci host core driver as a standalone
bcma driver, and then one could allow it to be built as a module. But
I'm not sure if it's worth it.


Regards
Jonas
