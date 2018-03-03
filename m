Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Mar 2018 08:09:14 +0100 (CET)
Received: from forward103p.mail.yandex.net ([77.88.28.106]:53907 "EHLO
        forward103p.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990588AbeCCHJHyRhTB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Mar 2018 08:09:07 +0100
Received: from mxback3j.mail.yandex.net (mxback3j.mail.yandex.net [IPv6:2a02:6b8:0:1619::10c])
        by forward103p.mail.yandex.net (Yandex) with ESMTP id 24EEB2183567;
        Sat,  3 Mar 2018 10:09:01 +0300 (MSK)
Received: from smtp4j.mail.yandex.net (smtp4j.mail.yandex.net [2a02:6b8:0:1619::15:6])
        by mxback3j.mail.yandex.net (nwsmtp/Yandex) with ESMTP id eLUurFvMTi-8wYuEKJm;
        Sat, 03 Mar 2018 10:09:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520060941;
        bh=5a5JcxaGrkDUDO0ty4ou6Ka38CWREAfgxH4PvJXEoo0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=nw1dbv2FxPF/TYv9Onp1DeFaJCedJZIkI8aB4yCbD0oLZeSUxTp4RV7M3elSYWEyx
         iNjRnXJwKGYscL2oybLdUDTMpT5Mv5DZXK9UgpIxd12rdvKWVtaA+tIBDRPj+1Z1nz
         GjCvjubvWlXQ6qFZLJkwVPutluRxgva1Ze7fnuJA=
Received: by smtp4j.mail.yandex.net (nwsmtp/Yandex) with ESMTPSA id QyB7LfSHVd-8mpGvooc;
        Sat, 03 Mar 2018 10:08:56 +0300
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (Client certificate not present)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; s=mail; t=1520060936;
        bh=5a5JcxaGrkDUDO0ty4ou6Ka38CWREAfgxH4PvJXEoo0=;
        h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=jyceJwNDymOfKBpVhCaqUtjb7KxCl1PoxFehHLtNVFQGRLTS18pdJ+PTz6k2TDDpl
         j4IR0i6m8tx0ShHOfNM/sM6nmPWzyfV/F1Dz/Z9FATeH08JKcXRKkpvPgnz8r2aPce
         DNyU1t9mJRMDB7EHzQZc6xmLJBE87WI3I8V8oIyw=
Authentication-Results: smtp4j.mail.yandex.net; dkim=pass header.i=@flygoat.com
Message-ID: <1520060919.13983.3.camel@flygoat.com>
Subject: Re: [PATCH V2 1/2] MIPS: Loongson64: Select
 ARCH_MIGHT_HAVE_PC_PARPORT
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     "Maciej W. Rozycki" <macro@mips.com>,
        Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <james.hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Date:   Sat, 03 Mar 2018 15:08:39 +0800
In-Reply-To: <alpine.DEB.2.00.1803021204250.10166@tp.orcam.me.uk>
References: <1519871862-14624-1-git-send-email-chenhc@lemote.com>
         <alpine.DEB.2.00.1803021204250.10166@tp.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <jiaxun.yang@flygoat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62787
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jiaxun.yang@flygoat.com
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

在 2018-03-02五的 12:07 +0000，Maciej W. Rozycki写道：
> On Wed, 28 Feb 2018, Huacai Chen wrote:
> 
> > diff --git a/arch/mips/loongson64/Kconfig
> > b/arch/mips/loongson64/Kconfig
> > index bc2fdbf..12812a8b 100644
> > --- a/arch/mips/loongson64/Kconfig
> > +++ b/arch/mips/loongson64/Kconfig
> > @@ -7,6 +7,7 @@ choice
> >  config LEMOTE_FULOONG2E
> >  	bool "Lemote Fuloong(2e) mini-PC"
> >  	select ARCH_SPARSEMEM_ENABLE
> > +	select ARCH_MIGHT_HAVE_PC_PARPORT
> >  	select CEVT_R4K
> >  	select CSRC_R4K
> >  	select SYS_HAS_CPU_LOONGSON2E
> 
>  Hmm, I don't think the Fuloong(2e) machine has a parallel port
> connector.  
> The chipset may support the port, but with no external connection I
> think 
> there's no point in enabling it.  Or am I missing something?
Thanks for your advice.
Some other Loongson-2E devices share the same kernel entry with
Fuloong-2E.
And the 2E desktop PC has a parallel port. So we enable it for these
devices.

> 
>   Maciej
> 
-- 
Jiaxun Yang <jiaxun.yang@flygoat.com>
