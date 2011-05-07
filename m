Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 15:58:05 +0200 (CEST)
Received: from mail-gw0-f49.google.com ([74.125.83.49]:62859 "EHLO
        mail-gw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491133Ab1EGN6C convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 7 May 2011 15:58:02 +0200
Received: by gwb1 with SMTP id 1so1690053gwb.36
        for <linux-mips@linux-mips.org>; Sat, 07 May 2011 06:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc:content-type:content-transfer-encoding;
        bh=qdWXqpLcSdrAozQSyMRhm8+brTjY5ljbON6AkM7gwx4=;
        b=SigZo8TCsMtxb5LcTlVeJbAuf4BZQIL3JEmm1ZvwG0mPvcIF9NAvcIhGqkAmeACr0c
         0Iu9ZD8HiPa7KrreNap/FzutuJQMGPn1IUY2hpu7yVbGJtOmrZyc2nuTo4J76k3fX4L7
         4mnW0JvEF6g0NvIELuX84ZZ30S3XIuQLSAMJA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        b=uZNU4vBtr1nEzDniqj6ZZSb/STeRU4c7Li1naXui78IaDNyP+rOE2yrOj1Jnq6bA1k
         WSnSeNLRM7/B8Ul6Yq2l0e33egeSpjsbxNf5KRjAS4vE5LtLKvLVTjOB090mjNwcFunZ
         u7nex1U1AzW+fN+QwkR6l/uEQ3Iex/8UcKBcY=
Received: by 10.91.69.37 with SMTP id w37mr4286956agk.196.1304776676200; Sat,
 07 May 2011 06:57:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.91.54.28 with HTTP; Sat, 7 May 2011 06:57:36 -0700 (PDT)
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
From:   Mike Frysinger <vapier.adi@gmail.com>
Date:   Sat, 7 May 2011 09:57:36 -0400
Message-ID: <BANLkTim4RFeFpj8uJsnm0gazLOMdYr8P1Q@mail.gmail.com>
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <vapier.adi@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29862
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vapier.adi@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, May 7, 2011 at 01:57, Stephen Boyd wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: uclinux-dist-devel@blackfin.uclinux.org
>  arch/blackfin/Kconfig.debug  |    9 ---------

Acked-by: Mike Frysinger <vapier@gentoo.org>
-mike
