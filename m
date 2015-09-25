Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Sep 2015 18:40:00 +0200 (CEST)
Received: from mail-ob0-f170.google.com ([209.85.214.170]:33271 "EHLO
        mail-ob0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27008821AbbIYQj6wFCf0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Sep 2015 18:39:58 +0200
Received: by obbbh8 with SMTP id bh8so86148350obb.0
        for <linux-mips@linux-mips.org>; Fri, 25 Sep 2015 09:39:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=mjNiTayR2rYju+d77v0oKQmtRCK0ltFctjf1Q0V+Vew=;
        b=G5E7OXG0b6MCLffsz0yEvBuNixXPO9SnzJTmb+2apLoJHfLY29hhD4VBgkJPCvNwxI
         ucAbGes7rW/FvFqBMLZBfsd44WVAuivXr9XZcKYg8k8TdAGKpuSvLg62IlBPjXZASbab
         dv00am7Q1LFpcZPZ6zAomKRS/KXOoWCazOZWB6TsPhKfGsYRHumKpG0g7Nr+BmGZ1ZCp
         w+A3KzByv670OQC7oIzoU5BSFqpMRFntNp6Gdia828RZIwG6Pe6DkQ3+twIcFGyMbpvu
         saXzGmpR1zEifE17UImbT58ajL9VNUyUCX5MY7BShqZkbuG2hivZEreVLgKUt1ZUM0SQ
         5ATQ==
X-Gm-Message-State: ALoCoQkzFr0J9KvlsdLtZX22ogUdBL5UyETsh85Bjh3wppL4+iC7Wr/JHJRWZoCRALaW2w7rvlYJ
MIME-Version: 1.0
X-Received: by 10.60.79.226 with SMTP id m2mr3749869oex.20.1443199191217; Fri,
 25 Sep 2015 09:39:51 -0700 (PDT)
Received: by 10.182.44.135 with HTTP; Fri, 25 Sep 2015 09:39:51 -0700 (PDT)
In-Reply-To: <1441100282-13584-1-git-send-email-albeu@free.fr>
References: <1441100282-13584-1-git-send-email-albeu@free.fr>
Date:   Fri, 25 Sep 2015 09:39:51 -0700
Message-ID: <CACRpkdbX+cMmS-j85zqhPSa8XRQHtus6HXqZrLo9b++KAHDc5g@mail.gmail.com>
Subject: Re: [PATCH] gpio: ath79: Convert to the state container design pattern
From:   Linus Walleij <linus.walleij@linaro.org>
To:     Alban Bedel <albeu@free.fr>
Cc:     "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        Alexandre Courbot <gnurou@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Gabor Juhos <juhosg@openwrt.org>,
        Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49369
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

On Tue, Sep 1, 2015 at 2:38 AM, Alban Bedel <albeu@free.fr> wrote:

> Turn the ath79 driver into a true driver supporting multiple
> instances. While at it also removed unneed includes and make use of
> the BIT() macro.
>
> Signed-off-by: Alban Bedel <albeu@free.fr>
> ---
>
> This patch apply on top of my previous MIPS GPIO patches that are pending
> for 4.3, so it might be better to take it thru the MIPS tree.

Patch applied (for v4.4).

Would you consider sending a patch adding yourself as maintainer
for this file in MAINTAINERS?

Yours,
Linus Walleij
