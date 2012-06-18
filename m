Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 12:42:08 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:43783 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903022Ab2FRKmE convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2012 12:42:04 +0200
Received: by lbbgg6 with SMTP id gg6so4383227lbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 03:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=KgZbhDJGicIZSD6KxPdbB4rSQCKws9Jisf5/7UD+XCg=;
        b=z65Im2sMDwwAjlMZBTm1ME7u94jFDxTlCk5xkUTFrq3jcSQtuvE8i82/VpW4RLNsYv
         UhO+BGlr8Da37SM8eL+4yZgqprqw1fn/BDVmLGzPkoFyYASMGc2ZwsB015NUY5RD4iif
         ZuhqSs46FTJbI+ksMHxjmFt3yPDv6mhQI2qKi46Qbp4dVtGzwQudRKlEUUz4tx5tCIvD
         wtPFmSVanxP52x6pwu4aNvxUfdygouO2rnHSZnYIyWGmgdPgtm2B0RPKfTQOt1XfV2kQ
         P1NBqKXecPnN7bOHpx4xtQ9cPGemauK/ePZnmcgvKn7iS7OsaOsaQAqUhLoLjXNq6XqT
         HyrQ==
MIME-Version: 1.0
Received: by 10.112.46.9 with SMTP id r9mr6184266lbm.81.1340016118995; Mon, 18
 Jun 2012 03:41:58 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Mon, 18 Jun 2012 03:41:58 -0700 (PDT)
In-Reply-To: <20120618101030.GA24308@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-10-git-send-email-chenhc@lemote.com>
        <4FDB08AC.8010208@mvista.com>
        <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
        <20120617120557.GE31534@liondog.tnic>
        <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
        <20120618101030.GA24308@liondog.tnic>
Date:   Mon, 18 Jun 2012 18:41:58 +0800
Message-ID: <CAAhV-H5g2Y81fr=yU76RHDfzDSxG_7GpTs=RZm8ha8JbzHnfzQ@mail.gmail.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
From:   Huacai Chen <chenhuacai@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 33688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhuacai@gmail.com
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

Ohh, this is because Loongson-3 has a hardware bug, when the HT
controller receive a 64-bit DMA address, the high bits is lost. So set
to 32-bit DMA is just a workaround.

I'm sorry that I didn't describe this clearly.

On Mon, Jun 18, 2012 at 6:10 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Mon, Jun 18, 2012 at 05:04:14PM +0800, huacai chen wrote:
>> Do you means it is a better idea to modify "enum board_ids" and add a
>> new board id such as board_ahci_sb700_loongson, and then add a new
>> entry in ahci_port_info[]?
>> If so, I think there is a problem: the pci id of our AHCI controller
>> is 1002:4390, if I add board_ahci_sb700_loongson, then I should also
>> add
>> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700_loongson },
>> in ahci_pci_tbl[], but ahci_pci_tbl[] already has a line
>> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 },
>> Then which entry will match the device?
>
> Before you do anything, my question is:
>
> SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
> need it when you use the same chipset?
>
> So why do you need to do 32-bit DMA only when the chipset supports
> 64-bit DMA just fine?
>
> Thanks.
>
> --
> Regards/Gruss,
>    Boris.
