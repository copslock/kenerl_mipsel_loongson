Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Jan 2011 14:54:35 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37566 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493451Ab1AQNyc convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 17 Jan 2011 14:54:32 +0100
Received: by fxm19 with SMTP id 19so6052271fxm.36
        for <linux-mips@linux-mips.org>; Mon, 17 Jan 2011 05:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=lUcBKaoVOnQqedyjNMI7R+WIjjYfW3QC4LdIO0BmbIY=;
        b=lENoMGI7gFNifFBbruqLORBBkKROc9uGj1RcjqeeuSy0Gf9JXd880OXt46oHBzRNk5
         L5tx6WoSm7LggwBKPuQRxuehaJgFKR01dy0QtxqNldjF+1fg06umcKt91N7yRJBj39mv
         A57WqxQevxVSClHpesM4O0IXuDy8LWqWPPW80=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=utBKNppHDcFmyRDPkMQIZo0MO7LVW7B3QYWLaS0KrGqeRQtlJvG34t03zOpfUFBNbe
         P0kvGrflfCu3OMzdMesqLDRK0nCZgxmHdbAOQcZdSc4OJw2R6jN6CSngIcoxv3BU3N6H
         9XdUPNcrl6VpmnfTrcDuJjcseyjxWpqMWw/p0=
MIME-Version: 1.0
Received: by 10.223.71.197 with SMTP id i5mr4772390faj.127.1295272464786; Mon,
 17 Jan 2011 05:54:24 -0800 (PST)
Received: by 10.223.75.194 with HTTP; Mon, 17 Jan 2011 05:54:24 -0800 (PST)
In-Reply-To: <AANLkTims0DPfG+u9qynuuj_-0WjUr1nAGLuFz3k706T-@mail.gmail.com>
References: <AANLkTi=GDcy50zsC6=Dgv1-Ty3cYK2qpx9o=q3JdXuCh@mail.gmail.com>
        <1295261783.24530.3.camel@maggie>
        <AANLkTikJcug7LUTgX_YDD4Z8ZBrdkAdLq8_Epa6TkA5f@mail.gmail.com>
        <1295265468.24530.23.camel@maggie>
        <AANLkTims0DPfG+u9qynuuj_-0WjUr1nAGLuFz3k706T-@mail.gmail.com>
Date:   Mon, 17 Jan 2011 14:54:24 +0100
X-Google-Sender-Auth: ltPfdPjREbIT91mqEaY6o58yog8
Message-ID: <AANLkTinwGaqg8ahGWd3+_dfhrCNTQNOfO1E-EUepFJ+C@mail.gmail.com>
Subject: Re: Merging SSB and HND/AI support
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Jonas Gorski <jonas.gorski@gmail.com>
Cc:     =?UTF-8?Q?Michael_B=C3=BCsch?= <mb@bu3sch.de>,
        linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 17, 2011 at 14:43, Jonas Gorski <jonas.gorski@gmail.com> wrote:
> On 17 January 2011 12:57, Michael Büsch <mb@bu3sch.de> wrote:
>> Well... I don't really like the idea of running one driver and
>> subsystem implementation on completely distinct types of silicon.
>> We will end up with the same mess that broadcom ended up with in
>> their "SB" code (broadcom's SSB backplane implementation).
>> For example, in their code the driver calls pci_enable_device() and
>> related PCI functions, even if there is no PCI device at all. The calls
>> are magically re-routed to the actual SB backplane.
>> You'd have to do the same mess with SSB. Calling ssb_device_enable()
>> will mean "enable the SSB device", if the backplane is SSB, and will
>> mean "enable the HND/AI" device, if the backplane is HND/AI.

> P.S: Any suggestions for the name? Would be "ai" okay? Technically
> it's "AMBA Interconnect", but "amba" is already taken.

If it's AMBA, can it be integrated with the existing code in drivers/amba/?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
