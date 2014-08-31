Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 31 Aug 2014 11:20:49 +0200 (CEST)
Received: from mail-ie0-f172.google.com ([209.85.223.172]:64807 "EHLO
        mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007641AbaHaJUrxtMjJ convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 31 Aug 2014 11:20:47 +0200
Received: by mail-ie0-f172.google.com with SMTP id rd18so4818987iec.3
        for <linux-mips@linux-mips.org>; Sun, 31 Aug 2014 02:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=aKxa97+NwKr4Jje8lahohzSe3rDg2CxYEQ7ZQpwBt2E=;
        b=gFDHMUXhYxN+wKC4e7dtt9aBK8SP+Of/cM3GK3dzADuEwAAxJmS47fYHu8VH1q//iE
         q+jTPliB5pevkpIaHnPVElVZ+id6dnUUYzd3/uJ3+3HephxFUOnoObAAX0IHFp3YPbB1
         JBBMQyaSdQAZyV/NIgT2AfrkWxj7irGi4SppnXCTzS1NwomkTNfG7zT2rm4L9ZNlNx+1
         lLvrl1nDbwEYwQ614sedEa57x3QjVnM/tid8qfSHPPEebxorU8NhnfMzgQRutQwtzO2R
         m8bLGr/Tumruj7BtHE/Y5Gh/uecleN+ayLIwvDD+gbjeAWmIqsgKalBm9s6WgNw/pS3S
         eouA==
MIME-Version: 1.0
X-Received: by 10.42.39.142 with SMTP id h14mr6690917ice.32.1409476841754;
 Sun, 31 Aug 2014 02:20:41 -0700 (PDT)
Received: by 10.107.10.133 with HTTP; Sun, 31 Aug 2014 02:20:41 -0700 (PDT)
In-Reply-To: <5882203.GXbhhcHqjK@wuerfel>
References: <CACna6rzRf7qf0YAFWqp4VgwR76-N8HO12eSz_H5NW9LpjBArdw@mail.gmail.com>
        <53FF9D9B.30106@hauke-m.de>
        <CACna6rzaXHww2UXoP4Fi-zA3uNve4NQ48DeChF8zoBS-_-mtyw@mail.gmail.com>
        <5882203.GXbhhcHqjK@wuerfel>
Date:   Sun, 31 Aug 2014 11:20:41 +0200
Message-ID: <CACna6rwmNtS1JSi=VHXWHu6mOM72Y8sBrr5EqCRbpYUHFrMnCg@mail.gmail.com>
Subject: Re: Booting bcm47xx (bcma & stuff), sharing code with bcm53xx
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42347
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

On 29 August 2014 22:04, Arnd Bergmann <arnd@arndb.de> wrote:
> You mentioned that the 'boot_device' variable in your code snippet
> comes from a hardware register that can be accessed easily, right?
> A possible way to handle it would then be to have two DT entries
> like
>
>         nvram@1c000000 {
>                 compatible = "bcm,bcm4710-nvram";
>                 reg = <0x1c000000 0x1000000>;
>                 bcm,boot-device = BCMA_BOOT_DEV_NAND;
>         };
>
>         nvram@1c000000 {
>                 compatible = "bcm,bcm4710-nvram";
>                 reg = <0x1e000000 0x1000000>;
>                 bcm,boot-device = BCMA_BOOT_DEV_SERIAL;
>         };

This sounds like a nice consensus for me! Actually it seems to be
similar to what we already do for other hardware parts.

E.g. in bcm4708.dtsi Hauke put registers location of 4 Ethernet cores
(gmac@0, gmac@1, gmac@2, gmac@3). I believe this board is ready for 4
Ethernet cores so DT matches hardware capabilities. Then most vendors
use/activate only one (maybe up to 2?) Ethernet cores. It's up to the
driver to detect if core is activated/used.

AFAIU having two flash mappings (as suggested above) would follow this
logic. It would match hardware capabilities. And then it would be up
to driver to detect which one mapping is really in use for this
particular board.

Does it make sense?

-- 
Rafał
