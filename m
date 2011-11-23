Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2011 13:03:54 +0100 (CET)
Received: from mail-vx0-f177.google.com ([209.85.220.177]:38951 "EHLO
        mail-vx0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903548Ab1KWMDr convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Nov 2011 13:03:47 +0100
Received: by vcbfo13 with SMTP id fo13so1460449vcb.36
        for <multiple recipients>; Wed, 23 Nov 2011 04:03:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=JGbvewXEe/X8NiZIiY5BO4eOHlY1Z/Xyr5reE/WeTzM=;
        b=OsI6suZ5TyE4OqJH1a75OGfc4RcJxt0DjpJ0WjkxsxKnBDiqDcVRGXqSYCk/y3QOJY
         /095gbBhc6PEu6e9imhM5/dQTHxRpmB8WKm/6EV0Cbt2ORkQngNZc6eNNRl6eKkbSWON
         Go7iu+iV1FNYDeVrNLyGA9qeMa8IWN8nPpD2E=
MIME-Version: 1.0
Received: by 10.182.145.38 with SMTP id sr6mr7612696obb.65.1322049821780; Wed,
 23 Nov 2011 04:03:41 -0800 (PST)
Received: by 10.182.36.133 with HTTP; Wed, 23 Nov 2011 04:03:41 -0800 (PST)
In-Reply-To: <4ECCDDF1.7060605@openwrt.org>
References: <1321887999-14546-1-git-send-email-juhosg@openwrt.org>
        <1321887999-14546-5-git-send-email-juhosg@openwrt.org>
        <CAEWqx5-05WSPYfWOO=TBtQAJ0NmvCGvtJ1LEgfiJ3UdzJF+q2g@mail.gmail.com>
        <4ECCDDF1.7060605@openwrt.org>
Date:   Wed, 23 Nov 2011 13:03:41 +0100
Message-ID: <CAEWqx58pY6xpNRsTj0b01=g-JxQdTpbT=OMMLFsPFwk8EPHHKA@mail.gmail.com>
Subject: Re: [PATCH v4 4/7] MIPS: ath79: add a common PCI registration function
From:   =?UTF-8?Q?Ren=C3=A9_Bolldorf?= <xsecute@googlemail.com>
To:     Gabor Juhos <juhosg@openwrt.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 31950
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: xsecute@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 19837

That is in 'arch/mips/include/asm/mach-ath79'.
A error in the patch?

2011/11/23 Gabor Juhos <juhosg@openwrt.org>:
> 2011.11.23. 11:34 keltezéssel, René Bolldorf írta:
>> And where is 'arch/mips/ath79/pci.h' ?
>
> That is introduced in the previous (3/7) patch.
>
