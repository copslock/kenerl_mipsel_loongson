Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2013 16:44:02 +0200 (CEST)
Received: from mail-pb0-f46.google.com ([209.85.160.46]:45315 "EHLO
        mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818020Ab3IROoAeRXDx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Sep 2013 16:44:00 +0200
Received: by mail-pb0-f46.google.com with SMTP id rq2so7051759pbb.5
        for <multiple recipients>; Wed, 18 Sep 2013 07:43:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=fMF28y837wZ3rXqiXBbWNUXPgjoYZesvw9en0pLYjaE=;
        b=LT7ih7YLYUc6fFmKn4mmZ7T+fMkFp+HQWKN+p5YMmCFuInmDqgTqLgtrIc1R19z3Rv
         sQx8DdUjbGFtKpV0oV8//bF2zOrNtkHXuNzMrPuDoQkw+gI+ARIsPnSjL+vqJKw985zB
         M10yR31QCh1bEFqpcyfgUUiJTN4NJ5mhvXkkTMbJwhM6tv+Eq7aeJTjheOhOO7BHJpJm
         fg1V4i2jCId8md+1Jc4tGp9ErfpAlAtlmG1ztYOYdtiTqZ9hWRlLm3oAcIjW+RAq/R5Y
         M5eMkY2JqDd0KOq7ZnP7CYsIkHIG4IAWQg7NIqcEHAw/hlLn8mJhSf/j6WriStXVdAno
         0q2g==
MIME-Version: 1.0
X-Received: by 10.67.30.100 with SMTP id kd4mr43964852pad.24.1379515433049;
 Wed, 18 Sep 2013 07:43:53 -0700 (PDT)
Received: by 10.70.18.229 with HTTP; Wed, 18 Sep 2013 07:43:52 -0700 (PDT)
In-Reply-To: <1379515235-29161-1-git-send-email-hauke@hauke-m.de>
References: <1379515235-29161-1-git-send-email-hauke@hauke-m.de>
Date:   Wed, 18 Sep 2013 16:43:52 +0200
X-Google-Sender-Auth: SZz9d6mGc1CS783ChICLApaHF0k
Message-ID: <CAMuHMdUKHEBBCio2ixu04i8dc-mBvK3fD8VuXr2y1GSV5zrh3A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: put board detention data into init section
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Hauke Mehrtens <hauke@hauke-m.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Wed, Sep 18, 2013 at 4:40 PM, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> +       strncpy(bcm47xx_board.name, board_detected->name, BCM47XX_BOARD_MAX_NAME);
> +       bcm47xx_board.name[BCM47XX_BOARD_MAX_NAME - 1] = 0;

You can use strlcpy() instead.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
