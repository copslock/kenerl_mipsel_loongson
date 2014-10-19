Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 20:23:17 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:50988 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011806AbaJSSXQCEIRh (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 20:23:16 +0200
Received: by mail-ig0-f173.google.com with SMTP id h18so4168168igc.0
        for <linux-mips@linux-mips.org>; Sun, 19 Oct 2014 11:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=PCOahD4kxNPLTS3k9gogZ2KSzCrrBPi16H2wS9D3HmI=;
        b=FXq8Ns3AS0t9Hz68mnqGcESQSZiL4AbnkIIAubZhHTPxzkj0ZJ6mUhlKBH7JGL7zQ3
         0UedjlJlP8t/qMmq6ZNtx8tV5D3IquV5Hj6ahymTAW1inJPRzV72ZVdK19sFfJYAYxia
         9HvV9GqB55ZTwBD08UPCn+yILL82a++M5rqtCzgX5OZ76u4V08maj+Ne0lz90OaiYWJT
         /s9UYhAUhNC6bTn1GyLWbMmzT3U4aTQadB2GQdYd0YP3c64mwgHPzRw8HXJkymKdZZAk
         x5Saka73uTI57s/Dzc/kBwiA3grN5Ca6Z8yZLJCHapHWCfGEBy4+5KjYvQygizmKH7V3
         wLMA==
X-Received: by 10.50.128.137 with SMTP id no9mr13116515igb.0.1413742989965;
 Sun, 19 Oct 2014 11:23:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.33.203 with HTTP; Sun, 19 Oct 2014 11:22:28 -0700 (PDT)
In-Reply-To: <1413685818-32265-3-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com> <1413685818-32265-3-git-send-email-cernekee@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 19 Oct 2014 11:22:28 -0700
Message-ID: <CAGVrzcaOL_2RsVs2RAnMqzZFFhZ=PDoo_-QYTnBotrBCX19+8Q@mail.gmail.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: Add entry for rp2 (Rocketport
 Express/Infinity) driver
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby <jslaby@suse.cz>,
        mbizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43340
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

2014-10-18 19:30 GMT-07:00 Kevin Cernekee <cernekee@gmail.com>:
> I wrote this driver and use it daily on several machines for work, so
> why not.

Since I also use this driver daily, let's get crazy:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
> ---
>  MAINTAINERS | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 809ecd6..c08d8d5 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -7663,6 +7663,12 @@ S:       Maintained
>  F:     Documentation/serial/rocket.txt
>  F:     drivers/tty/rocket*
>
> +ROCKETPORT EXPRESS/INFINITY DRIVER
> +M:     Kevin Cernekee <cernekee@gmail.com>
> +L:     linux-serial@vger.kernel.org
> +S:     Odd Fixes
> +F:     drivers/tty/serial/rp2.*
> +
>  ROSE NETWORK LAYER
>  M:     Ralf Baechle <ralf@linux-mips.org>
>  L:     linux-hams@vger.kernel.org
> --
> 2.1.1
>



-- 
Florian
