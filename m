Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Jul 2013 12:46:51 +0200 (CEST)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:50074 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816209Ab3GBKqto8Trm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 2 Jul 2013 12:46:49 +0200
Received: by mail-pa0-f43.google.com with SMTP id hz11so6103545pad.2
        for <linux-mips@linux-mips.org>; Tue, 02 Jul 2013 03:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=m361KGpdZT5Z9vH/WsoGtXzVOuX87jx9Xhl1lBsygPc=;
        b=ZyFFx8NV+KiHo3VURO57s77uYgWN218hGYeb5pjceMsZGC2hyRTXZNtZtm5mby9aJC
         8KDwm8R26MDR2WPi/Dmccg24J19PTRYrcjHeJxxNtAi0irvNZkNtg+JEWL91df1eUIFz
         IozNahqVuPwCPoaW2VAwJagHbz5K0BgK+uNWPJqBSFNsBeoOhtMmsv4J2ytwJvn5Rndt
         Qltpjc+hw1S6PvwbDXx8rHQzZj8nkVvxvAROicdqP+rPvCq3WkALeFESUwoWnH0e5VXU
         kV7dHS5RERK899MNrn9YNKiDfI+Iozfo+peUdBy5KdF7Lr5DN2N+nohvPkPmYUYJzAJq
         wfgA==
X-Received: by 10.66.37.43 with SMTP id v11mr28448568paj.108.1372762003496;
 Tue, 02 Jul 2013 03:46:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.68.10.101 with HTTP; Tue, 2 Jul 2013 03:46:03 -0700 (PDT)
In-Reply-To: <1372760024-26297-1-git-send-email-markos.chandras@imgtec.com>
References: <1372760024-26297-1-git-send-email-markos.chandras@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 2 Jul 2013 11:46:03 +0100
Message-ID: <CAGVrzcYVyHOeRQoBPFu7MRz08d6WcprOyXpfwFZi5Ov4zYmiEw@mail.gmail.com>
Subject: Re: [PATCH v2] MIPS: bcm63xx: clk: Add dummy clk_{set,round}_rate() functions
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     Linux-MIPS <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37254
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2013/7/2 Markos Chandras <markos.chandras@imgtec.com>:
> Several drivers use the clk_{set,round}_rate() functions
> that need to be defined in the platform's clock code.
> The Broadcom BCM63xx platform hardcodes the clock rate so
> we create new clk_{set,round}_rate() functions
> which just return 0 like those in include/linux/clk.h
> for the common clock framework do.
>
> Also fixes the following build problem on a randconfig:
> drivers/built-in.o: In function `nop_usb_xceiv_probe':
> phy-nop.c:(.text+0x3ec26c): undefined reference to `clk_set_rate'
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> Acked-by: Steven J. Hill <Steven.Hill@imgtec.com>

Acked-by: Florian Fainelli <florian@openwrt.org>
--
Florian
