Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Aug 2012 22:35:46 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:61187 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903262Ab2H3Ufl (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Aug 2012 22:35:41 +0200
Received: by lbbgf7 with SMTP id gf7so754323lbb.36
        for <multiple recipients>; Thu, 30 Aug 2012 13:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=CPbZ80Q2xWfpbZUnGDkytDBwt7c3iBvfah4VBYkcvqY=;
        b=weHB9kIUNbX1lUe8Z54+TzI2L6oDj3neJuNiF6iE75H/3jcdm5FfPsS2dabEUpoWgI
         z0p6lmwYh4592oVNGhiIQCZvsxex+lFWPlxt7i/wKiav/pNiGHVIrzFH4wIs00pTbVm6
         h+457057KDGiNHjtTq5eNg/5ag6S4YmIiG7aSs5ss8D5M7mGZKGhI73/FHP2hkpsqThF
         z5e7seWks/MLE3ttBbM0MW4im8rEhLfINvF7ZD5V0ka0o2ubL0e3oKCIHHx1xUHcfKZG
         W3CzIv50btOL+4G5auFUpyRDp5S78DT7zdFqGhRIirYhib0Mfsw4hyQOzVO4MuMZZUhJ
         joGA==
MIME-Version: 1.0
Received: by 10.152.144.168 with SMTP id sn8mr4529327lab.1.1346358935448; Thu,
 30 Aug 2012 13:35:35 -0700 (PDT)
Received: by 10.114.23.98 with HTTP; Thu, 30 Aug 2012 13:35:35 -0700 (PDT)
In-Reply-To: <20120830141525.GD23288@linux-mips.org>
References: <1346279647-27955-1-git-send-email-jim2101024@gmail.com>
        <503E9F66.9030200@gmail.com>
        <CANCKTBsXhKNtNJxYhyn4Ygt=c3=4ZT-quB3L1XJVFC4y-mWM7Q@mail.gmail.com>
        <20120830141525.GD23288@linux-mips.org>
Date:   Thu, 30 Aug 2012 16:35:35 -0400
Message-ID: <CANCKTBs83w=MTKE948-Vk7ArhF9d6X7viLTcPbZ27uCiXxDqgw@mail.gmail.com>
Subject: Re: [PATCH V2 1/2] asm-offsets.c: adding #define to break circular dependency
From:   Jim Quinlan <jim2101024@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 34386
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jim2101024@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Are you saying you want me to outline most of the functions in
asm/bitops.h , or do you want me somehow outline just the "else"
clause that invokes raw_local_irq_{save_restore}?

Jim

On Thu, Aug 30, 2012 at 10:15 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Thu, Aug 30, 2012 at 10:06:30AM -0400, Jim Quinlan wrote:
>
>> I'm not sure the tangle is so easily undone.  The first dependency I see is
>>
>> asm-offsets.c
>> asm/processors.h
>> linux/cpumask.h
>> linux/kernel.h
>> linux/bitops.h
>> asm/bitops.h
>> linux/irqflags.h
>> asm/irqflags.h
>>
>> When compared to other architectures, the MIPS asm/bitops.h seems to
>> include more files at the top, including linux/irqflags.h.
>> Any suggestions?
>
> This is because MIPS bitops for some ancient processors which don't have
> atomic operations and Cavium cnMIPS cores where disabling interrupts is
> faster than the atomic operations are implemented by disabling interrupts.
>
> This makes these atomic operations relativly bloated in terms of code size
> generated and may it'd be a good idea to outline the bits.  With a bit
> of luck we even get better cache locality - and fewer header file
> inclusions.
>
>   Ralf
