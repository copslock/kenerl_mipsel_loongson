Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Jan 2011 13:41:07 +0100 (CET)
Received: from mail-yi0-f49.google.com ([209.85.218.49]:39627 "EHLO
        mail-yi0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491929Ab1AKMlC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Jan 2011 13:41:02 +0100
Received: by yib2 with SMTP id 2so6002428yib.36
        for <multiple recipients>; Tue, 11 Jan 2011 04:40:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=ASL09LrJzrAoAhOfLZ1yRFx4owX6TBU4GhVBOoR6txs=;
        b=pnW+hDuCEShAj80Khvje5JN113HyGdRjLcnTIa66Y+5EEKObceQaqoM8OFrSLIZRSq
         5ia11NchsIVMxSmigFVLWX4qe/3PFsRkrizeA6qBp/dGspnt+3J4oT/KnAncqYOceZo2
         sXTOdPXBJfj4R3LtFxO6X4J+jZXm5R8YEYwsE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=atKHwlcRdea6DgG0Udw4SzaMi1LWILgcWsIxfyEuAS766R8/LHYaEm0MG96RAV8C+r
         O6hVyiZYkZdlYyXL8J2v/rj4qMckFgZXDG5MPljxWFQAqFHkuZnINEVMJQtKQWTGkMXz
         uz4B/PDyeOgU3MyytgHknhcfaGYdmiPnKwDsQ=
MIME-Version: 1.0
Received: by 10.151.7.19 with SMTP id k19mr6876594ybi.279.1294749656164; Tue,
 11 Jan 2011 04:40:56 -0800 (PST)
Received: by 10.150.186.12 with HTTP; Tue, 11 Jan 2011 04:40:56 -0800 (PST)
In-Reply-To: <4D2C480C.4030109@openwrt.org>
References: <1294257379-417-1-git-send-email-blogic@openwrt.org>
        <4D2BC3F7.3080006@gmail.com>
        <4D2C480C.4030109@openwrt.org>
Date:   Tue, 11 Jan 2011 13:40:56 +0100
Message-ID: <AANLkTimJ5HREDEzr=JbPTEOuhr6D8YYDRa5vuFa7HSsp@mail.gmail.com>
Subject: Re: [PATCH 00/10] MIPS: add support for Lantiq SoCs
From:   Daniel Schwierzeck <daniel.schwierzeck@googlemail.com>
To:     John Crispin <blogic@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <daniel.schwierzeck@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28898
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.schwierzeck@googlemail.com
Precedence: bulk
X-list: linux-mips

Hi John,

2011/1/11 John Crispin <blogic@openwrt.org>:
> On 11/01/11 03:44, Daniel Schwierzeck wrote:
>> Hi John,
>>
>> after the 2.6.36 release i've started the same upstream project. I'm
>> hacking software for CPE's with Danube and VRX SoC's thus I have full
>> access to hardware manuals and latest BSP's. Maybe we should merge our
>> code somehow ;)
>>
>> Daniel
>
> Hi Daniel,
>
> i am in the middle of finishing my dma/etop rewrite. once this is done i
> think the core is ready.
>
> in general all contributions are welcome. question is if it is a good
> idea to merge the 2 trees now or if we merge one and then fix/add
> fetures that your tree has that mine is missing.

Actually my tree is very experimental yet so I'm going to contribute
to your tree.

>
> i was unable to find any public place where you keep your code. could
> you upload it somewhere so i can see what the exact differences are ?
>
> also could you tell me what the code base is based on ? (spinacer,
> ifxcpe, ifxmips...)
>
> i have so far not added vrx support due to lack of hardware to test on.
> a quick read of the docs does tell me however that only the gbit
> phy/switch and the clk needs to be adapted for vrx to also work. the
> gbit phy/switch part will already be included in my etop patches as it
> is needed by the arx series

I have an eval board with VRX288 so I could help with adding and
testing board support for that board.

Daniel
