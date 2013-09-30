Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 30 Sep 2013 21:17:58 +0200 (CEST)
Received: from mail-oa0-f52.google.com ([209.85.219.52]:52290 "EHLO
        mail-oa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823043Ab3I3TR4pCGES (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 30 Sep 2013 21:17:56 +0200
Received: by mail-oa0-f52.google.com with SMTP id n2so4053338oag.39
        for <multiple recipients>; Mon, 30 Sep 2013 12:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=96ntcOkd0+vniyQlCqsxzwLhpVF1bhqpfNhqCuUVXio=;
        b=PdJCcb9L2SN3fpEokl6UBkMmjR8OMg7/JRFJnV9reUHQjm8r/3INgfqoyAZdlITsPn
         RulrUPltJiyiXLBAQBE24CkQFtjxQLI/to2cFOQ4NvNWtkQ3BGfmFE2fLj4Ymx+ICp1C
         UFVimmLkyaXp3ZahyZlmOol55ehkO8mTtBxA9mTXUdEMEt9KVovONj4wS5oU2Qp5LBQL
         baPRCKdDMjl31l+j8stfX+G5hFX0Bgv8UOtDXqZ570jkVnhp8FCxrba+z3n26rf+KBT7
         1P9NaCA07SlaJmsC7MxezAMJ3Cxxtqvcm9uWHstF7yLE7i7VVichUNUJLctMQgd1gPJ+
         /JpQ==
X-Received: by 10.60.134.230 with SMTP id pn6mr1958217oeb.52.1380568670285;
        Mon, 30 Sep 2013 12:17:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id d3sm3255309oek.5.1969.12.31.16.00.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 30 Sep 2013 12:17:49 -0700 (PDT)
Message-ID: <5249CE5B.7040505@gmail.com>
Date:   Mon, 30 Sep 2013 12:17:47 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Geert Uytterhoeven <geert@linux-m68k.org>
CC:     "Pinski, Andrew" <Andrew.Pinski@caviumnetworks.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        David Howells <dhowells@redhat.com>,
        Markos Chandras <Markos.Chandras@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        John Crispin <blogic@openwrt.org>
Subject: Re: Issue with BUG() in asm-gemeric/bug.h if CONFIG_BUG=n
References: <20130930145630.GA14672@linux-mips.org> <52499E8B.6000702@gmail.com> <C9BC92C2-A7F5-4F9A-B001-D1A7F4ADEA5A@caviumnetworks.com> <5249B8A4.9070905@gmail.com> <CAMuHMdXkb6BH=1QvfHwMN54db9mP64KnCgoAj3aXida7-6OtPA@mail.gmail.com>
In-Reply-To: <CAMuHMdXkb6BH=1QvfHwMN54db9mP64KnCgoAj3aXida7-6OtPA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38073
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 09/30/2013 12:03 PM, Geert Uytterhoeven wrote:
> On Mon, Sep 30, 2013 at 7:45 PM, David Daney <ddaney.cavm@gmail.com> wrote:
>>> What about using __builtin_unreachable when we can but turn off warnings
>>> and use do{}while(0) when __builtin_unreachable does not exist?  This seems
>>> the both worlds.  Newer compilers produce better code with unreachable
>>> anyways.
>>>
>>
>> Simply not true.
>>
>> do{}while(0) is a NOP it is no more useful than an ';' statement.  It
>> doesn't serve as a magic uninitialized variable hiding mechanism.
>
> You missed the "turn off warnings" part of the "and".

You are correct, I did miss it.

The real problem here is that the kernel is written to expect that BUG() 
never returns.  Any implementation that has BUG() return, is almost 
certainly *not* what we want.

But wieh people select CONFIG_BUG=n they expect the smallest possible code.

These two criteria are mutually exclusive, so something should change.

It is not just the uninitialized variable warning, there can be others 
as well (control reaching the end of a non-void function comes to mind). 
  So I don't think turning off the warnings is a good solution.

That leaves:

1) Remove CONFIG_BUG and make it unconditionally enabled.

2) Make CONFIG_BUG=n imply "static inline void BUG(void){do{}while(1);}" 
which might be bigger than with CONFIG_BUG=y

David Daney


>
> Gr{oetje,eeting}s,
>
>                          Geert
>
> --
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
>
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                  -- Linus Torvalds
>
>
