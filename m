Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 30 Jul 2014 20:17:40 +0200 (CEST)
Received: from mail-wi0-f182.google.com ([209.85.212.182]:56603 "EHLO
        mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860095AbaG3SReEooC- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 30 Jul 2014 20:17:34 +0200
Received: by mail-wi0-f182.google.com with SMTP id d1so2823920wiv.15
        for <linux-mips@linux-mips.org>; Wed, 30 Jul 2014 11:17:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=srpC5TwR5f9Ay9ioaUbeSJuhjNHfUiBAhaHRqhSh9Wc=;
        b=PLktntzvJMxhsYwQHNPYeg1m2pZEZVpYq9ja3p6iKKHS7tUeWHeW9iBhuxVpplyheT
         3aInQr+MLZSpQ/OU9o4Dqt2Wyr/poK2dSfmHkl45AD4J1BzV+5+nC+aJnFkOowIDsutf
         xcdslImecgYeogyVKwPgIjmV4mnLisaXx1df04EKpwWQoMwIxfAqJomdx/j5/E6s/+TX
         eBVXNTwq/zmAZS0PpSmUDbcdouswOGpVMkV3Ec0VTChwf53GltmKlTjAeizYl2PU12oe
         N1Ob8uhC8a9f4FUxsy1eOYmkFuqgCX4r5Ofk4oyeqzd7AOhPQtuvE8aG1cNUP0bjo4cq
         ZE8A==
X-Gm-Message-State: ALoCoQmFWoGA3Dj09eAH5pwZ4lOrMez496/hMEung8WM+Dj42fdrAAtBEXWvjaoewIwJGIrRkBt1
MIME-Version: 1.0
X-Received: by 10.180.80.133 with SMTP id r5mr9227676wix.62.1406744248446;
 Wed, 30 Jul 2014 11:17:28 -0700 (PDT)
Received: by 10.194.122.170 with HTTP; Wed, 30 Jul 2014 11:17:28 -0700 (PDT)
In-Reply-To: <53D9169D.3020705@imgtec.com>
References: <53D9169D.3020705@imgtec.com>
Date:   Wed, 30 Jul 2014 19:17:28 +0100
Message-ID: <CAOFt0_C1mCsnn56uhpQy8zR-zhT9T_rK6P8YNAKKkoHrgnT_9g@mail.gmail.com>
Subject: Re: Please add my temporary MIPS fixes branch to linux-next
From:   Alex Smith <alex@alex-smith.me.uk>
To:     James Hogan <james.hogan@imgtec.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Ralf <ralf@linux-mips.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jarno <aurelien@aurel32.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        "Markos (GMail)" <markos.chandras@gmail.com>,
        Markos <markos.chandras@imgtec.com>,
        Paul <paul.burton@imgtec.com>,
        Rob Kendrick <rob.kendrick@codethink.co.uk>,
        Huacai Chen <chenhc@lemote.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <alex@alex-smith.me.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41822
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: alex@alex-smith.me.uk
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

On 30 July 2014 17:00, James Hogan <james.hogan@imgtec.com> wrote:
> This one fixes mips32 debian boot, but changes the layout of the
> NT_PRSTATUS regset which is accessible through ptrace. I don't believe
> this will break anything, but there are other patches pending in the
> patchset to fix up the regset stuff properly anyway (as it is already
> broken for core dumps) and I don't really want to take the risk without
> Ralf's okay.
>
> Alex Smith (1):
>       MIPS: O32/32-bit: Fix bug which can cause incorrect system call
> restarts

Right now the NT_PRSTATUS regset can't be relied upon to return the
same layout anyway, as it can differ depending on whether the kernel
is 32- or 64-bit, as well as with a couple of other Kconfig options.
Changing it in this patch shouldn't make things any worse. As you say
other patches in the series properly fix the regset/core dump
situation, though I suppose they aren't too critical for 3.16 as
nobody seems to have noticed/cared that core dumps aren't working
until now!

Thanks,
Alex
