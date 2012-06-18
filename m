Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Jun 2012 12:10:48 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:49489 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903517Ab2FRKKd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 18 Jun 2012 12:10:33 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTP id 582EE244943;
        Mon, 18 Jun 2012 12:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1340014232; bh=0eoOELngl05vEsY3WrXNhV/lwt2Ix4bVxI/3j5APQPk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=DmIiAU/fpBE2sGWDL7H1kF5mUTxrQKvFMEWhdB
        NJDcLfKsukQPulaGNlHcmeuVtEzioV9ADMX+ainM1WYihqE1OaMA82Z8yf++fxN2qJL
        uyi2gP4kNa1jL8qtTcLSOtLD7qkeoV4faXpm+KM5K5YqiDV8vkLNY6afy3eXlT9fow=
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id JQiSqVeS9lhH; Mon, 18 Jun 2012 12:10:32 +0200 (CEST)
Received: from liondog.tnic (p54B7F985.dip.t-dialin.net [84.183.249.133])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 02748244942;
        Mon, 18 Jun 2012 12:10:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1340014232; bh=0eoOELngl05vEsY3WrXNhV/lwt2Ix4bVxI/3j5APQPk=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To; b=DmIiAU/fpBE2sGWDL7H1kF5mUTxrQKvFMEWhdB
        NJDcLfKsukQPulaGNlHcmeuVtEzioV9ADMX+ainM1WYihqE1OaMA82Z8yf++fxN2qJL
        uyi2gP4kNa1jL8qtTcLSOtLD7qkeoV4faXpm+KM5K5YqiDV8vkLNY6afy3eXlT9fow=
Received: by liondog.tnic (Postfix, from userid 1000)
        id B13F64B8E87; Mon, 18 Jun 2012 12:10:30 +0200 (CEST)
Date:   Mon, 18 Jun 2012 12:10:30 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     huacai chen <chenhuacai@gmail.com>
Cc:     Sergei Shtylyov <sshtylyov@mvista.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Hongliang Tao <taohl@lemote.com>, Hua Yan <yanh@lemote.com>,
        linux-ide@vger.kernel.org
Subject: Re: [PATCH 09/14] ata: Use 32bit DMA in AHCI for Loongson 3.
Message-ID: <20120618101030.GA24308@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
 <20120617120557.GE31534@liondog.tnic>
 <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAAhV-H67M5xH+HMyVNopm=TPhei24NfnzNqiPMA+Ucz4Y7V3hg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33687
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bp@alien8.de
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

On Mon, Jun 18, 2012 at 05:04:14PM +0800, huacai chen wrote:
> Do you means it is a better idea to modify "enum board_ids" and add a
> new board id such as board_ahci_sb700_loongson, and then add a new
> entry in ahci_port_info[]?
> If so, I think there is a problem: the pci id of our AHCI controller
> is 1002:4390, if I add board_ahci_sb700_loongson, then I should also
> add
> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700_loongson },
> in ahci_pci_tbl[], but ahci_pci_tbl[] already has a line
> { PCI_VDEVICE(ATI, 0x4390), board_ahci_sb700 },
> Then which entry will match the device?

Before you do anything, my question is:

SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
need it when you use the same chipset?

So why do you need to do 32-bit DMA only when the chipset supports
64-bit DMA just fine?

Thanks.

-- 
Regards/Gruss,
    Boris.
