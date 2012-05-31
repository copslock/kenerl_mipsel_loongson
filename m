Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 May 2012 15:58:01 +0200 (CEST)
Received: from mail-ee0-f49.google.com ([74.125.83.49]:64602 "EHLO
        mail-ee0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903658Ab2EaN5w (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 31 May 2012 15:57:52 +0200
Received: by eekd17 with SMTP id d17so510189eek.36
        for <linux-mips@linux-mips.org>; Thu, 31 May 2012 06:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:user-agent:in-reply-to
         :references:mime-version:content-transfer-encoding:content-type;
        bh=IYDk8xho202wbUT2DdKOfwSoKyYSBzqDyzq8vOWzorY=;
        b=dQU/3aCZndpghk9+ihe3tiaQz5/N3N13Nmz2WnhfWIrLQrE7XSZFzFOahC07dXx0oq
         n9OjYFqjwvjWBbdVFOjlRVB/Qm7aLQz9RZQEn6q/lDJscdrxmnXiO6JsD6H4TFgTbqRx
         RhLBdq9ud/qDJshKo74sf5W3T+n7xDPdyRKtU5pZ+xNusA+4VeYd2R2q7T2T76t+Ec80
         B4N3PZYn5p2P2+oDDnDwjfaPviwE7lWrwRa4xqE3w1+rWO3Oeu8FFzpGCa7DvP5yPtjG
         Xq+H6xNuVV7cxJClM8GAfdV1Dvt+ei1iXqKqy1kzuEEqpaZTdtXATIiVERPWy0EfQ+Yu
         PgRQ==
Received: by 10.14.39.8 with SMTP id c8mr3355064eeb.55.1338472666669;
        Thu, 31 May 2012 06:57:46 -0700 (PDT)
Received: from flexo.localnet (freebox.vlq16.iliad.fr. [213.36.7.13])
        by mx.google.com with ESMTPS id g51sm10777937eea.14.2012.05.31.06.57.42
        (version=SSLv3 cipher=OTHER);
        Thu, 31 May 2012 06:57:42 -0700 (PDT)
From:   Florian Fainelli <florian@openwrt.org>
To:     Rogier Wolff <R.E.Wolff@bitwizard.nl>
Cc:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: BCM36xx support.
Date:   Thu, 31 May 2012 15:55:34 +0200
Message-ID: <7383662.i0oNtC19fQ@flexo>
User-Agent: KMail/4.8.2 (Linux/3.2.0-24-generic; KDE/4.8.2; x86_64; ; )
In-Reply-To: <20120418055139.GA25952@bitwizard.nl>
References: <20120418055139.GA25952@bitwizard.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-archive-position: 33501
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

Hi Rogier,

First of all, you should have CC'd linux-mips, because that's where BCM63xx 
development happens.

On Wednesday 18 April 2012 07:51:40 Rogier Wolff wrote:
> 
> While working on SPI and I2C support for the BCM2835, I found the
> BCM63xx SPI driver in the kernel. Turns out that this support
> was partially merged: 
> 
> The support can only be enabled when BCM63xx configuration symbol
> is defined which menuconfig lists as: 
> 
>  Symbol: BCM63XX [=BCM63XX]                                                
>    Type  : unknown                                                           
> 
> I'd say the definition of this is not possible through the normal
> channels.
> 
> And in the driver (drivers/spi/spi-bcm63xx.c) I see: 
> 
> #include <bcm63xx_dev_spi.h>
> 
> but that file is not in the current git release.

No, it did not make it for a reason I ignore, probably miscommunication.

> 
> (some more googling has resulted in me finding out that I don't want
> to know how the 63xx SPI controller works as it's for a MIPS processor
> while the 2835 is ARM).

And so? if the core is the same, just use it on your platform too. If you have 
a look at the architecture files, you will see that the various BCM63xx SoC 
have their internal registers shuffled but the SPI core is always software 
compatible, another set of registers can be added for BCM2835.

I have no objection making such a driver more generic and not limited to 
bcm63xx like it is right now.
--
Florian
