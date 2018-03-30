Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Mar 2018 09:29:01 +0200 (CEST)
Received: from mail-ot0-x22a.google.com ([IPv6:2607:f8b0:4003:c0f::22a]:40334
        "EHLO mail-ot0-x22a.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbeC3H2z0nm5m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Mar 2018 09:28:55 +0200
Received: by mail-ot0-x22a.google.com with SMTP id j8-v6so1283649ota.7;
        Fri, 30 Mar 2018 00:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=sKiMPCMhCGXcY+4D/OzDkFa5X4IkiaSLIKWVA8C8Xas=;
        b=D7OnBw0uPGJSMd31hi3aELQMzUPp92Jad110L8ztHgz3C1EaUPzwV08htCvKL/1Tha
         vnKCi4eDtue8AOFykLbLBVIz2rHaZt+g+8h/6ovEuulh3/Bg9fY7cAZJvkhZQhTC0tqy
         gWCw/VV+fiwvoCz7I/et9jC9C0HlXgMp4Z7XalRAC4Fk+lsPrKZtJUwhq+lSQBsaVipj
         AjxOKN6FUGiUIdczOXA02rBihWYngJFyen01ZwbIRD8GLhncUEWUBBLzcRAw0GvbXIDV
         WoqIMNfbYo+t/vkCYLbvgr3GFBYiqAFxE2dgVI1wzdNsB4VfmidzO+Krpzn95QSKKKZL
         4tHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=sKiMPCMhCGXcY+4D/OzDkFa5X4IkiaSLIKWVA8C8Xas=;
        b=Aef7Vk+H/H3RppYvFUjeNdEJmR5R3Y8YwAPcCtChnubsI///GAwAKhFbObVaF5Q7mg
         j4QN/A7qE4k8yfS8DdZpjzwRV/8+aVZpmk37kErUP46hjHGIbghvY4hTrSCoNwDRPnoV
         muWN0wVauk3Rbi0xspgvcn9jI0daFkCLkZyGJ1CDBzlYxyS2KWn6NaK+l8n9OfrjO7yd
         IGCLd+iJau1kCXljq/oeQyIU2IwL3k5v9R+n116kXa6IX5UdxCs2PcApfKahC/h9hLH6
         hkKlt/ytBqmZZRbe+r1Nupe5+s47a03XKRKHCYcRFuDncMeCI5XmR124qEEhBbXC6R2N
         Q+/w==
X-Gm-Message-State: ALQs6tDxQJbl1x/VCim3kaILU1lMODJuKxXj/EA9XNW8WQoBPxm5umQR
        lj1tZ7t6LpvK5pKjruXHBSjDb9WiaD/esRC2tps=
X-Google-Smtp-Source: AIpwx4+bff0eCD5ZLsUNjXejS82aeUYjPHSXeG+BXN55JTaQV5sZTXKEi4pJgQTcV68iX3nFbSS4tB5Lo67GJ4YUygY=
X-Received: by 2002:a9d:fa1:: with SMTP id d30-v6mr3988954otd.18.1522394929048;
 Fri, 30 Mar 2018 00:28:49 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.56.134 with HTTP; Fri, 30 Mar 2018 00:28:48 -0700 (PDT)
In-Reply-To: <1522362107-3363-1-git-send-email-riproute@gmail.com>
References: <1522362107-3363-1-git-send-email-riproute@gmail.com>
From:   =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Date:   Fri, 30 Mar 2018 09:28:48 +0200
Message-ID: <CACna6rwJYVUVwvi9U87V=u5_T29JCi0VT9knsxwauci5xFAE5w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: BCM47XX: Use standard reset button for Luxul XWR-1750
To:     Dan Haab <riproute@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        Dan Haab <dan.haab@luxul.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <zajec5@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63355
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

On 30 March 2018 at 00:21, Dan Haab <riproute@gmail.com> wrote:
> From: Dan Haab <dan.haab@luxul.com>
>
> The original patch submitted for support of the Luxul XWR-1750 used a
> non-standard button handler for the reset button. This patch will allow
> using the standard KEY_RESTART
>
> Signed-off-by: Dan Haab <dan.haab@luxul.com>

Looks correct, thanks.
