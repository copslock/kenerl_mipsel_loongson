Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 11:04:30 +0200 (CEST)
Received: from mail-lb0-f177.google.com ([209.85.217.177]:59063 "EHLO
        mail-lb0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903521Ab2FRJEU convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2012 11:04:20 +0200
Received: by lbbgg6 with SMTP id gg6so4327584lbb.36
        for <multiple recipients>; Mon, 18 Jun 2012 02:04:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=34uWQfTvaCD6bXTBfypjX9BURVS2aeegTaGcGorlqPE=;
        b=A8abLL5PAx8/X4HaTDk1Pza0aLtxEmMt8S2PtEVY21zjVlEl4/xpnF5/Ac4nFBe6tL
         2a5SRIFy4bye68/WWa4u+iDX+Y23Bf+7MnMOfME8w8yRjx3NpJQD53yRJxrb9IqJmPyY
         wVWZDaBgR28YGPA2B+Oz9TQFjdA3jaNIYhDq6yYagZAX1OcclHzvsEK2czzCrBy4SgjC
         YIosM272kNffPqkaY8O/vEQXSAtISQWw2+NBWbMNKBZ8bjigKkKbMzxHjZj4+L2ASK5I
         aR2g6iDph8jHMTJHVRFqwj4sqjZtf1gNkcrFRZXnaeq74CFg8CmTk4Lp52q0LAyzjefn
         VmIA==
MIME-Version: 1.0
Received: by 10.152.122.9 with SMTP id lo9mr13741268lab.41.1340010254885; Mon,
 18 Jun 2012 02:04:14 -0700 (PDT)
Received: by 10.152.5.103 with HTTP; Mon, 18 Jun 2012 02:04:14 -0700 (PDT)
In-Reply-To: <20120617120557.GE31534@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
        <1339747801-28691-10-git-send-email-chenhc@lemote.com>
        <4FDB08AC.8010208@mvista.com>
        <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
        <20120617120557.GE31534@liondog.tnic>
Date:   Mon, 18 Jun 2012 17:04:14 +0800
Message-ID: <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
From:   huacai chen <chenhuacai@gmail.com>
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
X-archive-position: 33684
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

Do you means it is a better idea to modify "enum board_ids" and add a
new board id such as board_ahci_sb700_loongson, and then add a new
entry in ahci_port_info[]?
If so, I think there is a problem: the pci id of our AHCI controller
is 1002:4390, if I add board_ahci_sb700_loongson, then I should also
add
{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700_loongson },
in ahci_pci_tbl[], but ahci_pci_tbl[] already has a line
{ PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 },
Then which entry will match the device?

On Sun, Jun 17, 2012 at 8:05 PM, Borislav Petkov <bp@alien8.de> wrote:
> On Fri, Jun 15, 2012 at 08:42:47PM +0800, huacai chen wrote:
>> On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
>> > Hello.
>> >
>> >
>> > On 15-06-2012 12:09, Huacai Chen wrote:
>> >
>> >> Signed-off-by: Huacai Chen<chenhc@lemote.com>
>> >> Signed-off-by: Hongliang Tao<taohl@lemote.com>
>> >> Signed-off-by: Hua Yan<yanh@lemote.com>
>> >
>> >
>> >   You  should have CCed the 'linux-ide' mailing list.
>> >
>> >
>> >> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
>> >> index ebaf67e..3e3cfd8 100644
>> >> --- a/drivers/ata/ahci.c
>> >> +++ b/drivers/ata/ahci.c
>> >> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] =
>> >> {
>> >>        },
>> >>        [board_ahci_sb700] =    /* for SB700 and SB800 */
>> >>        {
>> >> +#ifndef CONFIG_CPU_LOONGSON3
>> >>                AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL),
>> >> +#else
>> >> +               AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL |
>> >> +                                               AHCI_HFLAG_32BIT_ONLY),
>> >> +#endif
>> >
>> >
>> >   No, this #ifdef'ery won't do. You should add a new board type.
>> All Loongson-3 based machines use AMD SB700 chipsets, add a new board
>> type is better than #ifdef?
>
> SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
> need it when you use the same chipset?
>
> --
> Regards/Gruss,
>    Boris.
