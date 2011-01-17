Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 14:43:38 +0100 (CET)
Received: from mail-qy0-f177.google.com ([209.85.216.177]:59934 "EHLO
        mail-qy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493447Ab1AQNne convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 14:43:34 +0100
Received: by qyk27 with SMTP id 27so6095992qyk.15
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 05:43:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=5lt5CBfoXTfE2RnB4NDOHD+ItNyzucFG4Ie6OPKJDqM=;
        b=yB7Av4LUYdaAmG3c8RrI3QeXIDC8U+e6RAqPu/fd+iVOO2QIb9FXQnVoYfz0Nu444b
         FysV9xQfIxZgTUiqE/yIHEKzsMVIOCxaXO0GU246jG+N/RS3tBQuMtqyyZxPNmyYrzp0
         0ZgBGLldHMNjMNphhvAl5O+zrOYAKr8dw1dT4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=Igbq6KvBWejgQp5SEyRwA3R5w4nuV6Z/zDJRYNu94fC1dwifMOoa53v+dgV0boZYF9
         NESudjFi81EJ1eLT1bQUJYZxMgP5gZp2YVFPOFNsIfeKiRBQpXC6S5imR+TeOis4IRUm
         MaYlxnicfatviaXlA9HUpDcat8biSbnSqaZco=
Received: by 10.229.188.68 with SMTP id cz4mr3589732qcb.261.1295271808179;
 Mon, 17 Jan 2011 05:43:28 -0800 (PST)
MIME-Version: 1.0
Received: by 10.229.39.9 with HTTP; Mon, 17 Jan 2011 05:43:08 -0800 (PST)
In-Reply-To: <1295265468.24530.23.camel@maggie>
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
 <1295261783.24530.3.camel@maggie> <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com>
 <1295265468.24530.23.camel@maggie>
From:   Jonas Gorski <jonas.gorski@gmail.com>
Date:   Mon, 17 Jan 2011 14:43:08 +0100
Message-ID: <AANLkTims0DPfG+u9qynuuj_-0WjUr1nAGLuFz3k706T-@mail.gmail.com>
Subject: Re: Merging SSB and HND/AI support
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28936
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
Precedence: bulk
X-list: linux-mips

On 17 January 2011 12:57, Michael Büsch <mb@bu3sch.de> wrote:
> Well... I don't really like the idea of running one driver and
> subsystem implementation on completely distinct types of silicon.
> We will end up with the same mess that broadcom ended up with in
> their "SB" code (broadcom's SSB backplane implementation).
> For example, in their code the driver calls pci_enable_device() and
> related PCI functions, even if there is no PCI device at all. The calls
> are magically re-routed to the actual SB backplane.
> You'd have to do the same mess with SSB. Calling ssb_device_enable()
> will mean "enable the SSB device", if the backplane is SSB, and will
> mean "enable the HND/AI" device, if the backplane is HND/AI.

It didn't strike me as that bad, but I also didn't look at any PCI code.

> So I'm still in favor of doing a separate HND/AI bus implementation,
> even if
> that means duplicating a few lines of code.

Well, it means at least duplicating most of the chipcommon driver and
the mips core driver. But if you are fine with that, I see no problem
with having a separate driver for the AI bus.

> SSB doesn't search for SSB busses in the system, because there's no
> way to do so. The architecture (or the PCI/PCMCIA/SDIO device) registers
> the bus,
> if it detected an SSB device. So for the embedded case, it's hardcoded
> in the arch code. For the PCI case it simply depends on the PCI IDs.
> I don't see a problem here. Your arch code will already have to know
> what machine it is running on. So it will have to decide whether to
> register a SSB or HND/AI bus.

Okay. This is mostly for the embedded case, where it is possible to
create a single kernel that boots on both. The "detection" could also
be done through the cpu type (74k => register AI bus, else SSB bus)
instead of the chipid register of the common core.

>> Also I don't know
>> if it is a good idea to let arch-specific code depend on code in
>> staging.
>
> Sure. The code needs to be cleaned up and moved to the mainline kernel
> _anyway_. You don't get around this.

Yes, you are right.


So I guess the proposed course of action would be:

1. Make the HND/AI-Bus code from brcm80211 its own independent driver,
2. Re-add the non-wifi related code (chipcommon, mips, etc),
3. Clean up the code until it meets Linux' code style/quality,
4. Move it out of staging,

and finally

5. Add the required arch specific code to bcm47xx for the newer SoCs.

Jonas

P.S: Any suggestions for the name? Would be "ai" okay? Technically
it's "AMBA Interconnect", but "amba" is already taken.
