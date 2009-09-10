Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 12:52:31 +0200 (CEST)
Received: from mail-ew0-f225.google.com ([209.85.219.225]:55162 "EHLO
	mail-ew0-f225.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S2097287AbZIJKwY convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 10 Sep 2009 12:52:24 +0200
Received: by ewy25 with SMTP id 25so4707068ewy.33
        for <linux-mips@linux-mips.org>; Thu, 10 Sep 2009 03:52:17 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=emeznUvZiGdhx1GHKHvOoEXLykryPQxOUIw8NC9+YAs=;
        b=S9GPxziooGQYM9NBnVnZDXm82BZ0+s5lTBStJTm8orD8O78I2GfkW4IOiEZlVyrkpj
         2TDeiOjUkwZ8PFHzImavYKLW4RpKe2IgerTfFxQtdxzs6lZ3ZWxUqY3yulKElephYkrV
         bx/Ly58qQLCjuoAqfPKqEKAA7gW/IE3kUxpuU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=ugbaooNQrck06s5hbDluf7cYh6uwVSEg8tvKBgsXQibE0RygMT4XNFEHUOIPZLhr5c
         F1tlQRS0roB2o/9hs7Z63h+HqGZnIfLwvDfkl1sT0JyyiVyHpKpGAjQIAbP8x83gCpKj
         yst0xf8GjES+3ukJeFGl4LsL/iE/cbbHFt+hg=
MIME-Version: 1.0
Received: by 10.210.101.1 with SMTP id y1mr743830ebb.60.1252579937789; Thu, 10 
	Sep 2009 03:52:17 -0700 (PDT)
In-Reply-To: <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
	 <1252531371-14866-3-git-send-email-w.sang@pengutronix.de>
Date:	Thu, 10 Sep 2009 12:52:17 +0200
Message-ID: <e2e108260909100352l2a30438fj9f0297c1974c0192@mail.gmail.com>
Subject: Re: [PATCH 2/4] i2c/chips: Remove deprecated pcf8575-driver
From:	Bart Van Assche <bart.vanassche@gmail.com>
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	Jean Delvare <khali@linux-fr.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <bart.vanassche@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24008
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bart.vanassche@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 9, 2009 at 11:22 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
>
> The pcf8575-driver in drivers/i2c/chips which just exports its register to
> sysfs is superseeded by drivers/gpio/pcf857x.c which properly uses the gpiolib.
> As this driver has been deprecated for more than a year, finally remove it.
>
> Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
> Cc: Bart Van Assche <bart.vanassche@gmail.com>
> Cc: Jean Delvare <khali@linux-fr.org>
> ---
>  Documentation/i2c/chips/pcf8575 |   69 --------------
>  drivers/i2c/chips/Kconfig       |   18 ----
>  drivers/i2c/chips/Makefile      |    1 -
>  drivers/i2c/chips/pcf8575.c     |  198 ---------------------------------------
>  4 files changed, 0 insertions(+), 286 deletions(-)
>  delete mode 100644 Documentation/i2c/chips/pcf8575
>  delete mode 100644 drivers/i2c/chips/pcf8575.c

This patch removes the documentation file
Documentation/i2c/chips/pcf8575 while there is no documentation under
Documentation/ for the drivers/gpio/pcf857x.c driver. Shouldn't proper
documentation for the pcf857x driver be added to the kernel tree
before the pcf8575 driver is removed ?

Bart.
