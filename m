Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 15 Aug 2013 09:55:19 +0200 (CEST)
Received: from mail-ea0-f169.google.com ([209.85.215.169]:43284 "EHLO
        mail-ea0-f169.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6827312Ab3HOHzNc89Jk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 15 Aug 2013 09:55:13 +0200
Received: by mail-ea0-f169.google.com with SMTP id z7so199889eaf.14
        for <linux-mips@linux-mips.org>; Thu, 15 Aug 2013 00:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=gK9pbm58uDqkM9CbzUaNchAE/uoplWmWY77j7/DHBak=;
        b=cOaq/akZoD3qI7nT1wFThUh5OI+6Ibs/+O3uPOI/KoOBHxrriUz5C2baxQXxC/lFIh
         SVA225wbzHpC+lDDz6UFccSlrEOqGKzob+z/vIbFf3mL4dhhWKvx0vusRu4IimxvJF84
         OpW2wRkNC/BY0//0K1ceVsziwaYc9N8w4Sno16qS8EfPLqxXaFF2nvQ0yzX78l5IGSo2
         0RGcG19YD1TACLrXe0enHWigF5srYikV0PRNzAmjRAZlEp3cT2d2rDmA0Fm8ms3jKqmA
         tde+BTw7JQvrbyO1YF+v1pVxWN++yM0FvgO1pkl1hnsSo52+zgj6RDapYOTO+NdXz6qF
         0TZQ==
MIME-Version: 1.0
X-Received: by 10.14.211.1 with SMTP id v1mr21082091eeo.5.1376553308043; Thu,
 15 Aug 2013 00:55:08 -0700 (PDT)
Received: by 10.15.61.1 with HTTP; Thu, 15 Aug 2013 00:55:07 -0700 (PDT)
In-Reply-To: <520C86BD.2020903@roeck-us.net>
References: <20130813063501.728847844@linuxfoundation.org>
        <520A1D56.2050507@roeck-us.net>
        <20130813175858.GC7336@kroah.com>
        <20130813201936.GA18358@roeck-us.net>
        <20130815063158.GB25754@kroah.com>
        <520C86BD.2020903@roeck-us.net>
Date:   Thu, 15 Aug 2013 09:55:07 +0200
X-Google-Sender-Auth: A9v9jNUB_G31rd-Lw_XLqzWlBwo
Message-ID: <CAMuHMdU+EOC_etihOzUC6N0cqc2qHaGm3_L+gyTRxESCGhOzEg@mail.gmail.com>
Subject: Re: [ 00/17] 3.4.58-stable review
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        stable <stable@vger.kernel.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37550
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

On Thu, Aug 15, 2013 at 9:43 AM, Guenter Roeck <linux@roeck-us.net> wrote:
> I screwed up my stable repo clone again :(, so the full build will take a
> bit.
>
> mips builds on on 3.4 with all patches applied now fail with:
> arch/mips/include/asm/page.h: Assembler messages:
> arch/mips/include/asm/page.h:178: Error: Unrecognized opcode `static inline
> int pfn_valid(unsigned long pfn)'
> arch/mips/include/asm/page.h:179: Error: junk at end of line, first
> unrecognized character is `{'
> arch/mips/include/asm/page.h:181: Error: Unrecognized opcode `extern
> unsigned long max_mapnr'
> arch/mips/include/asm/page.h:183: Error: Unrecognized opcode `return
> pfn>=ARCH_PFN_OFFSET&&pfn<max_mapnr'
> arch/mips/include/asm/page.h:184: Error: junk at end of line, first
> unrecognized character is `}'
>
> This is the error I referred to above. Reverting above pfn rework patch
> fixes that problem,
> so you might want to remove that patch from the patch queue for now.

Perhaps this one got applied too soon?

 commit 730b8dfe016dd1e91f73d8d3e6724da91397171c
Author: Ralf Baechle <ralf@linux-mips.org>
Date:   Fri Dec 28 15:18:02 2012 +0100

    MIPS: page.h: Remove now unnecessary #ifndef __ASSEMBLY__ wrapper.

    Signed-off-by: Ralf Baechle <ralf@linux-mips.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
