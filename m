Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Jun 2012 15:54:05 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:48246 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903750Ab2FMNx5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Jun 2012 15:53:57 +0200
Received: by eekd17 with SMTP id d17so239216eek.36
        for <multiple recipients>; Wed, 13 Jun 2012 06:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:organization:user-agent
         :in-reply-to:references:mime-version:content-transfer-encoding
         :content-type;
        bh=HmdIdV+OibcsjCNTOWh3D0QQ8p6JAJQDPnNfd2V0WOg=;
        b=Q2mmHg0Kdv7ZKNPF9zr1XJrdGWn5hT1IuotU9Uf7Al9/GXtRGz0pY0TcxGIITC+Isf
         adw7Jqqoi+cFJiaFhNRhofbv6dOpOecqZ02L01VaYRdzPEDlrmiy1m5GnWMax1eP0QKJ
         xmDHWYcaHxLSD6aYSPYMD/EsK48vfziPk2pb0Mh9umpDPY+TZX5TEgJXVz5P4kvNWOVR
         gJQ2BCmmEj+mTkIlltHcQxoTago9aUQDwlkDGFxBC9SeKp/dIXpzsFNsIM70Ify4qAWV
         zKJKr5Iv0Z/3oJ7hBO3ZHk/9PGVc0y+l/focMsak4dWWoiicCiyFKvnOljIRlkmsgEh0
         EFHw==
Received: by 10.14.99.200 with SMTP id x48mr7869971eef.194.1339595631898;
        Wed, 13 Jun 2012 06:53:51 -0700 (PDT)
Received: from flexo.localnet ([2a01:e34:ec0d:4090:61f1:e1a1:6584:8ef2])
        by mx.google.com with ESMTPS id n52sm7865245eeh.9.2012.06.13.06.53.48
        (version=SSLv3 cipher=OTHER);
        Wed, 13 Jun 2012 06:53:49 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Jonas Gorski <jonas.gorski@gmail.com>, linux-mips@linux-mips.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: Re: [PATCH 1/8] MIPS: BCM63XX: move flash registration out of board_bcm963xx.c
Date:   Wed, 13 Jun 2012 15:51:30 +0200
Message-ID: <2177534.JpaDVG7JnB@flexo>
Organization: OpenWrt
User-Agent: KMail/4.8.3 (Linux/3.2.0-24-generic; KDE/4.8.3; x86_64; ; )
In-Reply-To: <20120613134801.GA5516@linux-mips.org>
References: <1339489425-19037-1-git-send-email-jonas.gorski@gmail.com> <1339489425-19037-2-git-send-email-jonas.gorski@gmail.com> <20120613134801.GA5516@linux-mips.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33623
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

Hi Ralf,

On Wednesday 13 June 2012 14:48:01 Ralf Baechle wrote:
> On Tue, Jun 12, 2012 at 10:23:38AM +0200, Jonas Gorski wrote:
> 
> > board_bcm963xx.c is already large enough.
> 
> And the grand cure for that sort of issue is FDT - we by now have built
> big deserts of code just registering platform devices like this..  See
> John Crispin's Lantiq work or David's Cavium code for FDT examples.

I have some patches to convert bcm63xx to FDT but that is still work in 
progress, and I don't want them to hold support for newer BCM63xx CPUs.

> 
> > +int __init bcm63xx_flash_register(void)
> > +{
> > +	u32 val;
> > +
> > +	/* read base address of boot chip select (0) */
> > +	val = bcm_mpi_readl(MPI_CSBASE_REG(0));
> > +	val &= MPI_CSBASE_BASE_MASK;
> > +
> > +	mtd_resources[0].start = val;
> > +	mtd_resources[0].end = 0x1FFFFFFF;
> > +
> > +	return platform_device_register(&mtd_dev);
> > +}
> > diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h 
b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
> > new file mode 100644
> > index 0000000..8dcb541
> > --- /dev/null
> > +++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_flash.h
> > @@ -0,0 +1,6 @@
> > +#ifndef __BCM63XX_FLASH_H
> > +#define __BCM63XX_FLASH_H
> > +
> > +int __init bcm63xx_flash_register(void);
> 
> Don't use __init in declarations.  It doesn't make any difference to the
> compiler but it may cause build errors if <linux/init.h> has not been
> included before which this file doesn't.
> 
> > +#endif /* __BCM63XX_FLASH_H */
> 
> I suggest to make bcm63xx_flash_register an arch_initcall.  It already is
> being called indirectly from an bcm63xx_flash_register() so this would
> allow making the function static, get rid of bcm63xx_dev_flash.h which
> only exists to silence checkpatch warnings and make board_register_devices
> a little cleaner.

Well, yes, this makes it easier, but this is not robust, because you rely on 
the function alphabetical name to make sure that everything gets registered in 
the right order. Plus, the big advantage of letting this code separate and 
explicitely called, is to let out-of-tree boards use it as they wish too.

> 
>   Ralf
> 
> PS: Don't forget about FDT :-)  Eventually, not necessarily now.
-- 
Florian
