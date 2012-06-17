Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Jun 2012 14:06:04 +0200 (CEST)
Received: from mail.skyhub.de ([78.46.96.112]:57503 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903505Ab2FQMGA (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 17 Jun 2012 14:06:00 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5FB691D9973;
        Sun, 17 Jun 2012 14:05:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1339934759; bh=cPRh51WkOXfK8w8vbtEfaBqwXDhEQTpmyo06Z4uRfTc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To; b=Wa9+CJynFpBM
        CRUKrlFhbdao+oLAkeHBkVMy6sCf5pn9G4qY2Iqh/VzgYMd8kNDyiGLK3OvXWqTOtw/
        RNIJroFZU03ULtk6SqU5v/Lds39MmgNI6E+XOJ1ksVvwniE3sNAJEd1U8DL6asjlkiw
        +mF0si654T6GfAwiqjOFQR0I8=
X-Virus-Scanned: Nedap ESD1 at mail.skyhub.de
Received: from mail.skyhub.de ([127.0.0.1])
        by localhost (door.skyhub.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id LeDLv2BrhAs6; Sun, 17 Jun 2012 14:05:59 +0200 (CEST)
Received: from liondog.tnic (p4FF1D122.dip.t-dialin.net [79.241.209.34])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C6B081D996B;
        Sun, 17 Jun 2012 14:05:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=alien8.de; s=alien8;
        t=1339934759; bh=cPRh51WkOXfK8w8vbtEfaBqwXDhEQTpmyo06Z4uRfTc=;
        h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
         Content-Type:Content-Transfer-Encoding:In-Reply-To; b=Wa9+CJynFpBM
        CRUKrlFhbdao+oLAkeHBkVMy6sCf5pn9G4qY2Iqh/VzgYMd8kNDyiGLK3OvXWqTOtw/
        RNIJroFZU03ULtk6SqU5v/Lds39MmgNI6E+XOJ1ksVvwniE3sNAJEd1U8DL6asjlkiw
        +mF0si654T6GfAwiqjOFQR0I8=
Received: by liondog.tnic (Postfix, from userid 1000)
        id 0F33D4B8E7B; Sun, 17 Jun 2012 14:05:58 +0200 (CEST)
Date:   Sun, 17 Jun 2012 14:05:57 +0200
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
Message-ID: <20120617120557.GE31534@liondog.tnic>
References: <1339747801-28691-1-git-send-email-chenhc@lemote.com>
 <1339747801-28691-10-git-send-email-chenhc@lemote.com>
 <4FDB08AC.8010208@mvista.com>
 <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAhV-H6AKp+aGUozOxQoLgGYQ+GtHMbKKC4MVkFA570zodjgDA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-archive-position: 33679
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

On Fri, Jun 15, 2012 at 08:42:47PM +0800, huacai chen wrote:
> On Fri, Jun 15, 2012 at 6:04 PM, Sergei Shtylyov <sshtylyov@mvista.com> wrote:
> > Hello.
> >
> >
> > On 15-06-2012 12:09, Huacai Chen wrote:
> >
> >> Signed-off-by: Huacai Chen<chenhc@lemote.com>
> >> Signed-off-by: Hongliang Tao<taohl@lemote.com>
> >> Signed-off-by: Hua Yan<yanh@lemote.com>
> >
> >
> >   You  should have CCed the 'linux-ide' mailing list.
> >
> >
> >> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> >> index ebaf67e..3e3cfd8 100644
> >> --- a/drivers/ata/ahci.c
> >> +++ b/drivers/ata/ahci.c
> >> @@ -183,7 +183,12 @@ static const struct ata_port_info ahci_port_info[] =
> >> {
> >>        },
> >>        [board_ahci_sb700] =    /* for SB700 and SB800 */
> >>        {
> >> +#ifndef CONFIG_CPU_LOONGSON3
> >>                AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL),
> >> +#else
> >> +               AHCI_HFLAGS     (AHCI_HFLAG_IGN_SERR_INTERNAL |
> >> +                                               AHCI_HFLAG_32BIT_ONLY),
> >> +#endif
> >
> >
> >   No, this #ifdef'ery won't do. You should add a new board type.
> All Loongson-3 based machines use AMD SB700 chipsets, add a new board
> type is better than #ifdef?

SB700/800 chipsets don't need to set a 32-bit only DMA flag; why do you
need it when you use the same chipset?

-- 
Regards/Gruss,
    Boris.
