Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 15 Jan 2017 14:40:18 +0100 (CET)
Received: from [192.95.5.64] ([192.95.5.64]:54345 "EHLO frisell.zx2c4.com"
        rhost-flags-FAIL-FAIL-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990517AbdAONkKj91jF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 15 Jan 2017 14:40:10 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id c30d48d0;
        Sun, 15 Jan 2017 13:29:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=tKj+2NGYqJIUipLHHLQcxjnk5PA=; b=i383Wv
        u/d+1fewLlG5O+Knwpsgvfry4/5gqFtSZibvj6khjF2SsusKg56HzI9gqfMzXTx4
        I2nknfwTiO9Bvvn0//OF3gyYfq4W3dULNV5RxCY1JiX3gIf4QMEZmunKZnogP8am
        CStXAXHMlZkOo8SKz5rNrg+G7aTWS0ArCMPPyNfNU4JYTSzYHcGMTDVL2rnTN8ZB
        Qv2trP9X1NhmR6adP6kD2e8DjCmjWABPpVEMZOnMFKYHTDI5CvbSveAxKlePwW1w
        rAvVQ48Aa5uIMjXZBmbq++Otx+wGoPjPeMIYfNaBAWd9MOTuMicq5KLQlzbQrkdt
        qNJ/K40M1BJZ/+jw==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a1fc5db9 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Sun, 15 Jan 2017 13:29:28 +0000 (UTC)
Received: by mail-ot0-f169.google.com with SMTP id 65so30230923otq.2;
        Sun, 15 Jan 2017 05:39:51 -0800 (PST)
X-Gm-Message-State: AIkVDXKj29Vzt1z0miNp66O4EGVBzkWGfygC4YPWVkbMa27UTxGDuEmAY1F0dDJR7blbqwVSzJr5vaK/i4nUzQ==
X-Received: by 10.157.7.232 with SMTP id 95mr13346751oto.145.1484487589840;
 Sun, 15 Jan 2017 05:39:49 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Sun, 15 Jan 2017 05:39:49 -0800 (PST)
In-Reply-To: <20170113094939.GI10569@jhogan-linux.le.imgtec.org>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com>
 <20170111012032.GE31072@linux-mips.org> <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
 <20170113094939.GI10569@jhogan-linux.le.imgtec.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 15 Jan 2017 14:39:49 +0100
X-Gmail-Original-Message-ID: <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
Message-ID: <CAHmME9oG65MFwT=5m8uaeLw8uf5kS8nC9oBBLf9_v11bTsiAsg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
To:     James Hogan <james.hogan@imgtec.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56311
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

Hi James,

On Fri, Jan 13, 2017 at 10:49 AM, James Hogan <james.hogan@imgtec.com> wrote:
> Its quite a significant change/feature, especially in terms of potential
> for further breakage. I don't think its really stable material to be
> honest.  It sounds bad if the kernel stack requirement can be made
> arbitrarily large by stacking too many drivers.

Indeed I believe this is the case. If, say, a kthread is already using
a bit of stack, and then a softirq chain of stacked virtual network
drivers is called, the stack can be busted.

> Is there a simpler fix/workaround for the issue that would satisfy
> stable kernel users until they can upgrade to a kernel with irqstacks?

The simplest solution is probably just not stacking tons of network
drivers. For my own out-of-tree curve25519-donna code that's in
OpenWRT and uses a fair amount of stack, I just kmalloc on MIPS but
not on x86, so in terms of my own stuff there's already a workaround
in place. But this still doesn't solve things for users who have some
interesting networking requirements and stack a few drivers.

Unfortunately, most folks are only testing stuff on ARM and x86, which
already have the separate IRQ stacks, so they aren't hitting crashes.

So, in the end, I'm not quite sure. On the one hand, this fixes an
actual problem and it'd be nice to see stable kernels have the fix. On
the other hand, this is a rather big change. I don't know how to
assess it, but I've copied Greg on this email, who certainly has
better judgement about this than me.

Jason
