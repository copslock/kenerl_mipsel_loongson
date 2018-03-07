Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Mar 2018 16:21:18 +0100 (CET)
Received: from mail-io0-x242.google.com ([IPv6:2607:f8b0:4001:c06::242]:44071
        "EHLO mail-io0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994721AbeCGPVLoepMt convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Mar 2018 16:21:11 +0100
Received: by mail-io0-x242.google.com with SMTP id h23so3396586iob.11;
        Wed, 07 Mar 2018 07:21:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zb/Q/h9Ry5DhxigLOObhX1jHZkb8rkxRMxZi7kxoCio=;
        b=A/W6RCGLLqWvzZSlUd+vdNaNNgoz31G9dsCQXX2ISMjLWkcB0cwt3yf2PrIG0i/8wx
         fCoWGYkGt47ZdOViZkNVOkbunmPrKGDNnJ2GZqFWx3PPw4Cn8VQrN2JLyKEC5UDI6C01
         Hq0jnirSLCJgFkgNo9oSy9F/pGSsMFLS4ZsGp9f3ig/N2v/kTlYqolPRsqPGy6P3h+mO
         XOp/rUZ1Xxm8xz3sgRc28RcxzTbubRAl/9BotPcedfR8uOaoUrWb46c8+Y5pi635L/5H
         7Sq3oiwUYrQVrXhD3QBeLzc76eXTJBDnxtZ8nQa98R5pm9RG4N68M2PzJj4vHYXdaOao
         b3Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zb/Q/h9Ry5DhxigLOObhX1jHZkb8rkxRMxZi7kxoCio=;
        b=CudRn1iIn+JT2xliVvvrzO9Taya8QrIPiCyVz5QiFjPhGX4hrLrDKBpasgOZhaakKv
         F0CkKvIpEoZwE5aHoIg9l60w5gZRQfCGATI12eq4AvI16sG6q74BEoR/pcNylepOa3r7
         aqaUQxGhfCzK9j+tbFhByMDB172rBDcPkhFY7ToKEZbKbw0j3oMil/hXaW4+elen9z3K
         IHPlhunXVdvujXpYxRkymuVdbF2oYHS4SnbzoW74CuUi8kHR825RFM22wnpbvAdJBL90
         9w8GJKZozCcxW5rkNex1XUb//UdV2aIPvudlI/bVtpU0uhraJWikY2rv5HSXQazY1WMj
         GYcw==
X-Gm-Message-State: APf1xPCKnCHyrJpYSOF4wc5Jn/CNJHLNZ/RvxY8/Rl3WqLdZBOTJ5dcw
        bwduhP3Ulp93hZwOFSya5MR0uSMvAg+yautMRh4=
X-Google-Smtp-Source: AG47ELttOJgRqwH2DzYUBTjudGfcXHWwZbgOSa9t78pVNYnyoBTp2eC53+OGUIRHWnjSHqrvJ9ArchJe4F4iMJuHnJ4=
X-Received: by 10.107.200.142 with SMTP id y136mr27947214iof.155.1520436065354;
 Wed, 07 Mar 2018 07:21:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.2.89.194 with HTTP; Wed, 7 Mar 2018 07:21:04 -0800 (PST)
In-Reply-To: <1520432391.3731.8.camel@flygoat.com>
References: <20170927151527.25570-1-prasannatsmkumar@gmail.com>
 <20170927151527.25570-4-prasannatsmkumar@gmail.com> <20180306000832.GL4197@saruman>
 <CANc+2y5_R5xYQuLbW7NAjO4mcW5RNn3Da77tAhYU5zj=0rkBDQ@mail.gmail.com> <1520432391.3731.8.camel@flygoat.com>
From:   PrasannaKumar Muralidharan <prasannatsmkumar@gmail.com>
Date:   Wed, 7 Mar 2018 20:51:04 +0530
Message-ID: <CANc+2y5t9PLHJTF0RvoVOTy0DpWtb++ARFT=5KuJOd-1Da+ASQ@mail.gmail.com>
Subject: Re: [RFC 3/4] MIPS: Ingenic: Initial X1000 SoC support
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     James Hogan <jhogan@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Michael Turquette <mturquette@baylibre.com>,
        sboyd@codeaurora.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-clk@vger.kernel.org,
        open list <linux-kernel@vger.kernel.org>,
        Paul Cercueil <paul@crapouillou.net>,
        Mathieu Malaterre <malat@debian.org>,
        Dominik Peklo <dom.peklo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-Path: <prasannatsmkumar@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62837
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: prasannatsmkumar@gmail.com
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

Hi Jiaxun,

On 7 March 2018 at 19:49, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
> 在 2018-03-07三的 19:14 +0530，PrasannaKumar Muralidharan写道：
>>
>> I used to get my code tested from Domink but I could not reach him
>> for
>> quite some time. Before buying the development board myself I would
>> like to see if anyone can help me in testing. Do you have any contact
>> with Ingenic who can help in testing this?
>>
>
> Hi PrasannaKumar
>
> I'm resently working on Ingenic chips too. Ingentic guys have sent me a
> X1000 development broad and it will arrive in about two weeks. I have a
> ejtag debugger also (but not very suit with X1000 because X1000 have
> different ejtag interface with standard MIPS cores, maybe we need some
> modification on openocd). So maybe I can help in testing this after I
> get my broad. Just ask if you need any help.
> Thanks
> --
> Jiaxun Yang <jiaxun.yang@flygoat.com>

Really nice to hear. I will ask for help once I make changes.

Thanks,
PrasannaKumar
