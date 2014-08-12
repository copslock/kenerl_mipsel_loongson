Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 13 Aug 2014 00:07:00 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:60510 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822762AbaHLWG5wrbh1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 13 Aug 2014 00:06:57 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 1166E28016C;
        Wed, 13 Aug 2014 00:06:43 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-qa0-f51.google.com (mail-qa0-f51.google.com [209.85.216.51])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 6F70C280190;
        Wed, 13 Aug 2014 00:06:30 +0200 (CEST)
Received: by mail-qa0-f51.google.com with SMTP id k15so9250966qaq.24
        for <multiple recipients>; Tue, 12 Aug 2014 15:06:29 -0700 (PDT)
X-Received: by 10.224.128.9 with SMTP id i9mr941819qas.50.1407881189577; Tue,
 12 Aug 2014 15:06:29 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.140.84.244 with HTTP; Tue, 12 Aug 2014 15:06:09 -0700 (PDT)
In-Reply-To: <1407538185-23497-1-git-send-email-hauke@hauke-m.de>
References: <1407538185-23497-1-git-send-email-hauke@hauke-m.de>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 13 Aug 2014 00:06:09 +0200
Message-ID: <CAOiHx=nKZfC-J06d+WLhXVDcnW-0RzJE1r8Xrra8rw-GdXqgOA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: fix reboot problem on BCM4705/BCM4785
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42052
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Sat, Aug 9, 2014 at 12:49 AM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> This adds some code based on code from the Broadcom GPL tar to fix the
> reboot problems on BCM4705/BCM4785. I tried rebooting my device for ~10
> times and have never seen a problem. This reverts the changes in the
> previous commit and adds the real fix as suggested by Rafał.
>
> Setting bit 22 in Reg 22, sel 4 puts the BIU (Bus Interface Unit) into
> async mode.
>
> The previous try was this:
> commit 316cad5c1d4daee998cd1f83ccdb437f6f20d45c
> Author: Hauke Mehrtens <hauke@hauke-m.de>
> Date:   Mon Jul 28 23:53:57 2014 +0200
>
>     MIPS: BCM47XX: make reboot more relaiable
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> ---
>  arch/mips/bcm47xx/setup.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 2b63e7e..2c35af4 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -59,12 +59,21 @@ static void bcm47xx_machine_restart(char *command)
>         switch (bcm47xx_bus_type) {
>  #ifdef CONFIG_BCM47XX_SSB
>         case BCM47XX_BUS_TYPE_SSB:
> -               ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 3);
> +               if (bcm47xx_bus.bcma.bus.chipinfo.id == 0x4785)
> +                       write_c0_diag4(1 << 22);
> +               ssb_watchdog_timer_set(&bcm47xx_bus.ssb, 1);
> +               if (bcm47xx_bus.bcma.bus.chipinfo.id == 0x4785) {

As our buildbot noticed:

arch/mips/bcm47xx/setup.c: In function 'bcm47xx_machine_restart':
arch/mips/bcm47xx/setup.c:63:18: error: 'union bcm47xx_bus' has no
member named 'bcma'
   if (bcm47xx_bus.bcma.bus.chipinfo.id == 0x4785)
                  ^
arch/mips/bcm47xx/setup.c:66:18: error: 'union bcm47xx_bus' has no
member named 'bcma'
   if (bcm47xx_bus.bcma.bus.chipinfo.id == 0x4785) {


I guess you meant bcm47xx_bus.ssb.bus.chipinfo.id or so.



Jonas
