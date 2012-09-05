Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 06 Sep 2012 01:45:25 +0200 (CEST)
Received: from mail-pb0-f49.google.com ([209.85.160.49]:63329 "EHLO
        mail-pb0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903407Ab2IEXpW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 6 Sep 2012 01:45:22 +0200
Received: by pbbrq8 with SMTP id rq8so1742550pbb.36
        for <multiple recipients>; Wed, 05 Sep 2012 16:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=OxhiQPJa/Hq9bcj5s9ZhwdF/9lzpCPLfeNrQvQz04pE=;
        b=0BQwBCOJy66MsyV2QIjL2G9Q+V7Y6Idn/kC+YnvonyQzL6XXFIWdnBn+1jv2UMcjrY
         0tOXBBkAnhCmzStjCLACq2Hb2VolF43d7SUab0g+4L+cnxGDCO78UDv2kHLIsqBy+USR
         LBUAzvO39sWdSraBi5fy351NMUK9jP1GLRKuhqODoKy/AOgzHPPP8aTLrd96dCkAOOw5
         25ZhS3iAXVxjJS/NSKit28mp/Zltv9klau9VtxnBaM0Kp4sEL/u5YScQErdaDu+O461l
         EWatulXcCWZS3TXQ89ZCX6fIHeI9u7a12KVtc6gWa6mwr1S1YvVEt2A8LlJfzApTBzPs
         6J3A==
Received: by 10.66.84.130 with SMTP id z2mr285052pay.77.1346888715356;
        Wed, 05 Sep 2012 16:45:15 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id ty1sm376267pbc.76.2012.09.05.16.45.13
        (version=SSLv3 cipher=OTHER);
        Wed, 05 Sep 2012 16:45:14 -0700 (PDT)
Message-ID: <5047E408.4060009@gmail.com>
Date:   Wed, 05 Sep 2012 16:45:12 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:15.0) Gecko/20120828 Thunderbird/15.0
MIME-Version: 1.0
To:     Jim Quinlan <jim2101024@gmail.com>, ralf@linux-mips.org
CC:     linux-mips@linux-mips.org, cernekee@gmail.com
Subject: Re: [PATCH V4 0/3] MIPS: make funcs preempt-safe for non-mipsr2 cpus
References: <1346884367-6906-1-git-send-email-jim2101024@gmail.com>
In-Reply-To: <1346884367-6906-1-git-send-email-jim2101024@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 34433
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/05/2012 03:32 PM, Jim Quinlan wrote:
> This is V4 of my submission.  Here is a list of requested changes:
>
>    o Extra commit was added for changing an unsigned short to an int.
>    o Use of EXTERN_SYMBOL was added to mips-atomic.c and bitops.c,
>      as well as the removal of 'extern' in the functions' declarations.
>    o Name of funcs changed from atomic_xxx to __mips_xxx in bitops.c.
>    o The function comments in bitops.c were tweaked to please
>      scripts/kernel-doc.
>
> Here is a list of requested changes that were not done (and why):
>
>    o Suggested optimization of _MIPS_SZLONG and others was not needed
>      as mips-atomic.c now includes <asm/irqflags.h>.
>    o Suggested fixes to please checkpatch.pl for whitespace before
>      newlines in asm strings was attempted but the result made the
>      assembly code look more cluttered => no change made.
>
> These were unrequested changes:
>    o Changed order of func listings in irqflags.h so that only one
>      #ifdef/#endif pair was needed instead of three.
>
> Jim Quinlan
>


FWIW: I haven't tested these, but...

Acked-by: David Daney <david.daney@cavium.com>


Thanks for your patience,
David Daney
