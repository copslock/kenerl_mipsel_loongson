Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 00:35:14 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:58860 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993010AbcKIXfEQAa66 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 00:35:04 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 7edfb720
        for <linux-mips@linux-mips.org>;
        Wed, 9 Nov 2016 23:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=5hW1Hc0YVYXzrZLcj9HcmH0yESg=; b=rseX7S
        NRBWOshFPcIZz4h6Qehf/rzbL2cqCIxVRuYgGtrXdoeKdTfdagKAcNWPNBjsu3S7
        aHn9/MJ9nFfUN8SW8QnWiwd+yVEmeGD2dag69JYI2x5XfvSSxuHdnKCrHQMesiWN
        HrFUpspRPhitOcPk++uD72zuD7ktSbaYQAd3ZnegniPYki0dMmQiF1ftS9t3dBDH
        g9vmVHql0ZDrgQCfDKhKmy3KGeBv62msR3r+yiI4O8pICNiGMvVeXrikguFC3DxZ
        e6vnR61NGt3oEKqDlD5RoNQ0NW3xnTKGJn20XrRpKi8VuCgIr+qxgP1moR78UOqF
        oXuvtcgktUoqrBCA==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 5ac9057b (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Wed, 9 Nov 2016 23:32:55 +0000 (UTC)
Received: by mail-lf0-f48.google.com with SMTP id o141so104522173lff.1
        for <linux-mips@linux-mips.org>; Wed, 09 Nov 2016 15:34:56 -0800 (PST)
X-Gm-Message-State: ABUngvcP+/rFyQ9GTmOBs+jULC5/wFoFvf8KgFI+spVNGvAtOqmziDAdniY8vtYZpAJJ9UCersVtBSL4Glm+YQ==
X-Received: by 10.25.99.12 with SMTP id x12mr930616lfb.174.1478734495052; Wed,
 09 Nov 2016 15:34:55 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Wed, 9 Nov 2016 15:34:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1611092227200.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <alpine.DEB.2.20.1611092227200.3501@nanos>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Nov 2016 00:34:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
Message-ID: <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
Subject: Re: Proposal: HAVE_SEPARATE_IRQ_STACK?
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org,
        linux-mm@kvack.org,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        k@vodka.home.kg
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jason@zx2c4.com
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

Hey Thomas,

On Wed, Nov 9, 2016 at 10:40 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> That preempt_disable() prevents merily preemption as the name says, but it
> wont prevent softirq handlers from running on return from interrupt. So
> what's the point?

Oh, interesting. Okay, then in that case the proposed define wouldn't
be useful for my purposes. What clever tricks do I have at my
disposal, then?

>> If not, do you have a better solution for me (which doesn't
>> involve using kmalloc or choosing a different crypto primitive)?
>
> What's wrong with using kmalloc?

It's cumbersome and potentially slow. This is crypto code, where speed
matters a lot. Avoiding allocations is usually the lowest hanging
fruit among optimizations. To give you some idea, here's a somewhat
horrible solution using kmalloc I hacked together: [1]. I'm not to
happy with what it looks like, code-wise, and there's around a 16%
slowdown, which isn't nice either.

[1] https://git.zx2c4.com/WireGuard/commit/?h=jd/curve25519-kmalloc
