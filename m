Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Apr 2016 10:54:14 +0200 (CEST)
Received: from mail-io0-f193.google.com ([209.85.223.193]:33479 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006687AbcDJIyKI0ZUB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Apr 2016 10:54:10 +0200
Received: by mail-io0-f193.google.com with SMTP id g185so22121182ioa.0;
        Sun, 10 Apr 2016 01:54:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc;
        bh=5mDPrzMlQO21oTn6CPToTYwRmUrVVi87gjVXn4cfbbU=;
        b=khdKYiVQeXr4dTfe9uBpE6TIsahMqRGWVUc13gOPHy3EaOLoIZcOzeLmMz0zrqb6Kz
         dAlurPGb96uA1KULOZNhqr/ThEkGYQ0KkOVShXXBnecNsetrWtPZ3KQwlx39BdxAIDf0
         CubU+okxTgj34gYzzXMd9qHswC9aFzf9wIxjIyh1Jzxz6hzkSwPjR8unMGH4oNeIQzdZ
         AsRJBBDfDC9TI5ZrRkUksWP+78S3NI4TfEr0I6d22sYiJGevfLR93DR96TYAjz5uf8Ai
         oWlUGedM3kmmuuHh5rmxVNLxjh6Cj/qQoF+mabMXFGe/uS58zRuR3ci4bZXQoGS5WxPM
         85sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:date
         :message-id:subject:from:to:cc;
        bh=5mDPrzMlQO21oTn6CPToTYwRmUrVVi87gjVXn4cfbbU=;
        b=gMEXh0UhR7bNvfSbgnBQvKOgp0cCaL7+gaOL2j79KdzNA1oSdH+Cz6BxQl6Exs2R+t
         3Pi7BPEV78rd3faVGQQlI1GuYn7e/POSbOjbZAlQKNZ+Nn+bQUdRO0Ietjr+C2TdoQA7
         lHtBQfStddjxQo7UqAIMdnHUcl9PIhKVM10UJo1pL77EDtOp+5Roq7byyEE6y0sBDMI/
         fGgK1N9tYjhw9gZKKhdlzM2bFAI9emtRc3biy+5EvlhtOKZnpRedDqIufiViRhqgAtty
         E1SLrqbRXWR7G2aE3EFMf5LFSdHGaTAwDcYwztXUk4kRL8X/PYlTrdr5i3kail+h75P8
         2HGQ==
X-Gm-Message-State: AD7BkJLa8zrqxS12ZU77geAk/fvfQKsofX15FhHYBk+e0xJ3t1SGRcRtdyQZ5De/eQsnP+O58SoFI5dPrYXtxA==
MIME-Version: 1.0
X-Received: by 10.107.6.6 with SMTP id 6mr20184646iog.24.1460278444330; Sun,
 10 Apr 2016 01:54:04 -0700 (PDT)
Received: by 10.36.73.106 with HTTP; Sun, 10 Apr 2016 01:54:04 -0700 (PDT)
In-Reply-To: <1458218233-12129-1-git-send-email-chenhc@lemote.com>
References: <1458218233-12129-1-git-send-email-chenhc@lemote.com>
Date:   Sun, 10 Apr 2016 16:54:04 +0800
X-Google-Sender-Auth: f_62tDtNetjULuCJQT57BUiRrdk
Message-ID: <CAAhV-H6Fayot_LLi-LjUGe5Bq0oz0z=fTrxj6R-UqUO8h0sE4Q@mail.gmail.com>
Subject: Re: [PATCH V3 1/4] MIPS: Reserve nosave data for hibernation
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Aurelien Jarno <aurelien@aurel32.net>,
        "Steven J . Hill" <Steven.Hill@imgtec.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        stable <stable@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Hi, Ralf,

This series is bugfix for Loongson, please merge it if no problem.

Huacai

On Thu, Mar 17, 2016 at 8:37 PM, Huacai Chen <chenhc@lemote.com> wrote:
> After commit 92923ca3aacef63c92d ("mm: meminit: only set page reserved
> in the memblock region"), the MIPS hibernation is broken. Because pages
> in nosave data section should be "reserved", but currently they aren't
> set to "reserved" at initialization. This patch makes hibernation work
> again.
>
> Cc: stable@vger.kernel.org
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/setup.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/arch/mips/kernel/setup.c b/arch/mips/kernel/setup.c
> index 4f60734..d20caac 100644
> --- a/arch/mips/kernel/setup.c
> +++ b/arch/mips/kernel/setup.c
> @@ -706,6 +706,9 @@ static void __init arch_mem_init(char **cmdline_p)
>         for_each_memblock(reserved, reg)
>                 if (reg->size != 0)
>                         reserve_bootmem(reg->base, reg->size, BOOTMEM_DEFAULT);
> +
> +       reserve_bootmem_region(__pa_symbol(&__nosave_begin),
> +                       __pa_symbol(&__nosave_end)); /* Reserve for hibernation */
>  }
>
>  static void __init resource_init(void)
> --
> 2.7.0
>
>
>
>
>
