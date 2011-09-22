Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 18:49:01 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:52216 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491914Ab1IVQsy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 18:48:54 +0200
Received: by wwf27 with SMTP id 27so2067989wwf.24
        for <multiple recipients>; Thu, 22 Sep 2011 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:organization:to:subject:date:user-agent:cc:references
         :in-reply-to:mime-version:content-type:content-transfer-encoding
         :message-id;
        bh=kRT2VbomZYhDGmXUmDPtJ8zEFrZpQ1Do/Qyh6+nINpc=;
        b=mLrbDg4JPBIIgPqY/y1U9H6LnAH0JZ9mJXi2GUosqa/64WonXSBBgsZFtRxZYJ8PrS
         rBq7CbjEhwcCHSYeWiuoMI53ENUYKFwbzwwmwg+vc9w/JRXhVwCof470OZxS5E6t2PSn
         ImDo9H7UOK2nGogC2faT0N2MRXsCgs7xuMOV8=
Received: by 10.216.220.216 with SMTP id o66mr2481968wep.52.1316710129485;
        Thu, 22 Sep 2011 09:48:49 -0700 (PDT)
Received: from flexo.localnet (bobafett.staff.proxad.net. [213.228.1.121])
        by mx.google.com with ESMTPS id o7sm12324349wbh.8.2011.09.22.09.48.47
        (version=SSLv3 cipher=OTHER);
        Thu, 22 Sep 2011 09:48:48 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
To:     Sergei Shtylyov <sshtylyov@mvista.com>
Subject: Re: [PATCH 2/5] MIPS: bcm63xx: fix SDRAM size computation for BCM6345
Date:   Thu, 22 Sep 2011 18:48:22 +0200
User-Agent: KMail/1.13.6 (Linux/2.6.38-11-server; KDE/4.6.2; x86_64; ; )
Cc:     ralf@linux-mips.org, linux-mips@linux-mips.org
References: <1316612390-6367-1-git-send-email-florian@openwrt.org> <1316612390-6367-3-git-send-email-florian@openwrt.org> <4E7B0C02.7060703@mvista.com>
In-Reply-To: <4E7B0C02.7060703@mvista.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201109221848.22794.florian@openwrt.org>
X-archive-position: 31127
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12681

On Thursday 22 September 2011 12:20:50 Sergei Shtylyov wrote:
> Hello.
> 
> On 21-09-2011 17:39, Florian Fainelli wrote:
> > From: Florian Fainelli<ffainelli@freebox.fr>
> > 
> > Instead of hardcoding the amount of available RAM, read the number of
> > effective multiples of 8MB from SDRAM_MBASE_REG.
> > 
> > Signed-off-by: Florian Fainelli<florian@openwrt.org>
> > ---
> > 
> >   arch/mips/bcm63xx/cpu.c |    6 ++++--
> >   1 files changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
> > index 7c7e4d4..7ad1b39 100644
> > --- a/arch/mips/bcm63xx/cpu.c
> > +++ b/arch/mips/bcm63xx/cpu.c
> > @@ -260,8 +260,10 @@ static unsigned int detect_memory_size(void)
> > 
> >   	unsigned int cols = 0, rows = 0, is_32bits = 0, banks = 0;
> >   	u32 val;
> > 
> > -	if (BCMCPU_IS_6345())
> > -		return (8 * 1024 * 1024);
> > +	if (BCMCPU_IS_6345()) {
> > +		val = bcm_sdram_readl(SDRAM_MBASE_REG);
> > +		return (val * 8 * 1024 * 1024);
> 
>     Parens not needed here.

For consistency with other parts of the code, I would rather keep it.
-- 
Florian
