Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Jun 2012 10:02:59 +0200 (CEST)
Received: from mail-gg0-f177.google.com ([209.85.161.177]:62014 "EHLO
        mail-gg0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903697Ab2FTICz convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 20 Jun 2012 10:02:55 +0200
Received: by ggcs5 with SMTP id s5so5851112ggc.36
        for <linux-mips@linux-mips.org>; Wed, 20 Jun 2012 01:02:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=xff1qRCaIbDJwnb4nacNRrlXlUW0Z/RhE0SjjX2EowE=;
        b=Itg457aB7xmd77q9p6EqSAnlAoJ3vaDfVLHtRVUm1amJactf/vDu3BZ6mCT5Zdfipw
         W5yAM2K5J5uyOsdPUQlh9UJZoQxBWHJAUcXKHbcYfTKbu0skf6MjQjRzPkEAbzcmzdeW
         YY4zUVWPaaaR07lju2qW/NNfXdpZnkj8TjLnG/aWo9e29TianJXqIGvkhSJlLAvKTQED
         oX5FoZ9tqV7HLwsBzHHjJreNpGumlJrEm9zNnOtOX2KD4ubSplG46ZF6UOAsPrZR/SmA
         r25f2ni5IgGFd4eiqOy0xGOW6UpofHBlc1Yhd6DFn4rLHh+pPYiSjKe0MVe8tOekIFY7
         j09A==
MIME-Version: 1.0
Received: by 10.42.80.6 with SMTP id t6mr5148020ick.15.1340179368926; Wed, 20
 Jun 2012 01:02:48 -0700 (PDT)
Received: by 10.231.135.1 with HTTP; Wed, 20 Jun 2012 01:02:48 -0700 (PDT)
In-Reply-To: <20120620035951.GC5623@linux-sh.org>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
        <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
        <20120620035951.GC5623@linux-sh.org>
Date:   Wed, 20 Jun 2012 10:02:48 +0200
X-Google-Sender-Auth: 5mxhls_2gOQB2-4IvRBq6CxwC_c
Message-ID: <CAMuHMdUmNgBsvVUGsfwKgVq2CfCnOje_4ZUSoig=vSbhN4vSJA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v3.5-rc3
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Paul Mundt <lethal@linux-sh.org>
Cc:     linux-kernel@vger.kernel.org,
        Linuxppc-dev <linuxppc-dev@ozlabs.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        Chris Zankel <chris@zankel.net>,
        Giuseppe Cavallaro <peppe.cavallaro@st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 33738
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Wed, Jun 20, 2012 at 5:59 AM, Paul Mundt <lethal@linux-sh.org> wrote:
> On Sun, Jun 17, 2012 at 09:56:59PM +0200, Geert Uytterhoeven wrote:
>> On Sun, Jun 17, 2012 at 9:46 PM, Geert Uytterhoeven
>> <geert@linux-m68k.org> wrote:
>> > JFYI, when comparing v3.5-rc3 to v3.5-rc2[3], the summaries are:
>> > ??- build errors: +235/-10
>>
>> Truckloads of powerpc "Unrecognized opcode" breakage, and
>>
> That was my fault, should be fixed up by 2603efa31a.
>
>>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
>> declaration of function 'pci_iomap'
>> [-Werror=implicit-function-declaration]:  => 90:3
>>   + drivers/net/ethernet/stmicro/stmmac/stmmac_pci.c: error: implicit
>> declaration of function 'pci_iounmap'
>> [-Werror=implicit-function-declaration]:  => 142:2
>>
> Not sure about this one, it should find everything alright via:
>
>        linux/io.h -> asm/io.h -> asm-generic/iomap.h -> asm-generic/pci_iomap.h
>
> in the case that PCI is enabled. None of allyesconfig/modconfig enable
> PCI for me though, so I'm unsure of how you got in to this configuration
> to begin with?

These were xtensa, not sh.

The ones above ("error: expected expression before 'do'") were sh.

>>   + error: "__ashrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
>>   + error: "__lshrdi3" [fs/ntfs/ntfs.ko] undefined!:  => N/A
>>
>> sh4/landisk_defconfig
>>
>>   + error: "__ashrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
>>   + error: "__lshrdi3" [drivers/mtd/mtd.ko] undefined!:  => N/A
>>   + error: "__lshrdi3" [fs/xfs/xfs.ko] undefined!:  => N/A
>>
> These seem to be the same issue on both platforms, EXPORT_SYMBOL()
> doesn't work from lib-y. While it's straightforward to fix, I'm not able
> to reproduce __lshrdi3/__ashrdi3 references in any of the above, which
> compiler are you using?

http://kisskb.ellerman.id.au/kisskb/buildresult/6543287/ says
sh4-linux-gcc (GCC) 4.6.3

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
