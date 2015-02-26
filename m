Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Feb 2015 23:43:32 +0100 (CET)
Received: from mail-ie0-f181.google.com ([209.85.223.181]:39465 "EHLO
        mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007512AbbBZWn3ns2dZ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Feb 2015 23:43:29 +0100
Received: by iecvy18 with SMTP id vy18so22415143iec.6
        for <linux-mips@linux-mips.org>; Thu, 26 Feb 2015 14:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=qVMJc6H1uZ1GtAMXjzXmnl+/FujOSjqvvy+qIxFrQpw=;
        b=C4U5yPUw7G+dSqkenxQduFVbO4ohX+uMFjBNk/mE310WT/yulO5gRG72ANFmHX9XqW
         YaJIYhopQgfcd0jFTkzuak7Xu+17t4k6MuX14S1DHWj43hwqwdmv+kQy4lVZIAnzHBvS
         TqM1bGBl1EmUSlzppa3dXdjnTVWgdC2KPWteJM2Ea19N8qWmtHmFNUsrMgXz7ThYWhEd
         qSEURZpH/H0sHwa7clWp5vy9ycu8zhe93qBcSjoZW2k/cLiWJxgBNZ4SocAYf/pqx6WV
         K36daw2hyGF7aqCUB74YIjltVoP3J7lBm7nda+ZPlwW3Qa1McIjfRh8v3lhf2LFtQcTx
         mocA==
X-Received: by 10.107.46.230 with SMTP id u99mr14620558iou.21.1424990604425;
        Thu, 26 Feb 2015 14:43:24 -0800 (PST)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by mx.google.com with ESMTPSA id f1sm1174589iof.30.2015.02.26.14.43.22
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Thu, 26 Feb 2015 14:43:23 -0800 (PST)
Message-ID: <54EFA189.3010509@gmail.com>
Date:   Thu, 26 Feb 2015 14:43:21 -0800
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Andrew Morton <akpm@linux-foundation.org>
CC:     Ingo Molnar <mingo@kernel.org>,
        Hector Marco Gisbert <hecmargi@upv.es>,
        Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        ismael Ripoll <iripoll@upv.es>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] Fix offset2lib issue for x86*, ARM*, PowerPC and MIPS
References: <54EB735F.5030207@upv.es>        <CAGXu5j+SBRcj+BGyxEwUzgKsB2fdzNiPY37Q=JTsf=-QbGwoGA@mail.gmail.com>        <20150223205436.15133mg1kpyojyik@webmail.upv.es>        <20150224073906.GA16422@gmail.com> <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
In-Reply-To: <20150226143815.09386fe280c7bd8797048bb2@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46012
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

On 02/26/2015 02:38 PM, Andrew Morton wrote:
[...]
>
> From: Andrew Morton<akpm@linux-foundation.org>
> Subject: fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
>
> Consolidate randomize_et_dyn() implementations into fs/binfmt_elf.c.
>
> There doesn't seem to be a compile-time way of making randomize_et_dyn()
> go away on architectures which don't need it, so mark it __weak to cause
> it to be discarded at link time.
>
> Cc: "H. Peter Anvin"<hpa@zytor.com>
> Cc: Benjamin Herrenschmidt<benh@kernel.crashing.org>
> Cc: Catalin Marinas<catalin.marinas@arm.com>
> Cc: Hector Marco Gisbert<hecmargi@upv.es>
> Cc: Hector Marco-Gisbert<hecmargi@upv.es>
> Cc: Ingo Molnar<mingo@kernel.org>
> Cc: Ismael Ripoll<iripoll@upv.es>
> Cc: Kees Cook<keescook@chromium.org>
> Cc: Ralf Baechle<ralf@linux-mips.org>
> Cc: Russell King<rmk@arm.linux.org.uk>
> Cc: Thomas Gleixner<tglx@linutronix.de>
> Cc: Will Deacon<will.deacon@arm.com>
> Signed-off-by: Andrew Morton<akpm@linux-foundation.org>
[...]
> diff -puN arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix arch/arm64/include/asm/elf.h
> --- a/arch/arm64/include/asm/elf.h~fix-offset2lib-issue-for-x86-arm-powerpc-and-mips-fix
> +++ a/arch/arm64/include/asm/elf.h
> @@ -1,5 +1,5 @@
>   /*
> - * Copyright (C) 2012 ARM Ltd.
> + * Copyright (C) 20q12 ARM Ltd.

This particular change looks like it may be a typo.

>    *
>    * This program is free software; you can redistribute it and/or modify
>    * it under the terms of the GNU General Public License version 2 as
