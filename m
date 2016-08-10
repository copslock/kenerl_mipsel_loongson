Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Aug 2016 15:44:10 +0200 (CEST)
Received: from mail-oi0-f47.google.com ([209.85.218.47]:35933 "EHLO
        mail-oi0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992155AbcHJNoAYDuIV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Aug 2016 15:44:00 +0200
Received: by mail-oi0-f47.google.com with SMTP id f189so59500389oig.3
        for <linux-mips@linux-mips.org>; Wed, 10 Aug 2016 06:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=7Nnqaf2RdOB19uw59IDAON2A3M9yw7uixoV/reg9T/0=;
        b=LLVKL/L+uRdiMP9St8VH4x6evZaeCQ9v1XjFWQEkuvx4gHndPfhLpfbJD3lWub08oQ
         Zu5YmIiUxxjjP1guUCJil+4yJH4rZ6YArMaC03DhXh3gVW7rxse/s5NLAYnPb40HlYeQ
         aSsd641re87+8CrWJjyqqZnTihx9AcJle3cA4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=7Nnqaf2RdOB19uw59IDAON2A3M9yw7uixoV/reg9T/0=;
        b=FBqR5Ghg1j1xigJ2yayojdH9E84vIW16jWhMxBt7MJmRbjQbTtqFlnrrZZPuV4N9WU
         nztjpYUQniy4fLlkqjZYDnNiQd4oNtPjQNvcGMhDsaJPs+KI9cZ1iYCCZCdHTJK+xWFG
         pphjETaOvpGyX4EjkIyakCb/NJhGc+YT0Wijzrofm/9CcyruggNDxL6FTXSniBO9xm1K
         +ZjQ1BN9pLx2G4PPF74Y9+v6sMEjP5md1itWppU/potVykl9e1uFROlzOk6z8E+SgZkZ
         a8xOf9OOuJtRTd5AjRAaTKJPaHZICVNoFrrmLla2CAoWiReVf1y9fvRkjBwi+XbN38mX
         oIow==
X-Gm-Message-State: AEkoouvGEHwEw6yf//pUw4v9dhEMFbe49G0jep6Y/Nb/7Q+c2PWZ2peqB+1dmbvJ/AjKb+zx8dXIVwQdzEy8Bvmr
X-Received: by 10.202.73.205 with SMTP id w196mr2070545oia.40.1470836634571;
 Wed, 10 Aug 2016 06:43:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.182.13.34 with HTTP; Wed, 10 Aug 2016 06:43:54 -0700 (PDT)
In-Reply-To: <1470730991-24498-1-git-send-email-keguang.zhang@gmail.com>
References: <1470730991-24498-1-git-send-email-keguang.zhang@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 10 Aug 2016 15:43:54 +0200
Message-ID: <CACRpkdacvVodxyCss5NUNXAQJszFmQ=cz=UUo83taD2JvcVQ6g@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson1C: Remove ARCH_WANT_OPTIONAL_GPIOLIB
To:     Keguang Zhang <keguang.zhang@gmail.com>
Cc:     Linux MIPS <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Yang Ling <gnaygnil@gmail.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <linus.walleij@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54472
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

On Tue, Aug 9, 2016 at 10:23 AM, Keguang Zhang <keguang.zhang@gmail.com> wrote:

> From: Kelvin Cheung <keguang.zhang@gmail.com>
>
> This patch removes ARCH_WANT_OPTIONAL_GPIOLIB due to upstream changes.
>
> Signed-off-by: Kelvin Cheung <keguang.zhang@gmail.com>

Acked-by: Linus Walleij <linus.walleij@linaro.org>

I thought this was already fixed?

Oh well, the MIPS maintainers can probably figure it out.

Yours,
Linus Walleij
