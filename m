Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 09:56:10 +0200 (CEST)
Received: from mail-yw0-f177.google.com ([209.85.211.177]:36113 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492355AbZIJH4D (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 09:56:03 +0200
Received: by ywh7 with SMTP id 7so7443847ywh.21
        for <linux-mips@linux-mips.org>; Thu, 10 Sep 2009 00:55:56 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=Og2JRVvwtRisyohaZFGF/YuNxmaJs7dAXTImFJc7UMI=;
        b=AKgij8dFi6D1XKc3kP06SS6h+jGKFG7pnQKtJ6vlMmoE53J/fDIPspGawtGE2XBPuf
         RVHodoe+P6+dP4JpJYJ97iTtkr0p4kmWiqSO0+2l/uCuZAA8kU2moPGzA3j1+R01gCt8
         izf6RQNj7tPeE6AvDG8vExVSLY13xcCDMVdds=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=L09ygWZf1DS+OMJRNc/Lo5GyP/s+jL/F8GHuAEX852RE81b7wVSeVCVBS7IT5T3o8q
         kQZKRKuDqi2qAZ/zY4k3GPbnjBsQuBiEH4pVMA4jNXN86niw97TmvGDRKiwvA1cpS77o
         Ptr5WRmkmLIixkeIIkr+eQyK0faUFZ2B/EsWo=
MIME-Version: 1.0
Received: by 10.150.164.4 with SMTP id m4mr2188920ybe.140.1252569356120; Thu, 
	10 Sep 2009 00:55:56 -0700 (PDT)
In-Reply-To: <20090910062609.GA26454@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de> 
	<8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com> 
	<20090910062609.GA26454@pengutronix.de>
From:	Mike Frysinger <vapier.adi@gmail.com>
Date:	Thu, 10 Sep 2009 03:55:36 -0400
Message-ID: <8bd0f97a0909100055n3192deeka93dc853f0139bfc@mail.gmail.com>
Subject: Re: [Uclinux-dist-devel] Removing deprecated drivers from 
	drivers/i2c/chips
To:	Wolfram Sang <w.sang@pengutronix.de>
Cc:	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org,
	uclinux-dist-devel@blackfin.uclinux.org,
	linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <vapier.adi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24006
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier.adi@gmail.com
Precedence: bulk
X-list: linux-mips

On Thu, Sep 10, 2009 at 02:26, Wolfram Sang wrote:
>> the Blackfin defconfigs refer to an input driver for the PCF8574, not
>> the I2C client driver
>
> Yup, I am aware of that. With the exception of:
>
> blackfin/configs/PNAV-10_defconfig:773:CONFIG_SENSORS_PCF8574=m

thanks for double checking.  i'm not sure this board even has this
device.  i'll review the hardware.
-mike
