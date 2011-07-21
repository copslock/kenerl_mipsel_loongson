Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2011 00:30:25 +0200 (CEST)
Received: from mail-pz0-f47.google.com ([209.85.210.47]:59328 "EHLO
        mail-pz0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491159Ab1GUWaT convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 22 Jul 2011 00:30:19 +0200
Received: by pzk36 with SMTP id 36so2598291pzk.34
        for <multiple recipients>; Thu, 21 Jul 2011 15:30:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=UPCbbdoReEChMha5dc3fLsmVVvEEeyrM0cAPTPx7WG8=;
        b=Bl9Q6Dw+0Vbr6KyI1EKWwJtfMJlASze4eciePHmz3pVosBpmEKodf6+XicS8KhFWlp
         J6lZKlXDfIM7qtff+eq5oiWA2UgUwFGi+JOUzO525YMx5j5RAoNcRJMkLT9+zf4F0DDm
         M96gXtM/6MEI+jbY/s+qRKHbWLtEdvp6e4dSs=
MIME-Version: 1.0
Received: by 10.68.27.135 with SMTP id t7mr1214669pbg.183.1311287411635; Thu,
 21 Jul 2011 15:30:11 -0700 (PDT)
Received: by 10.68.49.98 with HTTP; Thu, 21 Jul 2011 15:30:11 -0700 (PDT)
In-Reply-To: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
References: <1310835342-18877-1-git-send-email-hauke@hauke-m.de>
Date:   Fri, 22 Jul 2011 00:30:11 +0200
Message-ID: <CACna6ryjYGuLc5c88eke=gjgwQyVD+A9afM6zCRhqV1THHgWvA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] bcma: add support for embedded devices like bcm4716
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     ralf@linux-mips.org, linux-wireless@vger.kernel.org,
        linux-mips@linux-mips.org, jonas.gorski@gmail.com, mb@bu3sch.de,
        george@znau.edu.ua, arend@broadcom.com,
        b43-dev@lists.infradead.org, bernhardloos@googlemail.com,
        arnd@arndb.de, julian.calaby@gmail.com, sshtylyov@mvista.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-archive-position: 30658
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: zajec5@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15555

2011/7/16 Hauke Mehrtens <hauke@hauke-m.de>:
> This patch series adds support for embedded devices like bcm47xx to
> bcma. Bcma is used on bcm4716 and bcm4718 SoCs as the system bus and
> replaced ssb used on older devices. With these patches my bcm4716
> device boots up till it tries to access the flash, because the serial
> flash chip is unsupported for now, this will be my next task. This adds
> support for MIPS cores, interrupt configuration and the serial console.
>
> These patches are not containing all functions needed to get the SoC to
> fully work and support every feature, but it is a good start.
> These patches are now integrated in OpenWrt for everyone how wants to
> test them.
>
> This was tested with a BCM4704 device (SoC with ssb bus), a BCM4716
> device and a pcie wireless card supported by bcma.
>
>
> @Rafał: If you are fine with the bcma patches could you please give
> your Signed-off on them.
>
> @Ralf: Could you please merger this into the mips tree so that it will be in linux-3.1.

ML for bcma is linux-wireless. Should we pass that patches "via" Ralf
or John? Using linux-wireless (and John's tree) makes more sense to
me, as we will work on the same tree and will get less merge
conflicts. However don't take me as Linux development style guru, just
my POV.

-- 
Rafał
