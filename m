Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 28 May 2011 12:48:59 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:52963 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490987Ab1E1Ksu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 28 May 2011 12:48:50 +0200
Received: by pwi8 with SMTP id 8so1305850pwi.36
        for <multiple recipients>; Sat, 28 May 2011 03:48:42 -0700 (PDT)
Received: by 10.142.99.10 with SMTP id w10mr488307wfb.18.1306579722134;
        Sat, 28 May 2011 03:48:42 -0700 (PDT)
Received: from [192.168.43.191] (m872736d0.tmodns.net [208.54.39.135])
        by mx.google.com with ESMTPS id x8sm1927557wfx.19.2011.05.28.03.48.39
        (version=SSLv3 cipher=OTHER);
        Sat, 28 May 2011 03:48:41 -0700 (PDT)
Message-ID: <4DE0D303.8000106@landley.net>
Date:   Sat, 28 May 2011 05:48:35 -0500
From:   Rob Landley <rob@landley.net>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.17) Gecko/20110424 Thunderbird/3.1.10
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: MIPS panic in 2.6.39 (bisected to 7eaceaccab5f)
References: <4DDB5673.5060206@landley.net> <20110524143937.GB30117@linux-mips.org> <4DDCB1EB.4020707@landley.net> <20110527075512.GE30117@linux-mips.org> <20110527140011.GF30117@linux-mips.org>
In-Reply-To: <20110527140011.GF30117@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <rob@landley.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30166
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: rob@landley.net
Precedence: bulk
X-list: linux-mips

On 05/27/2011 09:00 AM, Ralf Baechle wrote:
> On Fri, May 27, 2011 at 08:55:13AM +0100, Ralf Baechle wrote:
> 
>>> Have you guys been able to reproduce the problem?
>>
>> Staring at the disassembly was good enough, I think.  The commit you
>> bisected is restructuring some of the hardware probing code for Malta and
>> seems to result in gcmp_present being set without _gcmp_base having been
>> assigned, thus the null pointer dereference.
> 
> Can you test below patch?  Thanks,
> 
>   Ralf
> 
> Since af3a1f6f4813907e143f87030cde67a9971db533 the Malta code does no
> longer probe for presence of GCMP if CMP is not configured.  This means
> that the variable gcmp_present well be left at its default value of -1
> which normally is meant to indicate that GCMP has not yet been mmapped.
> This non-zero value is now interpreted as GCMP being present resulting
> in a write attempt to a GCMP register resulting in a crash.
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

patch patch patch...

> diff --git a/arch/mips/mti-malta/malta-init.c b/arch/mips/mti-malta/malta-init.c
> index 31180c3..4163d09e 100644
> --- a/arch/mips/mti-malta/malta-init.c
> +++ b/arch/mips/mti-malta/malta-init.c

Your missing hunk at the top of this file is:

@@ -29,6 +29,7 @@
 #include <asm/system.h>
 #include <asm/cacheflush.h>
 #include <asm/traps.h>
+#include <asm/smp-ops.h>

 #include <asm/gcmpregs.h>
 #include <asm/mips-boards/prom.h>

And then the patch works!  Yay!  Thank you.

Signed-off-by: Rob Landley <rob@landley.net>

Rob
