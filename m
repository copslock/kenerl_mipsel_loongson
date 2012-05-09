Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 May 2012 21:22:06 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63729 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1901170Ab2EITWB convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 9 May 2012 21:22:01 +0200
Received: by pbbrq13 with SMTP id rq13so996233pbb.36
        for <multiple recipients>; Wed, 09 May 2012 12:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=47BeUfd23lsw5Y9niuFQez5kpWqVF1PI0cPvRVhcLDY=;
        b=lPRdLOgezezUSmS201s10x9MaJOnEDFvc2DXFf1YFj5ZIWTYJPHK3AMHuS920suClQ
         rc1eFTAl/FVMVPjerhC/RySmChmsQs4sS0wnTFjAbvkkZ97x1Apw7Dc1aLhU+kFI3PY3
         LUJ96AOVhwZgf4ivrz64lbNrvM3WLSYzP6nWhtzq1uG71UH2ZOF5Dlzd+5JLXm/nvyyA
         j+Tba2G5NfJLdPRr5JoC7PDbAxlrVgAWssneimyw6ll4FOxVmI8fWEhjix6QFGsP/QK1
         YUFAfuiL2jpwVK13n3DBbml6iHdgjIDQLypr0TmKXL2UfGo05y9a3XSvBVaVRa5Ln5pL
         rs6w==
Received: by 10.68.221.74 with SMTP id qc10mr11986138pbc.80.1336591314210;
 Wed, 09 May 2012 12:21:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.43.102 with HTTP; Wed, 9 May 2012 12:21:33 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.00.1205091747080.3701@eddie.linux-mips.org>
References: <1336084845-28995-1-git-send-email-mattst88@gmail.com> <alpine.LFD.2.00.1205091747080.3701@eddie.linux-mips.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Wed, 9 May 2012 15:21:33 -0400
Message-ID: <CAEdQ38F835drENTQ0_=62KCt0_xD1B=TW5OE9Gb8=sOqUW=icw@mail.gmail.com>
Subject: Re: [PATCH] mips: set ST0_MX flag for MDMX
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33224
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, May 9, 2012 at 1:20 PM, Maciej W. Rozycki <macro@linux-mips.org> wrote:
>> As the comment in commit 3301edcb says, DSP and MDMX share the same
>> config flag bit.
>>
>> Without this set, MDMX instructions cause Illegal instruction errors.
>
>  NAK, it's all pretty and nice, but I am afraid you're missing the point
> with your change.  The bit has its purpose, the MDMX accumulator has to be
> saved and restored -- just as the DSP or the FPU context -- between task
> switches and the bit provides for doing that lazily (of course you can do
> that eagerly instead if you like).

Okay. It looks like I also need to add save/restoring of the MDMX
accumulator to arch/mips/power/cpu.c and
arch/mips/include/asm/switch_to.h:finish_arch_switch()?
