Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jan 2016 16:22:44 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:47993 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009639AbcADPWmgNYfJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 4 Jan 2016 16:22:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=Iunztu01MedgFc+yFredD4B8TyCf95B4GHO02z2ahI0=; b=kqEAgfrytNaJuY8J1XqwY1sjjD
        ZCfGYRw9twYLl/XGVSFzQaWZryjGBTldhPAOBO5Qq4GLVanv1WAwpbBLaJbGYxDOZoOgJz1cC2jkx
        UIEWTnUuABy2XPN+uBUZREuF/REIb35l4XeWaaRk3LtL0ad3ySb/Tih1DDI50aG0A3Rg=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57069 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86)
        (envelope-from <linux@roeck-us.net>)
        id 1aG6yF-001uf5-13; Mon, 04 Jan 2016 15:22:55 +0000
Subject: Re: Build regressions/improvements in v4.4-rc8
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1451919704-31509-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdXSiozb=4pC-vecF5RhwHxbuVA0au-P9VKymWV+1YhsCQ@mail.gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <568A8E39.7020504@roeck-us.net>
Date:   Mon, 4 Jan 2016 07:22:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.4.0
MIME-Version: 1.0
In-Reply-To: <CAMuHMdXSiozb=4pC-vecF5RhwHxbuVA0au-P9VKymWV+1YhsCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50855
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 01/04/2016 07:04 AM, Geert Uytterhoeven wrote:
> On Mon, Jan 4, 2016 at 4:01 PM, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>> JFYI, when comparing v4.4-rc8[1] to v4.4-rc7[3], the summaries are:
>>    - build errors: +19/-18
>
>    + /home/kisskb/slave/src/arch/arm/kernel/ftrace.c: error: implicit
> declaration of function 'flush_tlb_all'
> [-Werror=implicit-function-declaration]:  => 93:2
>    + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
> 'L_PTE_DIRTY' undeclared (first use in this function):  => 39:2
>    + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
> 'L_PTE_MT_WRITEBACK' undeclared (first use in this function):  => 39:2
>    + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
> 'L_PTE_PRESENT' undeclared (first use in this function):  => 39:2
>    + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error: 'L_PTE_XN'
> undeclared (first use in this function):  => 39:2
>    + /home/kisskb/slave/src/arch/arm/kernel/patch.c: error:
> 'L_PTE_YOUNG' undeclared (first use in this function):  => 39:2
>
> arm-randconfig
> Seen and report before
>
>    + /tmp/cc5DX198.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
>    + /tmp/ccHnSrdb.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 49, 366
>    + /tmp/ccSLqWGf.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
>    + /tmp/cch44bTJ.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 378, 49
>    + /tmp/ccjj7cLa.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
>    + /tmp/ccsgtMo8.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 41, 403
>    + /tmp/ccxItlIa.s: Error: can't resolve `_start' {*UND* section} -
> `L0^A' {.text section}:  => 43
>
> Various mips.
> Seems like the fix for this fix still doesn't fix everything?
>

Yes, there are more binutils problems. The current kernel code does not correctly
detect binutils versions such as 2.24.90, where the third level version number
is >= 10. See the discussion in [1], and the fix from James Hogan in [2].


If I find the time, I'll extend my test scripts to run some mips builds
with different binutils versions.

Guenter

---
[1] https://patchwork.linux-mips.org/patch/11929/
[2] https://patchwork.linux-mips.org/patch/11931/
