Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 07 May 2011 11:34:23 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:57428 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491091Ab1EGJeT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 7 May 2011 11:34:19 +0200
Received: by qyk32 with SMTP id 32so173758qyk.15
        for <linux-mips@linux-mips.org>; Sat, 07 May 2011 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=W5wBK0z0EUrvQyCJT8CpsoCttbsrZMtSsWXEPYVPEZc=;
        b=hwkmDLHujzf1JOmm3EhjyW8upxjRYgAZwbQ3OqQrt0/hSyIKdI8dOd6RGgiolW6PS4
         9RYh0YYkBQ4E716Kp+gwynyBBxXy5P9zioXlXjxLyqzLRdw9yLuBECmPQtNVgYXZbHuX
         cXsU98EeZFAMydU4ZjEbYs7Y/T56fLxEF6EmU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=mgV2bLMx3VUAdB+8XUTU0H9RJ/WP+1TEAnuSBJ1vFVpKOTcIDroyKjWIMjqrc7nflU
         0Y/UqcBlwgdKW0qhCcmexDYGUxopDjq2pM6PXuFMiLLogwXE56geGoe4Qbauz23ExPEX
         qWap9e9El189yStq2x45uRgQ2aOiQTjJq9s+w=
MIME-Version: 1.0
Received: by 10.224.63.199 with SMTP id c7mr4432120qai.146.1304760853419; Sat,
 07 May 2011 02:34:13 -0700 (PDT)
Received: by 10.224.10.204 with HTTP; Sat, 7 May 2011 02:34:13 -0700 (PDT)
In-Reply-To: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
References: <1304747831-2098-1-git-send-email-sboyd@codeaurora.org>
Date:   Sat, 7 May 2011 11:34:13 +0200
Message-ID: <BANLkTi=h-151_cMPpii6O+kowvc=0WxKjQ@mail.gmail.com>
Subject: Re: [PATCH] lib: Consolidate DEBUG_STACK_USAGE option
From:   richard -rw- weinberger <richard.weinberger@gmail.com>
To:     Stephen Boyd <sboyd@codeaurora.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        uclinux-dist-devel@blackfin.uclinux.org,
        linux-m32r@ml.linux-m32r.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, Chris Metcalf <cmetcalf@tilera.com>,
        user-mode-linux-devel@lists.sourceforge.net, x86@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <richard.weinberger@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29854
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard.weinberger@gmail.com
Precedence: bulk
X-list: linux-mips

On Sat, May 7, 2011 at 7:57 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> Most arches define CONFIG_DEBUG_STACK_USAGE exactly the same way.
> Move it to lib/Kconfig.debug so each arch doesn't have to define
> it. This obviously makes the option generic, but that's fine
> because the config is already used in generic code.
>
> It's not obvious to me that sysrq-P actually does anything
> different with this option enabled, but I erred on the side of
> caution by keeping the most inclusive wording.
>
> Cc: linux-arch@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: uclinux-dist-devel@blackfin.uclinux.org
> Cc: linux-m32r@ml.linux-m32r.org
> Cc: linux-mips@linux-mips.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: Chris Metcalf <cmetcalf@tilera.com>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> Cc: x86@kernel.org
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---

Acked-by: Richard Weinberger <richard@nod.at>

-- 
Thanks,
//richard
