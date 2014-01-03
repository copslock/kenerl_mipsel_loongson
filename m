Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 04 Jan 2014 00:33:46 +0100 (CET)
Received: from mail-wg0-f44.google.com ([74.125.82.44]:44844 "EHLO
        mail-wg0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825727AbaACXdng0jw3 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 4 Jan 2014 00:33:43 +0100
Received: by mail-wg0-f44.google.com with SMTP id a1so13791241wgh.11
        for <multiple recipients>; Fri, 03 Jan 2014 15:33:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=skB2zcQt/Lm1yFOGtrgSxUEXPi9iHmxs7YcjOUKozL0=;
        b=l4UzYpKBb90fyyxXEABrPjVRt2ikKG9XWqiM30ANAUncF/0Migs2rNuFvauiLP39nH
         Qk/0OwGTaAN9UvQQJqjbhgMOH0rze73w/JdfSawD4mMj0GFNKxymCyN2xg7U+erMKkEk
         MfZxP5P0Ql5StoTr2kKWHT7XuekZwhthxcYfjPHxC6eamZnPHd84Cf1SY6UvYmO2tsQy
         TlyGJZB5iCR3HIXkT9cXAFYHkKNJ1DjFSIYJPq3CjLAc3ivUX5CDC6lPB/refTE3P9oJ
         3G6DaNGI7BCa9Kcp0ksiEcQ7hN83Uu9uQjZ1JRLUPXDsVW1ww/qLuOuN+51XLsECQf0l
         vGbg==
MIME-Version: 1.0
X-Received: by 10.180.105.202 with SMTP id go10mr1791291wib.42.1388792018280;
 Fri, 03 Jan 2014 15:33:38 -0800 (PST)
Received: by 10.216.161.137 with HTTP; Fri, 3 Jan 2014 15:33:38 -0800 (PST)
In-Reply-To: <1388778120-24880-3-git-send-email-hauke@hauke-m.de>
References: <1388778120-24880-1-git-send-email-hauke@hauke-m.de>
        <1388778120-24880-3-git-send-email-hauke@hauke-m.de>
Date:   Sat, 4 Jan 2014 00:33:38 +0100
Message-ID: <CACna6ryK=yTWFPQvGGWOs-YzEa3Vy0an9sigLnyiavtCui-73w@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] MIPS: BCM47XX: fix sparse warnings in board.c
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>, blogic@openwrt.org,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38867
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

2014/1/3 Hauke Mehrtens <hauke@hauke-m.de>:
> This fixes the following sparse warnings:
> arch/mips/bcm47xx/board.c:39:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:46:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:53:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:78:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:99:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:109:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:124:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:155:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:177:16: warning: Using plain integer as NULL pointer
> arch/mips/bcm47xx/board.c:189:16: warning: Using plain integer as NULL pointer
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>

Acked-by: Rafał Miłecki <zajec5@gmail.com>
