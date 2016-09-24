Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Sep 2016 14:22:13 +0200 (CEST)
Received: from mail-oi0-f67.google.com ([209.85.218.67]:34282 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990513AbcIXMWGlL9e0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 24 Sep 2016 14:22:06 +0200
Received: by mail-oi0-f67.google.com with SMTP id a62so10589769oib.1
        for <linux-mips@linux-mips.org>; Sat, 24 Sep 2016 05:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B9xbG4dj3aJYx3ddM3SQGAKad02SUaJi+bjeaDwnoV8=;
        b=frFCJYCxY0gQeZRQbRuvVG3z0JAOxExJ0a9HqCTRMh063OTnI2h5BMCtDj7GPZzNjS
         fSXmkTk2QD1/n4UWzFl/ukVJjrmbOqlD896KVr5whVQe5SA2+LDAd/Yx2WnaeFJZE1tW
         F11xVDFxA//m1m9HmIPHSOKfowINLSsfvrWyAyT1LWiV2mM1GVEfhfXrH759OLDczDa8
         SxKyKKHzR+a/s6Tjw4EiFWT7d3jpfape/Tx+KAm+DRaJszFeOjOt7U0V8fFaiiDo8Yr2
         onUU0HuGsKzAESxANsoT5+3im3JOF9ar/WtkpSZSgnKoLbLVKAgPKbos7wM6se5No/Lx
         NVkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B9xbG4dj3aJYx3ddM3SQGAKad02SUaJi+bjeaDwnoV8=;
        b=PyPs5yFeJET9yRhEjHB1p/NhuzLm7s8Wa6KxrVOSmrW4E4YemaCSc7yDDjqisB3K56
         fcF07rOx4OO0B9jyJgE1QgCRyzDDZoQrvxWb6EUN9Irx3UltVMhcIqoN41HApxvH7iln
         yI09nBIj3HHPrWWNFq7PaRKditjhBh9lPHiuoaoq12cqOUwDpPzBM+gLpbWHKUBhEQfc
         PB+smETZxiE4tCwJTe8CX5bw9D9kesx6aB3QMCMZp2EqgC8hki4nfLjVvGgsvB9MfOcd
         ytpAQobY482BobivzWh4eJkhxr6GJOQRh+zifTFXIGA7FZVooyhzJOth1J1jGPdFZP+A
         0etQ==
X-Gm-Message-State: AE9vXwPvPa7nAUJvPNg1W+hA2vuGWiLPZCHagKONzYxnSWlZncEvYt8QHZ530wdmjG6y+PSCiEIQdw0UzKddWA==
X-Received: by 10.202.193.136 with SMTP id r130mr16524148oif.32.1474719720685;
 Sat, 24 Sep 2016 05:22:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.237.211 with HTTP; Sat, 24 Sep 2016 05:22:00 -0700 (PDT)
In-Reply-To: <1474693389-16315-1-git-send-email-baoyou.xie@linaro.org>
References: <1474693389-16315-1-git-send-email-baoyou.xie@linaro.org>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Sat, 24 Sep 2016 14:22:00 +0200
Message-ID: <CACna6rxcDBT_Nw1cT7DVR6B1-72qz3G4HO+vL5MZF64dewBrfQ@mail.gmail.com>
Subject: Re: [PATCH] firmware/broadcom: add missing header dependencies
To:     Baoyou Xie <baoyou.xie@linaro.org>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, xie.baoyou@zte.com.cn
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
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

On 24 September 2016 at 07:03, Baoyou Xie <baoyou.xie@linaro.org> wrote:
> We get 1 warning when building kernel with W=1:
> drivers/firmware/broadcom/bcm47xx_sprom.c:717:5: warning: no previous prototype for 'bcm47xx_sprom_register_fallbacks' [-Wmissing-prototypes]
>
> In fact, this function is declared in include/linux/bcm47xx_sprom.h,
> so this patch adds missing header dependencies.
>
> Signed-off-by: Baoyou Xie <baoyou.xie@linaro.org>

Acked-by: Rafał Miłecki <rafal@milecki.pl>
