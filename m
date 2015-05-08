Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 May 2015 21:53:55 +0200 (CEST)
Received: from mail-qg0-f45.google.com ([209.85.192.45]:34797 "EHLO
        mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012853AbbEHTxx2Qrh0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 May 2015 21:53:53 +0200
Received: by qgfi89 with SMTP id i89so41757415qgf.1;
        Fri, 08 May 2015 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=NdLIV30OyzdvoWjReG/cq55nDHJ5GXs5G8Qk5E+rHac=;
        b=ch7MaqMkzqCsN6YWd25KwpQeDc6VlCPckQF3Znlfloyn/3oXeiTnAj1SrxdAzh6vyh
         aZ92tHCgeSd++fGjgnTDtNaqSwzRHMIomb2VTrH6dWf6gv73dlrlQ4DwKYYDsvaLQoea
         VCuqRfPOVff5RkEv28el345IVBlwUMms2zWIktXqTtWOHvP6vKmJUaB/bt+JpRatakmM
         v3yXKC0MW8WNr4XNA5fRC14v2djQ/JvioEijQ+uwOTNiKxWXFwg6jtpD8V68gxuynSp8
         QQTsS6nuHLcoZNDFFAWAc0t0JHbciQYYSK7Hd150MDcnqVFNpcZQtsodBvFq9gjr+uTS
         b4hg==
X-Received: by 10.55.24.11 with SMTP id j11mr11696883qkh.73.1431114829091;
 Fri, 08 May 2015 12:53:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.94.117 with HTTP; Fri, 8 May 2015 12:53:28 -0700 (PDT)
In-Reply-To: <29249313.0p3GP5279g@wuerfel>
References: <1431089958-2626-1-git-send-email-jaedon.shin@gmail.com>
 <10776752.kPn2ooXz5Z@wuerfel> <CAJiQ=7Ajkae60eKfzr=mjPDov=bzoq7jBVDdQhGO37G8GGKK3w@mail.gmail.com>
 <29249313.0p3GP5279g@wuerfel>
From:   Kevin Cernekee <cernekee@gmail.com>
Date:   Fri, 8 May 2015 12:53:28 -0700
Message-ID: <CAJiQ=7BAYVgtXHvQbwcJ0y8PzuoeYPggiuk5K7T7M1BwjsbLJg@mail.gmail.com>
Subject: Re: [PATCH 1/2] MIPS: BMIPS: dts: remove unsupported entry for bcm7362
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jaedon Shin <jaedon.shin@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47296
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

On Fri, May 8, 2015 at 11:33 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > What exactly is the kernel limitation here?
>>
>> If we can't enable HIGHMEM, e.g. because the MIPS CPU has D$ aliases,
>> then Linux is supposed to ignore any RAM above the highmem/lowmem
>> boundary.
>>
>> There is code in paging_init() that tries to do this.  Several years
>> ago it used to work, but the last time I tried it (~Oct 2014) it was
>> broken due to some other changes in MIPS early memory init, so Linux
>> hangs on boot unless you take the excess RAM out of DT.  Jaedon may be
>> running into the same issue.
>
> Ok, I see. Could you avoid the problem by not requiring highmem?

I think the problem goes away if you disable CONFIG_HIGHMEM.

> We have some hacks on arch/arm/mach-realview to provide a nonlinear
> virt_to_phys() function, which ends up moving all RAM underneath the
> lowmem limit.

On this particular chip we can get a linear 1:1 virtual:physical
mapping for the first 1GB of system memory using the XKS01 hardware
feature and a bit of software support.  As Jaedon pointed out, a
couple of other things need to be tweaked in the arch/mips code:

 - Uncached/cached address conversions, as kseg1 is moved and reduced
 - Enabling XKS01 on each CPU thread on SMP boot, PM resume, or hot unplug
 - Setting aside a special VA range for uncached ioremaps, similar to
ARM, instead of assuming all kseg0 addresses have a corresponding
kseg1 address
 - Adding a wired TLB entry for PA 4000_0000 - 4fff_ffff

Without using XKS01, we'd need to use a nonlinear VA:PA mapping and
repurpose a large chunk of vmalloc space to map the upper 768MB of
system memory.  This would also require wired TLB entries and the
special ioremap range.  I never tried to make this work because the
XKS01 solution was cleaner.

Going beyond 1GB of system memory on this CPU would require HIGHMEM.
