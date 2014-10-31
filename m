Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 31 Oct 2014 17:23:28 +0100 (CET)
Received: from mail-wi0-f181.google.com ([209.85.212.181]:53522 "EHLO
        mail-wi0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012297AbaJaQXZpXAS8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 31 Oct 2014 17:23:25 +0100
Received: by mail-wi0-f181.google.com with SMTP id n3so1763180wiv.2
        for <multiple recipients>; Fri, 31 Oct 2014 09:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=GS2fm/s6vYbLAkbLV0bKyu49Vu2UkMkvkrBtW0w/h1M=;
        b=BLZKGHEqgoGLc/fVXlKm3qbhOTqMrX8of9XmWzX/7NdS82asExL6frGswygYeVsXbl
         bLoNnoaXBpBHI5QccNEIJcuSw8UIynl23pW7MbGAA0A57otLdtm/Igim6LS3XeKtPVCO
         xSPUnsMiCILGyCnK+8DBgRj1I80Sj+fI/AKvCP5cdTbcWE+gdg6JmzYVOeHxzgb3cg4k
         zOU5sF9gKGYgSuZqtvRzZ6/7w/DIZGbyKqLxJIU2LQefyjKFFi3bQMt4JVpLbMaydvoj
         WmjKdBnm1CHlnXpNzglDfzo92nXrBWWtqCy8KdLm9tDd88cftW/6avjUNmZXB7DAofi5
         xG6A==
X-Received: by 10.180.81.70 with SMTP id y6mr2325877wix.6.1414772600472; Fri,
 31 Oct 2014 09:23:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.217.55.200 with HTTP; Fri, 31 Oct 2014 09:22:40 -0700 (PDT)
In-Reply-To: <5453B53D.7060409@imgtec.com>
References: <1414771394-24314-1-git-send-email-manuel.lauss@gmail.com> <5453B53D.7060409@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Fri, 31 Oct 2014 17:22:40 +0100
Message-ID: <CAOLZvyH781d4TALUTCsSGWEzr6dRGmSzaeDKG=bdD8vQoOT2pw@mail.gmail.com>
Subject: Re: [RFC PATCH v6] MIPS: fix build with binutils 2.24.51+
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43809
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

I didn't encounter this error with what will be gcc-4.9.3.


Manuel

On Fri, Oct 31, 2014 at 5:13 PM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 10/31/2014 04:03 PM, Manuel Lauss wrote:
>> Starting with version 2.24.51.20140728 MIPS binutils complain loudly
>> about mixing soft-float and hard-float object files, leading to this
>> build failure since GCC is invoked with "-msoft-float" on MIPS:
>>
>> {standard input}: Warning: .gnu_attribute 4,3 requires `softfloat'
>>   LD      arch/mips/alchemy/common/built-in.o
>> mipsel-softfloat-linux-gnu-ld: Warning: arch/mips/alchemy/common/built-in.o
>>  uses -msoft-float (set by arch/mips/alchemy/common/prom.o),
>>  arch/mips/alchemy/common/sleeper.o uses -mhard-float
>>
>> To fix this, we detect if GAS is new enough to support "-msoft-float" command
>> option, and if it does, we can let GCC pass it to GAS;  but then we also need
>> to sprinkle the files which make use of floating point registers with the
>> necessary ".set hardfloat" directives.
>>
>> Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
>> ---
>> Compiles with binutils 2.23 and current git head, tested with alchemy (mips32r1)
>> and maltasmvp_defconfig (64bit)
>>
>> Tests with MSA and other extensions also appreciated!
>>
>> v6: #undef fp so that the preprocessor does not replace the fp in
>>       .set fp=64 with $30...  Fixes 64bit build.
>
> Technically speaking, a maltasmvp_defconfig selects CONFIG_32BIT=y so
> it's still a 32-bit build.
>> [...]
>
> Ok the fp problem went away but I still have the even/odd errors with my
> tools
>
> arch/mips/kernel/r4k_switch.S: Assembler messages:
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 1
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 3
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 5
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 7
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 9
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 11
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 13
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 15
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 17
> arch/mips/kernel/r4k_switch.S:81: Error: float register should be even,
> was 19
>
> The following patch did not help either:
>
> diff --git a/arch/mips/Makefile b/arch/mips/Makefile
> index 58076472bdd8..b8bb7e170fee 100644
> --- a/arch/mips/Makefile
> +++ b/arch/mips/Makefile
> @@ -56,7 +56,7 @@ ifdef CONFIG_FUNCTION_GRAPH_TRACER
>    endif
>  endif
>  cflags-y += $(call cc-option, -mno-check-zero-division)
> -
> +cflags-y += -mno-odd-spreg
>
> This is with a regular maltasmvp_defconfig
>
> I guess my gcc version is newer than yours. Matthew?
>
> --
> markos
