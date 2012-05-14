Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 May 2012 22:07:19 +0200 (CEST)
Received: from mail-yw0-f49.google.com ([209.85.213.49]:40715 "EHLO
        mail-yw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903724Ab2ENUHL convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 14 May 2012 22:07:11 +0200
Received: by yhjj52 with SMTP id j52so5472549yhj.36
        for <linux-mips@linux-mips.org>; Mon, 14 May 2012 13:07:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding:x-gm-message-state;
        bh=oiTPD9OEJ+d58iQw0QsPsUspcV0XE+ALke/E6Hc6Ly0=;
        b=fX/2sHIuXdslUFxDaMhXi9CIrT3Ub6yCRXW//HmcBl+/JduupHOKSgZ9TscBZxxqxA
         T2JhJFlQumh9LRlmFE7fTdoKkURLdv1P18V3MW2tRVEfl72EZ8PreNKoVuHLttxhQSr4
         6WFymHLghE6Hf8wDlfOodtyEB1QEkYmC/VWM+TeCmq2mNa3IStx3Qt5/XBGgNx5bEo48
         JqVCSsItpjFuSYndtj7v77wa71KTvvg9/Yh43PkQrBH7DvbuM8L6mYgRePh97wWBEcd3
         N6ExHOYnp9XNp/X5aalw4NW4MEYaWnu/PEDDoCMDh0ridzw3TvbcigoNskD/j+35Q/iB
         DrdA==
MIME-Version: 1.0
Received: by 10.101.136.12 with SMTP id o12mr2830575ann.53.1337026025154; Mon,
 14 May 2012 13:07:05 -0700 (PDT)
Received: by 10.147.137.4 with HTTP; Mon, 14 May 2012 13:07:05 -0700 (PDT)
In-Reply-To: <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
References: <1336772086-17248-1-git-send-email-ddaney.cavm@gmail.com>
        <1336772086-17248-3-git-send-email-ddaney.cavm@gmail.com>
Date:   Mon, 14 May 2012 22:07:05 +0200
Message-ID: <CACRpkdaAeMV2yCNNP+e0BKaXEeZon2CKJs-TskVH5CVWXuqyiA@mail.gmail.com>
Subject: Re: [PATCH 2/2] spi: Add SPI master controller for OCTEON SOCs.
From:   Linus Walleij <linus.walleij@linaro.org>
To:     David Daney <ddaney.cavm@gmail.com>
Cc:     devicetree-discuss@lists.ozlabs.org,
        Grant Likely <grant.likely@secretlab.ca>,
        Rob Herring <rob.herring@calxeda.com>,
        spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org,
        David Daney <david.daney@cavium.com>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-Gm-Message-State: ALoCoQk2YaMNdw1stQL2qhSsM9KaBUiIjymDxt/x/EQEHHmcmtPg4I36HJ0fCVwcBEaudq1hIHwd
X-archive-position: 33316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linus.walleij@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On Fri, May 11, 2012 at 11:34 PM, David Daney <ddaney.cavm@gmail.com> wrote:

> +       mpi_cfg.u64 = 0;
> +       mpi_cfg.u64 |= p->cs_enax;
> +       if (mpi_cfg.u64 != p->last_cfg) {

But now I see why this 64bit is so clever. Forget the comment on 1/2!
This has a certain elegance to it that I just learned to appreciate.

Yours,
Linus Walleij
