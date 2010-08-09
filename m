Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Aug 2010 07:15:17 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:64063 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491151Ab0HIFPN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Aug 2010 07:15:13 +0200
Received: by iwn3 with SMTP id 3so3842949iwn.36
        for <multiple recipients>; Sun, 08 Aug 2010 22:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=/gYRndlf6WrC/riBaCbtWWeGawIEObsdB+5/4jtFqxk=;
        b=ZhJZ76d9SXqEnWkq99x/lhqtGlCkYeFFvAq1bWalp25HbVtfnTKAfjtIXbb6YhEvsI
         RO913NVAy+l1C6tOVzDinSJZFosNMxG/D6+ChQfePByvete0xbCG3VNLkF/2OcVpxWgQ
         0mdt/yNYWENa0s9eZ9frfmdZGO/Lb72RXQCrk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        b=o5X8c7KeO2Smtvje2x2bucOftwQlAQfzmMSkVYKcMegI3rqbE8VzmAV3Dfy9E1HRFz
         awb9VGL1qBlm1UeQOxsya1W5E8r9fMNeX7SoSt3uuUS+yQgzlWXv82YRB483246IxgzW
         DSgOxW1+SufVdujBVBY/9/NrPyHKMZvvnxa/w=
Received: by 10.231.152.210 with SMTP id h18mr18656422ibw.18.1281330911034;
        Sun, 08 Aug 2010 22:15:11 -0700 (PDT)
Received: from dd_xps.caveonetworks.com (adsl-67-127-52-52.dsl.pltn13.pacbell.net [67.127.52.52])
        by mx.google.com with ESMTPS id g31sm4295492ibh.16.2010.08.08.22.15.08
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 08 Aug 2010 22:15:09 -0700 (PDT)
Message-ID: <4C5F8ED8.90301@gmail.com>
Date:   Sun, 08 Aug 2010 22:15:04 -0700
From:   David Daney <david.s.daney@gmail.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.7) Gecko/20100720 Fedora/3.1.1-1.fc13 Thunderbird/3.1.1
MIME-Version: 1.0
To:     Namhyung Kim <namhyung@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-kernel@vger.kernel.org,
        David Daney <ddaney@caviumnetworks.com>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: remove RELOC_HIDE on __pa_symbol
References: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
In-Reply-To: <1281297456-2711-1-git-send-email-namhyung@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <david.s.daney@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27607
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.s.daney@gmail.com
Precedence: bulk
X-list: linux-mips

  On 08/08/2010 12:57 PM, Namhyung Kim wrote:
> remove unneccessary use of RELOC_HIDE(). It does simple addition of ptr and
> offset and in this case (offset 0) does practically nothing. It does NOT do
> anything with linker relocation.
>

Maybe you could explain in more detail the problems you are having with 
the current definition of __pa_symbol().  I would be hesitant to change 
this bit of black magic unless there is a concrete problem you are 
trying to solve.

David Daney


> Signed-off-by: Namhyung Kim<namhyung@gmail.com>
> ---
>   arch/mips/include/asm/page.h |    2 +-
>   1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/arch/mips/include/asm/page.h b/arch/mips/include/asm/page.h
> index a16beaf..f7e2684 100644
> --- a/arch/mips/include/asm/page.h
> +++ b/arch/mips/include/asm/page.h
> @@ -150,7 +150,7 @@ typedef struct { unsigned long pgprot; } pgprot_t;
>       ((unsigned long)(x) - PAGE_OFFSET + PHYS_OFFSET)
>   #endif
>   #define __va(x)		((void *)((unsigned long)(x) + PAGE_OFFSET - PHYS_OFFSET))
> -#define __pa_symbol(x)	__pa(RELOC_HIDE((unsigned long)(x), 0))
> +#define __pa_symbol(x)	__pa(x)
>
>   #define pfn_to_kaddr(pfn)	__va((pfn)<<  PAGE_SHIFT)
>
