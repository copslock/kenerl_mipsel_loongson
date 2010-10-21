Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 21 Oct 2010 10:07:59 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:47847 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491011Ab0JUIHz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 21 Oct 2010 10:07:55 +0200
Received: by fxm15 with SMTP id 15so3547565fxm.36
        for <multiple recipients>; Thu, 21 Oct 2010 01:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:sender:received
         :in-reply-to:references:date:x-google-sender-auth:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=H/YnMnU5oW6a6X3kJajpz0HQ/ILih/1YxMd+HwbaCe8=;
        b=frEtYMP2ErVkQfaR16zP5TtDmkRw8XDAAsf5VRA/fZ6LJjtm/t7BMDSmdHT/xwtj3+
         mmDrNS6hslFzKnCNJNApZw5vMw8fEEUa8Rna6x39yE2Zwuz95JhjC3aIIDP1+N3cZ4u/
         EewxD4bkSC/YlQ4hRcJ+Rh8oy6HzfMP2wih/I=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=oHsVuXLV78hF5uyN+Zxmb1/gzW/7x8RIuDA5paC0kBSt/9K1U9knEf8/KVGT5vJarq
         YoO17p5ueOuCp3ZE/5VIxB7V5GCpTa44KMmUoymehED0HeGJZthnZFhhxTGol8dLtwfa
         QKTByfjyVQuQprBS9qLtkbTTYqPWK1ILpH2+E=
MIME-Version: 1.0
Received: by 10.103.171.9 with SMTP id y9mr504989muo.40.1287648470261; Thu, 21
 Oct 2010 01:07:50 -0700 (PDT)
Received: by 10.223.119.193 with HTTP; Thu, 21 Oct 2010 01:07:50 -0700 (PDT)
In-Reply-To: <20101020190534.GB32087@linux-mips.org>
References: <1287085009-16445-1-git-send-email-ddaney@caviumnetworks.com>
        <AANLkTikdRQSsLxPFtY+cav24wEkSVEQ9vCtrMEvvM3CV@mail.gmail.com>
        <20101020190534.GB32087@linux-mips.org>
Date:   Thu, 21 Oct 2010 10:07:50 +0200
X-Google-Sender-Auth: tdAhI_Aa1PvSX4hla0HX5EGMXsk
Message-ID: <AANLkTikEpNsBPrZprFoOAWaQ6jk8YZROdHPiOFe7CyqQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Implement __read_mostly
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28181
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 20, 2010 at 21:05, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Sat, Oct 16, 2010 at 10:04:59AM +0200, Geert Uytterhoeven wrote:
>> > -const unsigned long mips_io_port_base __read_mostly = -1;
>> > +const unsigned long mips_io_port_base = -1;
>> >  EXPORT_SYMBOL(mips_io_port_base);
>>
>> Ugh. So as soon as someone implements MMU protection for the read-only data
>> section, it'll break silently?
>
> That's not the only failure mode.  A const might be replicated by a compiler
> for example into multiple small data sections or by loading the rodata
> into multiple NUMA nodes.  The later hits IP27 but that one got potencially

Didn't think about that. Ough...

> many PCI busses anyway, so mips_io_port_base was always problematic.  From
> the time I put this optimization hack in it was clear that I was gaming
> GCC and sooner or later it was going to blow up.  It's held for like a
> decade so I got my money's worth :)

Or it may fool "smart" debuggers, who read the data from the original image
instead of from memory. Once we had a buffer overflow corrupting subsequent
read-only data on a VxWorks platform, but the debugger didn't see it
as it refused to
look at the actual data in RAM...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
