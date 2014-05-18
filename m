Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 18 May 2014 16:39:34 +0200 (CEST)
Received: from mail-ig0-f170.google.com ([209.85.213.170]:52482 "EHLO
        mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6837167AbaEROj0yhK8y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 18 May 2014 16:39:26 +0200
Received: by mail-ig0-f170.google.com with SMTP id uy17so1475140igb.1
        for <linux-mips@linux-mips.org>; Sun, 18 May 2014 07:39:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=f+uCcqBA84NqAk/09BL+MGVB9WnNEWRqUMhkF/l3lqg=;
        b=aehmoQQGKO6xG14g44uKdouzNVuPa5R2Lic9Bc7tEpJsydZ26VfEdDKbTNoOq9W2yG
         /qT4fVeK+i4KgDcKD4r9+DpFXxFApOClAi19HqQcC05klE1xqONTqUnG0NLl/DGvRU2S
         k+djig+mt1th+pw0KA8yJrcqI7JDLYouPcp7UI8w1awXpGsYRa/0w8gXFLm8EcnQQlQG
         t0Lwh6UuHa7GBpPXSvoyqCtoX+eKnSGAxB9vtnIxoeC5qUq5ICvgTnV6LMtvDANuA0qZ
         Gg7q2oPz5RFW+rgA8eg7MeQm0gaDrUVHyxZZoKYlyKvM7aG+o2HYAa38B0G755mF4dg8
         ZSdg==
MIME-Version: 1.0
X-Received: by 10.50.30.6 with SMTP id o6mr10526794igh.43.1400423960616; Sun,
 18 May 2014 07:39:20 -0700 (PDT)
Received: by 10.64.27.161 with HTTP; Sun, 18 May 2014 07:39:20 -0700 (PDT)
In-Reply-To: <1400401410-32600-1-git-send-email-chenj@lemote.com>
References: <1400401410-32600-1-git-send-email-chenj@lemote.com>
Date:   Sun, 18 May 2014 22:39:20 +0800
X-Google-Sender-Auth: Hpg6yxtzCBFsM3rpTptpfL-choA
Message-ID: <CAAhV-H6zvhUvjoQiG9-e5HHGBkbLJvN_LkbEZWEzfjJEmrmLgg@mail.gmail.com>
Subject: Re: [PATCH 2/2] MIPS: lib: csum_partial: use wsbh/movn on ls3
From:   Huacai Chen <chenhc@lemote.com>
To:     chenj <chenj@lemote.com>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40131
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

Due to Wang Rui's tests, Loongson-3's EI/DI instructions don't have
correct behaviors, its Status.FR is also different with MIPS64R2. So,
I don't want to select CPU_MIPS64_R2.

On Sun, May 18, 2014 at 4:23 PM, chenj <chenj@lemote.com> wrote:
> [PATCH] MIPS: Loongson 3: Select CPU_MIPS64_R2
>
> To chenhc: Please review this.
>
