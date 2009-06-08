Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 08 Jun 2009 13:21:33 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:58790 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20021930AbZFHMV0 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 8 Jun 2009 13:21:26 +0100
Received: by fxm23 with SMTP id 23so3048167fxm.0
        for <multiple recipients>; Mon, 08 Jun 2009 05:21:20 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=GSYwsSxcggRGcOh1FLgatIYCDc9l8K0sTeL63dWDrN4=;
        b=if75p0r2MOAbdIPCR3ljOSr/Ntzv6PGUDNVRahZifkUms8heNzlYe11UlPlDyoDOvQ
         TW30gOJE5LQJ9QSj5pSPW3J7V3Zylr9DcCnXecwaVZunQ+Mi6k1U7a2s05rMWkLaEmue
         Srp8rJllOfAvPXiSClZDB/4mzZN50aYwIqFIo=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=gZVzDZ4U5jOeKkotdzJNenIz3C2o4THtdCnkudL9d83Ftge4UXYOvnBhVn7hlTl2Ez
         BMFYjr7Gfb7ulAUTVr+QnEIIymCvU05YOjU00Y2L+Tt0PM7O/azQkM9eig8EBQOoHbyW
         5tMNPAgkDYLDAeA+lQfA3Nim1+zPJrphplLvE=
MIME-Version: 1.0
Received: by 10.223.124.147 with SMTP id u19mr3973964far.28.1244463679102; 
	Mon, 08 Jun 2009 05:21:19 -0700 (PDT)
In-Reply-To: <20090608115336.GA25827@rakim.wolfsonmicro.main>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
	 <1244399944-29043-5-git-send-email-manuel.lauss@gmail.com>
	 <20090608092521.GA7858@sirena.org.uk>
	 <f861ec6f0906080243g6be8e613p7ab9c2df66576be8@mail.gmail.com>
	 <20090608102018.GA6547@rakim.wolfsonmicro.main>
	 <f861ec6f0906080425i388a99a1kb89667c749a815c8@mail.gmail.com>
	 <20090608115336.GA25827@rakim.wolfsonmicro.main>
Date:	Mon, 8 Jun 2009 14:21:18 +0200
Message-ID: <f861ec6f0906080521y4443b888gb81a78305dfca5e2@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 4/7] Alchemy: DB1200 AC97+I2S audio support.
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Manuel Lauss <manuel.lauss@gmail.com>,
	alsa-devel@alsa-project.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Mark,

> You should convert the DAI drivers to probe as normal platform devices
> and attach the resources used by the CPU to those devices rather than
> attaching the data to soc-audio.  pxa2xx-ac97 does this, as do the
> PowerPC drivers and the s3c64xx-i2s driver.  The DaVinci drivers
> currently on the davinci branch of my git for merge after the merge
> window do this too.

I see now what you mean, but this is ugly as sin:
I now need to register 2 platform devices in the board code: 1 for the DAI
(with resources mmio + irq) and 1 for the DMA engine (with ddma id resources),
or register the DMA engine device from within the AC97/I2S drivers.

This is in my opinion even worse than the current scheme, which at least allows
me to group all PSC resources into one struct resource which all audio-related
drivers can share without too much uglyness.

       Manuel Lauss
