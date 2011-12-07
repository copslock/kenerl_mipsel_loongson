Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2011 23:02:43 +0100 (CET)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:64909 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903682Ab1LGWCg convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2011 23:02:36 +0100
Received: by bkcje16 with SMTP id je16so1286545bkc.36
        for <multiple recipients>; Wed, 07 Dec 2011 14:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=sender:from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        bh=tUDSeakOcJcsMIRRA/ZjfzPsf+PlWX4tmuNM0CRsK8k=;
        b=gIhSGcQ/Gc7EqIAwvWd1N/pbwdEJZjBuhgvYqdd03FYZSgJ6eFrW/JzGj0uTfutfW/
         d1XufTLxkt7EG0ELTKwUitGf9Z0Hw/j1RXPNdNJKV6oH9yJOxWyrD20UJQj+N6fFTx03
         fGL3MeLdG1EN7es4IdvCdz3A/lsM/J2vaSWow=
Received: by 10.180.105.232 with SMTP id gp8mr252907wib.65.1323295350907;
        Wed, 07 Dec 2011 14:02:30 -0800 (PST)
Received: from lenovo.localnet ([2a01:e35:2f70:4010:21d:7dff:fe45:5399])
        by mx.google.com with ESMTPS id dy1sm5066515wib.18.2011.12.07.14.02.22
        (version=SSLv3 cipher=OTHER);
        Wed, 07 Dec 2011 14:02:27 -0800 (PST)
From:   Florian Fainelli <florian@openwrt.org>
To:     Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH spi-next] spi: add Broadcom BCM63xx SPI controller driver
Date:   Wed, 7 Dec 2011 23:02:24 +0100
User-Agent: KMail/1.13.7 (Linux/3.1.0-1-amd64; KDE/4.6.5; x86_64; ; )
Cc:     Shubhrajyoti Datta <omaplinuxkernel@gmail.com>,
        Tanguy Bouzeloc <tanguy.bouzeloc@efixo.com>,
        linux-mips@linux-mips.org, ralf@linux-mips.org,
        spi-devel-general@lists.sourceforge.net
References: <1321906615-11392-1-git-send-email-florian@openwrt.org> <201111232041.18477.florian@openwrt.org> <20111207212710.GD3744@pengutronix.de>
In-Reply-To: <20111207212710.GD3744@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Message-Id: <201112072302.25001.florian@openwrt.org>
X-archive-position: 32055
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6304

Hello Wolfram,

Le mercredi 07 décembre 2011 22:27:10, Wolfram Sang a écrit :
> > > Could we move to dev pm ops?
> > 
> > Sure, I have fixed that in version 2 of the patch.
> 
> Have you sent that already?

Not yet, so if you have any other comments, feel free to let me know so that I 
can fold the fixes in version 2 of the patch.

Thanks
-- 
Florian
