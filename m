Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2017 00:33:17 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:45430 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993911AbdAKXdJMrM7C (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 12 Jan 2017 00:33:09 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 48a145ce;
        Wed, 11 Jan 2017 23:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=ecnswFMhAS9CMZjfspjrvaWycVQ=; b=EKVopB
        GUrcZ8MFyj+6T71RdhvGXWPzzzQjfdh0myvnCOTyrKD1R6cXasn4BJ3RHtA8w0H/
        +w8byYNCxvqW8Fsh1EtRUcemk5wcWjVAUdvV85AHKvgw9KR7m6yJombODLerkhfK
        Y1azKKDYdzDURohHoLtntK0c4qz8mcInpmDSxVoQuFD7Vjt+Y5Z9V8EQoNN2rD5E
        6+/CNT7wvuIz93eMlDD2hGvKpZIqNwhzvLYSxqiz1Ox2u8VoC0cXTUrjCTELDajg
        y8lsLCMWIGXOVizQIbpS0rm7v/WQoccecLIV6+1T+THhF6OEUAhZi2/R9LjDSOa9
        bGykiF300+R/VOjQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 157f9549 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO);
        Wed, 11 Jan 2017 23:22:59 +0000 (UTC)
Received: by mail-oi0-f49.google.com with SMTP id w204so4345875oiw.0;
        Wed, 11 Jan 2017 15:32:54 -0800 (PST)
X-Gm-Message-State: AIkVDXK/MaOVUZ8HpdQ8ivZQgK/VH4yS6cOyWqCiQQ4eVDTZhlAnPV+HH255H7Zp4y4mknlBb5OZbOTGxI5tkg==
X-Received: by 10.202.181.70 with SMTP id e67mr5029805oif.3.1484177573455;
 Wed, 11 Jan 2017 15:32:53 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.14.167 with HTTP; Wed, 11 Jan 2017 15:32:52 -0800 (PST)
In-Reply-To: <20170111012032.GE31072@linux-mips.org>
References: <1482157260-18730-1-git-send-email-matt.redfearn@imgtec.com>
 <CAHmME9pRnCW5875vL=mr_D0Lq8nPZ69L-7gVaaHuO7EMTBp6Ew@mail.gmail.com>
 <CAHmME9ogK=NsWgks2Uarty5AeWSZuYmujjBovQO6FWAAXKsopQ@mail.gmail.com> <20170111012032.GE31072@linux-mips.org>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 12 Jan 2017 00:32:52 +0100
X-Gmail-Original-Message-ID: <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
Message-ID: <CAHmME9qXeO=qFvWXenVO6gVAftk1M2vdQt7nwABRDqvDcV3dPg@mail.gmail.com>
Subject: Re: [PATCH v3 0/5] MIPS: Add per-cpu IRQ stack
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Matt Redfearn <matt.redfearn@imgtec.com>,
        linux-mips@linux-mips.org, Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Adam Buchbinder <adam.buchbinder@gmail.com>,
        James Hogan <james.hogan@imgtec.com>,
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
X-archive-position: 56278
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

On Wed, Jan 11, 2017 at 2:20 AM, Ralf Baechle <ralf@linux-mips.org> wrote:
> On Wed, Jan 11, 2017 at 12:32:38AM +0100, Jason A. Donenfeld wrote:
>
>> Was this ever picked up for 4.10 or 4.11?
>
> Still sitting in -next as commit 3cc3434fd630 and its four parent commits.

Oh, good, so it's progressing normally. I just didn't see any
acknowledgement on this thread so I was worried.

Can this propagate to stable? A few OpenWRT MIPS people are
complaining to me about sporadic crashes when stacking too many
virtual network drivers (batman over gre over ppp over ...), which is
solved by this patchset.

Jason
