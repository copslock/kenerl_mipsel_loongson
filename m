Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 12:41:30 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:42206 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993064AbcKJLlVIFbva (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 12:41:21 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id de2019d9
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 11:39:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=n5ddDEvXbxg+r0JSj6N0fqXh1kY=; b=jXAw2H
        A2O+9D1YcHmM0vcqcErrwNiHnmv+FTF9o4Fy0ENXNm7W4l5kwKZjF8n1RIkRO8Xk
        8cTG55HtLwe9DKj+2JNUACQbAwIYY0qdJlU0YBZ64cH7/cMn4qLlBfGfMEsbFZWC
        OgDW1v5X2T/h67waWT9HhFaLPNI1dpwCvGSOCFpptjWL5cQs91qytL0M5ZPPYFd2
        JRcmHh/Bv5BxPP4EL8g/bP99Ca+DYw+t8TT3Sm7MhH7vz9xp8KBzND//a4skweTE
        22dS9dBhlmWYqJxCBq8DL3wrpccmguh96VLCe+aE9Hcw49HcrQp8VyDv7gzc24YV
        Mqa2J9cJh9oi6sSQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id bd092a13 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 11:39:01 +0000 (UTC)
Received: by mail-lf0-f42.google.com with SMTP id b14so187052615lfg.2
        for <linux-mips@linux-mips.org>; Thu, 10 Nov 2016 03:41:07 -0800 (PST)
X-Gm-Message-State: ABUngvf5ILPfMSkYm3lsZF7Qr1t9ryhx0knInZxZFnmQg7yojpONUdyBq+cOBTZPslTSZ3zL/w5Hhld2AiEp1Q==
X-Received: by 10.25.99.12 with SMTP id x12mr2148952lfb.174.1478778065320;
 Thu, 10 Nov 2016 03:41:05 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Thu, 10 Nov 2016 03:41:04 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1611100959040.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <alpine.DEB.2.20.1611092227200.3501@nanos> <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
 <alpine.DEB.2.20.1611100959040.3501@nanos>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Nov 2016 12:41:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
Message-ID: <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
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
X-archive-position: 55770
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

On Thu, Nov 10, 2016 at 10:03 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> If you want to go with that config, then you need
> local_bh_disable()/enable() to fend softirqs off, which disables also
> preemption.

Thanks. Indeed this is what I want.

>
>> What clever tricks do I have at my disposal, then?
>
> Make MIPS use interrupt stacks.

Yea, maybe I'll just implement this. It clearly is the most correct solution.
@MIPS maintainers: would you merge something like this if done well?
Are there reasons other than man-power why it isn't currently that
way?

> Does the slowdown come from the kmalloc overhead or mostly from the less
> efficient code?
>
> If it's mainly kmalloc, then you can preallocate the buffer once for the
> kthread you're running in and be done with it. If it's the code, then bad
> luck.

I fear both. GCC can optimize stack variables in ways that it cannot
optimize various memory reads and writes.

Strangely, the solution that appeals to me most at the moment is to
kmalloc (or vmalloc?) a new stack, copy over thread_info, and fiddle
with the stack registers. I don't see any APIs, however, for a
platform independent way of doing this. And maybe this is a horrible
idea. But at least it'd allow me to keep my stack-based code the
same...
