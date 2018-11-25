Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2018 06:07:49 +0100 (CET)
Received: from mail-it1-x144.google.com ([IPv6:2607:f8b0:4864:20::144]:52549
        "EHLO mail-it1-x144.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990392AbeKYFHrDM1Ek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2018 06:07:47 +0100
Received: by mail-it1-x144.google.com with SMTP id i7so23637374iti.2
        for <linux-mips@linux-mips.org>; Sat, 24 Nov 2018 21:07:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VVUtrEXZA+jRPL+fVbmJthoajvPk69C0Kd+Rm2/KstQ=;
        b=vYXXJbapH/+kHOwdAsgQJjBZFg1A/8PyjY2TL3FaU0OIIg1uLQVItXaMPbyIM45X4T
         /Rb6ISaMhvFopBImLt+RpgZh8wdnhCfYdHxcasoI/C8UVpQk/0963+LZW2Bb3Ls6Y1bk
         HFvDaXxsuYBt+syfaS4qeupM7GHCJAYt7cOl//LhU0nxFuO3tGIbo0Rc9Azzf3hefA2c
         YOQQRQlqRINtLowTROqYUmmCa+mn6ZiOThp5JzZ4+CuFKGJr/TreXsDHdJ8KC1IZ2SEy
         lhPNLox/O1PVHWx3U/B2HlMyG2Bahat5BXb7kJY9LHrs1Vs+97w71EX8vEXAFlvrW2xg
         u+wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVUtrEXZA+jRPL+fVbmJthoajvPk69C0Kd+Rm2/KstQ=;
        b=DwDJMP1B1QQz/43X1rcRi5EgPjFWjJQYxyU6aLl49xCfCGN8fLzh1dJi/L3ZaE8gJm
         PQx4qTQqy2c73zBZ6BbO16HzXY3MGoS0PlFHU6wMbUpTyD1Co/JHdFzzJY46MQx57edt
         jcAckm+8inUyAfi3zW9F4gQCNBtiGA5YIwsgIiM2/tEGYrZO8HQe/+Gd3pU4K/0o3Z18
         fIPUm+31blMOO/i85GEY+y0Bbffm9IIx5HY7gV5C1SYcjXf4knkqoo7SCQ5rjaRwkVVy
         tTgmTkF4Zi/Y0LepQpcamEnKSlwSg48sW0Jo1Af3xVF/9gvZej7Wpem130RJeynjW7PO
         664Q==
X-Gm-Message-State: AGRZ1gKlgVsWldxQ8wzvW4SLsaC1zShO0cZtA0AYQsLlnjQa2/dfvRr1
        Y58SIyGzyje/1REBp7E4CCPk7hGx3OuawnS03+w=
X-Google-Smtp-Source: AJdET5cAruM4G6eXFV0rMhyoQQNI681CgpHx5fkqW8a1sDCvbgRkOQ917/fybeS+wBhhzxKm1KpM3LygAI8L5tSnx9A=
X-Received: by 2002:a24:a64f:: with SMTP id r15mr18647950iti.101.1543122466274;
 Sat, 24 Nov 2018 21:07:46 -0800 (PST)
MIME-Version: 1.0
References: <20181124022035.17519-1-deepa.kernel@gmail.com>
 <20181124022035.17519-9-deepa.kernel@gmail.com> <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
In-Reply-To: <CAF=yD-Jz8c2EsoKxUDbf7dygWRW49kwteUsksq3eUV00Eg94-w@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Sat, 24 Nov 2018 21:07:35 -0800
Message-ID: <CABeXuvoRPAFa5v86pp+WmBkjzbHZSJqjzibL1+Zx8Uas6bvohg@mail.gmail.com>
Subject: Re: [PATCH 8/8] socket: Add SO_TIMESTAMPING_NEW
To:     willemdebruijn.kernel@gmail.com
Cc:     "David S. Miller" <davem@davemloft.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Network Devel Mailing List <netdev@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Chris Zankel <chris@zankel.net>, fenghua.yu@intel.com,
        rth@twiddle.net, Thomas Gleixner <tglx@linutronix.de>,
        ubraun@linux.ibm.com, linux-alpha@vger.kernel.org,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        linux-xtensa@linux-xtensa.org,
        sparclinux <sparclinux@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67476
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

> > +               new_tstamp = sock_flag(sk, SOCK_TSTAMP_NEW);
> > +               if (new_tstamp)
>
> nit: no need for explicit variable

Sure, will drop it.

-Deepa
