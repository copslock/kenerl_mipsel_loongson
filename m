Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 17 Sep 2018 19:57:10 +0200 (CEST)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:34881
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994575AbeIQR5Chvs6N (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 17 Sep 2018 19:57:02 +0200
Received: by mail-it0-x244.google.com with SMTP id 139-v6so12141394itf.0
        for <linux-mips@linux-mips.org>; Mon, 17 Sep 2018 10:57:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qnm0/5xrSedoeYFWe/K6glLK4ZcxQ27Mm2v9Y4/yn94=;
        b=bbYUc7vYRMRnDvWDcIJu5v7XUvQhVHX1EXihIH3qWXXmD5CVMtD+uZ7nhBFVWVV7gx
         2jgsU3vpzuGxkPbeFDWkFXyyxleHEfneoY89VQ6icupriA9MaHeCT1xb8D+yCvf6vMS1
         pr3O0zpDQfsgMvosFB5VQxxA5B1KbIO1Ytejs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qnm0/5xrSedoeYFWe/K6glLK4ZcxQ27Mm2v9Y4/yn94=;
        b=YlcRXjSwVrcimDp0cFlcmoUbbo8mmhnahrwMp+OxQ0p0kQCVRRMn9yO7XUgkf9DdTh
         uRGIYKTFCcEy+cMIZG5ak3gWQvlKSdZrgQ4ohkkqyRbepM1C61AVEy7EVqu1zX41aLzs
         NcG0SrSCbcN4i84/3hJRGSZSMVbvXM2JlJu2R9EuWQYmczcxkSBdAUoJUAYVTkDfzU0T
         sI09uNst1TM7hFrt0xDAvIQwSk0jIOVizMe/LI2AH6Nx4cVh+6Sb355tytRWek6+yBTH
         N7TgtcTPA6YGMoZlz3Sj5ds2Bg0cP2K71qH+EeRAau9ExN8GMoVSXR8sw0aWhVBQXYjC
         oulA==
X-Gm-Message-State: APzg51AqYgSBATRrM0EYBiUo49dDpkBiB5GXVPRCuf8Rx3H9Y7Kn5TQ9
        Ne8l3RitnNWbcsL20rnJQcdnnka83BXfrUbjPCY+0w==
X-Google-Smtp-Source: ANB0VdbV5UveFSqParmtm5j/lGfMKj/eNb/Fn3jZVB3rpfQuRU8pC/Bi5RUEgpGdpA+gghbeabae3r2Ei5xqdcr2DDM=
X-Received: by 2002:a02:6c45:: with SMTP id w66-v6mr23939794jab.87.1537207011823;
 Mon, 17 Sep 2018 10:56:51 -0700 (PDT)
MIME-Version: 1.0
References: <20180912113204.1064-1-linus.walleij@linaro.org>
 <20180912113204.1064-3-linus.walleij@linaro.org> <20180914195834.5cosv4zpt6lph4c4@pburton-laptop>
In-Reply-To: <20180914195834.5cosv4zpt6lph4c4@pburton-laptop>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 17 Sep 2018 10:56:29 -0700
Message-ID: <CACRpkdbtmoSzN0K_6uf09uTyNts4t_Eaqj0FVDa39XA3yoFLyA@mail.gmail.com>
Subject: Re: [PATCH 3/3] gpio: vr41xx: Delete vr41xx_gpio_pullupdown() callback
To:     paul.burton@mips.com
Cc:     "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        Yoichi Yuasa <yuasa@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66370
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
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

On Fri, Sep 14, 2018 at 12:58 PM Paul Burton <paul.burton@mips.com> wrote:

> I presume you'll take this through the GPIO tree?
>
>     Acked-by: Paul Burton <paul.burton@mips.com>

Yep I queued it, thanks!

Yours,
Linus Walleij
