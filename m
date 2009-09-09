Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Sep 2009 01:55:08 +0200 (CEST)
Received: from mail-yw0-f177.google.com ([209.85.211.177]:50216 "EHLO
	mail-yw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493229AbZIIXzB (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 10 Sep 2009 01:55:01 +0200
Received: by ywh7 with SMTP id 7so7092692ywh.21
        for <linux-mips@linux-mips.org>; Wed, 09 Sep 2009 16:54:55 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=CV9xEng5q+g1urucTVU4sRWTnKldUp3SexzByDrVINA=;
        b=cLBCk0DEj8ENdxVlD2M61MLE9zMwnU3/iGbeX4FdWteI/97L/fd1ELS6aJV2x3nUm4
         qBmEOoxSPgilya6XSz9r/RBo678t6K7XTNZPWhyuImIrUpKGXtRCSxzW/oIKCZyPXf8X
         gMMYq7dJRzFU6w+ElpY8CD0DP4WzywvldPrZs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=XHg++irwmOeAqGZBRYojCqCa+uyzIbHTW3OxX2WwZ1YPHeSH8aG06CY/ZaijPdi9y2
         gLzkvUdS5Ed3vHGWoW3cLhAV3auF1Arbj5OrgZzPQlnoUl3KLIugDVHD6wNqBZmKkdZn
         BywA6TFfw8Gh08l2WWswMl9DKMX/amYPZ1z3w=
MIME-Version: 1.0
Received: by 10.150.239.15 with SMTP id m15mr1548890ybh.109.1252540495121; 
	Wed, 09 Sep 2009 16:54:55 -0700 (PDT)
In-Reply-To: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
References: <1252531371-14866-1-git-send-email-w.sang@pengutronix.de>
From:	Mike Frysinger <vapier.adi@gmail.com>
Date:	Wed, 9 Sep 2009 19:54:34 -0400
Message-ID: <8bd0f97a0909091654h290180e5ob79178583aca143f@mail.gmail.com>
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
X-archive-position: 24004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier.adi@gmail.com
Precedence: bulk
X-list: linux-mips

On Wed, Sep 9, 2009 at 17:22, Wolfram Sang wrote:
> continuing the quest to clean up and ultimately remove the drivers/i2c/chips
> directory, this patch series removes three drivers for GPIO-expanders which are
> obsoleted and marked as deprecated for more than a year. The newer (and better)
> drivers can be found in drivers/gpio.
>
> As it is ensured that the newer drivers cover the same i2c_device_ids, all
> platform_devices will still match. Some defconfig updates may be necessary
> though, but according to [1] this is left to the arch|platform-maintainers
> (also as most defconfigs are quite outdated). For that reason, I put the
> relevant arch-mailing-lists to Cc. Comments are welcome.

the Blackfin defconfigs refer to an input driver for the PCF8574, not
the I2C client driver
-mike
