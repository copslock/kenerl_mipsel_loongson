Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Nov 2009 20:26:00 +0100 (CET)
Received: from mail-ew0-f223.google.com ([209.85.219.223]:34855 "EHLO
        mail-ew0-f223.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492344AbZK3TZ5 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 30 Nov 2009 20:25:57 +0100
Received: by ewy23 with SMTP id 23so1524986ewy.24
        for <linux-mips@linux-mips.org>; Mon, 30 Nov 2009 11:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:in-reply-to
         :references:date:x-google-sender-auth:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=o4SjMT5Vf1BVPQs//rTmjetA7HoTcGsP8cwAiUlPfQU=;
        b=opXmki0qhD7ztOVN4ZttJ/gZ6okm4m7E2FNzjyOy7GwIbWp2NvRKrmq72t7Xnnq3Nd
         HyKSGoU3zfoYjt2e/Tiomd4LAwzSD3sfYUEkMFVSGlSdH7zI20MYfv8dwQewDb6HulnK
         StDaxHx1b61lJn8OQskLeVhPDLKsD27sjO5sY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=lYqTHJrTJmiGSTs+/oSCbaDVkJSWIDAYoPEakH5a51E4TPC8yOVhNr3cbTjnGZqxsP
         W4tlmliQOBF5oyDErSIjA0QVOuu8CB6N3NJomHQyLqTy/gisbVrXQ6GqCxoxR9d2vaMp
         S8cbjBuBdcPRINMx4MwqWw+qAVjYxgljkOASI=
MIME-Version: 1.0
Received: by 10.216.86.129 with SMTP id w1mr1649782wee.145.1259609151228; Mon, 
        30 Nov 2009 11:25:51 -0800 (PST)
In-Reply-To: <20091130190036.GA24581@dvomlehn-lnx2.corp.sa.net>
References: <4B1135FF.9050908@shikadi.net>
         <20091130190036.GA24581@dvomlehn-lnx2.corp.sa.net>
Date:   Mon, 30 Nov 2009 20:25:51 +0100
X-Google-Sender-Auth: 000e048fe92235a9
Message-ID: <10f740e80911301125m78694331qe02b3972e5c159c6@mail.gmail.com>
Subject: Re: Setting the physical RAM map
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     David VomLehn <dvomlehn@cisco.com>
Cc:     Adam Nielsen <a.nielsen@shikadi.net>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 25209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 30, 2009 at 20:00, David VomLehn <dvomlehn@cisco.com> wrote:
> On Sun, Nov 29, 2009 at 12:38:55AM +1000, Adam Nielsen wrote:
>> I'm attempting to port the Linux kernel to an NCD HMX, an R4600-based X-Terminal.
> ...
>> It gets as far as printing the physical RAM map and then crashes, but I'm
>> not sure why:
>>
>>   Determined physical RAM map:
>>    memory: 00800000 @ 40250000 (usable)
>>    memory: 00040000 @ 9fc00000 (ROM data)
>>   Wasting 8407552 bytes for tracking 262736 unused pages
>
> These are kernel messages, so you are getting into the kernel, but this
> looks odd to me.  The MIPS processor needs memory mapped in the first
> 512 MiB to execute. This first 512 MiB will be mapped as cached memory
> at virtual address 0x80000000 (known as kseg0) and as uncached memory at
> virtual address 0x0a0000000 (known as kseg1). Perhaps you system is like
> mine, where I have memory above 512 MiB aliased into the first 512 MiB
> of physical space.
>
> The second odd thing is the ROM data physical address. This is a good virtual
> address but as a physical address it is not accessible by the MIPS processor
> without mapping to with a TLB entry.

9fc00000 is kseg0. kseg0 has 512 MiB, so that's not only 0x8???????, but also
0x9???????.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
