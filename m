Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2008 20:08:14 +0000 (GMT)
Received: from ug-out-1314.google.com ([66.249.92.175]:16647 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S22678266AbYJ2UIC convert rfc822-to-8bit (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 29 Oct 2008 20:08:02 +0000
Received: by ug-out-1314.google.com with SMTP id k40so934593ugc.2
        for <linux-mips@linux-mips.org>; Wed, 29 Oct 2008 13:07:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id:sender;
        bh=ZdD7KOYm4oH8XSs3j+Y/Jl+JmtSkjenbt/Uvlvjbp54=;
        b=THPIkUbHD7jU0kN8uQzhAMJomfqufXuwjMnhhix3+d2vJ4262Npl/XJR1XevKGaXc8
         4EwuFF3K5ATH20ONbPjEXyzCtxrlFFl5nBgu3V0WRpsC5LVrSGDFl081ca3QDOcTydcj
         pmCd4+Vhc3jFM/dHh9FsWuzhWXfqH3smjOGlg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id:sender;
        b=ZIoS6Kir0HV+fttgwdD2lKUTtnojQEuRuflWErZ1LI4SWA5Tzb9X/JdbXfZLwJD0s+
         Jc+dGlvaOXM8ewuUuhiC6A0sS8xkrI8x8dymdU8ro4mEa/wLBVjaPp63nNEDLoI9LCvH
         F1+H/mKx2pMIi4w4GffZ0NwzEORmfBFwA7tec=
Received: by 10.103.213.19 with SMTP id p19mr4432335muq.12.1225310878712;
        Wed, 29 Oct 2008 13:07:58 -0700 (PDT)
Received: from lenovo.mimichou.home (florian.mimichou.net [82.241.112.26])
        by mx.google.com with ESMTPS id w5sm1651923mue.10.2008.10.29.13.07.55
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 29 Oct 2008 13:07:57 -0700 (PDT)
From:	Florian Fainelli <florian@openwrt.org>
To:	Phil Sutter <n0-1@freewrt.org>
Subject: Re: [PATCH] provide functions for gpio configuration
Date:	Wed, 29 Oct 2008 21:07:42 +0100
User-Agent: KMail/1.9.9
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Linux-Mips List <linux-mips@linux-mips.org>
References: <1225310409-4440-1-git-send-email-n0-1@freewrt.org>
In-Reply-To: <1225310409-4440-1-git-send-email-n0-1@freewrt.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200810292107.43818.florian@openwrt.org>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21092
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Phil,

Le Wednesday 29 October 2008 21:00:09 Phil Sutter, vous avez écrit :
> As gpiolib doesn't support pin multiplexing, it provides no way to
> access the GPIOFUNC register. Also there is no support for setting
> interrupt status and level. These functions provide access to them and
> are needed by the CompactFlash driver.

Right, but we do have interrupt level and status fuctions, registered as 
callbacks to an extended gpiochip structure. These two functions can remain 
static to the gpio.c file since we should perform interrupt status and level 
initialisation at gpiochip init time. Not sure which code you based your work 
on, but linux-queue tree at linux-mips.org has such code.

>
> The function rb532_gpio_set_cfg is redundant with
> rb532_gpio_direction_{input,output} but was added for simplicity's sake.
> Maybe gpiolib support could be dropped completely as there are not many
> users of it.

Sticking with the gpiolib has two advantages to me :
- you can use gpio_set_value/get_value for other 
- GPIO initialisation should be done right after gpiochip registering

I would be rather in favor of adding the other missing callbacks to the 
rb532_gpio_chip and make them look like the standard get/set functions. Just 
like what was done with the interrupt level and status functions.
-- 
Best regards, Florian Fainelli
Email : florian@openwrt.org
http://openwrt.org
-------------------------------
