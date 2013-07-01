Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jul 2013 09:59:41 +0200 (CEST)
Received: from mail-pa0-f44.google.com ([209.85.220.44]:65192 "EHLO
        mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6817030Ab3GAH7jkJJLj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jul 2013 09:59:39 +0200
Received: by mail-pa0-f44.google.com with SMTP id lj1so4739774pab.17
        for <multiple recipients>; Mon, 01 Jul 2013 00:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=TxVQjSA4mZhCU8JK1LHE+Te+AOwSOzpWCDKBZhjmwYI=;
        b=uECOImqeW79XintTUg9+fffZPYr3IAhw4ups8HtHv7iEBIraYJdvymrM1mDDpA4vh6
         ZvuLBwIcI0IykFnx2SvGJHwSZUIgm/01UZfBTPtRxtxd8C+vh/C5EEN/rttlX08llyyi
         y6v2uONJg56zHJiKu823CyoAMkoIAwXEFiB9bKzMmIcURINIU0NnaIBPO/I1NtVu1Z48
         DMlOBp71Yt/s+DPZMhlolidxTzl4pWHoC2oRe8H24o4w3n47xV5ie4YWHuLXpwqAfCDz
         /vT3cUYKbWIIgqYKzTcJGx5HX/CgI2uaP7iPrauoCWl0zgwkOHAqGcHZk5eV2nyQxCCS
         LqfQ==
MIME-Version: 1.0
X-Received: by 10.66.163.7 with SMTP id ye7mr3990157pab.24.1372665573137; Mon,
 01 Jul 2013 00:59:33 -0700 (PDT)
Received: by 10.70.78.197 with HTTP; Mon, 1 Jul 2013 00:59:33 -0700 (PDT)
In-Reply-To: <51D1345B.8020509@linutronix.de>
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com>
        <51C4171C.9050908@linutronix.de>
        <51C48B5A.2040404@ti.com>
        <51CCA67C.2010803@gmail.com>
        <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com>
        <20130628134931.GD21034@game.jcrosoft.org>
        <51CE1F92.3070802@ti.com>
        <51D1345B.8020509@linutronix.de>
Date:   Mon, 1 Jul 2013 09:59:33 +0200
X-Google-Sender-Auth: VcBufR2SziNNSg6ZpNaW158x-28
Message-ID: <CAMuHMdV6YM3-hASqjxkguEukZjnjK80gBjDNiabxjfQtC=c8ag@mail.gmail.com>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Santosh Shilimkar <santosh.shilimkar@ti.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Jonas Bonn <jonas@southpole.se>,
        Russell King <linux@arm.linux.org.uk>,
        linux-c6x-dev@linux-c6x.org,
        "the arch/x86 maintainers" <x86@kernel.org>,
        "arm@kernel.org" <arm@kernel.org>,
        Rob Herring <robherring2@gmail.com>,
        Grant Likely <grant.likely@linaro.org>,
        Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        linux-xtensa@linux-xtensa.org,
        James Hogan <james.hogan@imgtec.com>,
        devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37235
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

On Mon, Jul 1, 2013 at 9:48 AM, Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
> On 06/29/2013 01:43 AM, Santosh Shilimkar wrote:
>> Apart from waste of 32bit, what is the other concern you
>> have ?
>
> You pass a u64 as a physical address which is represented in other
> parts of the kernel (for a good reason) by phys_addr_t.
>
>> I really want to converge on this patch because it
>> has been a open ended discussion for quite some time. Does
>> that really break any thing on x86 or your concern is more
>> from semantics of the physical address.
> You want to have your code in so you can continue with your work, that
> is okay. The other two arguments why u64 here is a good thing was "due
> to what I said earlier" and "+1" and I don't have the time to look
> that up.
>
> There should be no problems on x86 if this goes in as it is now.
>
> But think about this: What happens if you boot your ARM device without
> PAE and your initrd is in the upper region? If you are lucky the kernel
> looks at a different place where it also has a read permission, notices
> nothing sane is there, writes a message and continues. And if it is not
> allowed to read? It is clearly the user's fault for booting a non-PAE
> kernel.

That's actual the original reason: DT has it as 64 bit, and passes it to a
32 bit kernel when running in 32 bit mode without PAE.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
