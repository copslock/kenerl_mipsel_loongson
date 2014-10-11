Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 11 Oct 2014 08:53:52 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:48712 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010432AbaJKGxvN4O0K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 11 Oct 2014 08:53:51 +0200
Received: by mail-wi0-f182.google.com with SMTP id n3so3795033wiv.3
        for <linux-mips@linux-mips.org>; Fri, 10 Oct 2014 23:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=sACSipDtAJrcsE6ItpYFp90nKrJiKxr6jm8ysW4TrV0=;
        b=KUOOnXQ34rx0MIVWRR21BCiyyF8h3bO0Qx2049KuhUvXPoGQOdc0baV2sTHGT8cye1
         C4sHP85R1O3xZj2/lXdxCS8l34Rd/edmwbt/1+00p4S0tld4y5BxCs83CPmdxwncNrn2
         Al5oPTeXVv2yLhZq2KNcJbgk+JzZ5jk0nbH6saZGO0tgmjgPSVz1wt4kwcFo+m/frcUW
         2cMcA9g/kjHlql3NtbusCvIeHGbp5ku2kZ/FHeF7ZBAWyDfmokiKwVxyARDNRiSsX+K9
         wSe9qmEK9Kvp/GfJr++aPNdOfXVROiyDPShPuz6WzChvC4XD93Q1TxsStBUnHJgCXMMq
         i6IA==
X-Received: by 10.180.38.15 with SMTP id c15mr8871526wik.65.1413010425911;
 Fri, 10 Oct 2014 23:53:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.216.36.67 with HTTP; Fri, 10 Oct 2014 23:53:05 -0700 (PDT)
In-Reply-To: <5437EFDA.4060709@imgtec.com>
References: <1408465632-34262-1-git-send-email-manuel.lauss@gmail.com>
 <20140825125107.GA25892@linux-mips.org> <alpine.LFD.2.11.1408251502140.18483@eddie.linux-mips.org>
 <CAOLZvyG4F_PCb5hbws1_e8nCeJ+odvnC5u=yitSe9CwY3TWZdw@mail.gmail.com>
 <5437EFB7.2020106@imgtec.com> <5437EFDA.4060709@imgtec.com>
From:   Manuel Lauss <manuel.lauss@gmail.com>
Date:   Sat, 11 Oct 2014 08:53:05 +0200
Message-ID: <CAOLZvyGhUTAUdnvrdSKrjKkdedREFa9fASSuxa4P3ADz8iNqoA@mail.gmail.com>
Subject: Re: [RFC PATCH V2] MIPS: fix build with binutils 2.24.51+
To:     Markos Chandras <Markos.Chandras@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43239
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

Hi,

I still indend to, I just have a lot of non-linux related things to do
currently.
And I still struggle to get softloat gcc-4.9 and glibc built with
binutils commit
351cdf24d223290b15fa991e5052ec9e9bd1e284 applied, the linker throws float errors
left and right :(

Manuel

On Fri, Oct 10, 2014 at 4:40 PM, Markos Chandras
<Markos.Chandras@imgtec.com> wrote:
> On 10/10/2014 03:39 PM, Markos Chandras wrote:
>> On 08/25/2014 08:29 PM, Manuel Lauss wrote:
>>> On Mon, Aug 25, 2014 at 4:27 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>>>
>>>> 1. Determine whether `-Wa,-msoft-float' and `.set hardfloat' are available
>>>>    (a single check will do, they were added to GAS both at the same time)
>>>>    and only enable them if supported by binutils being used to build the
>>>>    kernel, e.g. (for the `.set' part):
>>>>
>>>> #ifdef GAS_HAS_SET_HARDFLOAT
>>>> #define SET_HARDFLOAT .set      hardfloat
>>>> #else
>>>> #define SET_HARDFLOAT
>>>> #endif
>>>>
>>>>    Otherwise we'd have to bump the binutils requirement up to 2.19; this
>>>
>>> Do people really update their toolchain so rarely?
>>>
>>>
>>>> 2. Use `.set hardfloat' only around the places that really require it,
>>>>    i.e.:
>>>>
>>>>         .set    push
>>>>         SET_HARDFLOAT
>>>> # Do the FP stuff.
>>>>         .set    pop
>>>>
>>>>    (so the arch/mips/kernel/r4k_fpu.S piece is good except for maybe using
>>>>    a macro, depending on the outcome of #1 above, but the other ones are
>>>>    not).
>>>
>>> I'll update the patch.
>>>
>>> Thank you!
>>>         Manuel
>>>
>> Hi Manual,
>>
>> Just wanted to ping you about this patch. Do you intend to submit a new
>> version including all the feedback from Ralf, Maciej and Matthew?
>>
>
> s/Manual/Manuel/ :)
>
> sorry about that
>
> --
> markos
>
