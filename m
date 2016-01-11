Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 11 Jan 2016 12:06:47 +0100 (CET)
Received: from mail-ig0-f195.google.com ([209.85.213.195]:34570 "EHLO
        mail-ig0-f195.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010561AbcAKLGjxuG6e (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 11 Jan 2016 12:06:39 +0100
Received: by mail-ig0-f195.google.com with SMTP id ik10so12814051igb.1
        for <linux-mips@linux-mips.org>; Mon, 11 Jan 2016 03:06:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=OvnSrMHix85kC2HKhwvXVonEqsYwNIkB8jXCRdnopyY=;
        b=dFD34J5EfKYDeLuezg+VoVyRx9/zfuiS8ktgAUkvKeNdA8Dsn6NVbVxFR4yBHlTHNl
         hBTBfhMqQW9+DokEWDEOGQ7OzMMUSizBbyupLM8I1GZRxyBydtCm8YP9FJELiIrrLXGK
         7cf/an547WJzrbu+ZF7ky+6pgJhqLYH+FjKM8r6RoZfNwKZrBPySivdvNfuQl2uBdqUC
         cV9DzqoivPPrkx5aIyRO42S77M+1GN8hO+bewpuKk2K8jouSIAvKNmF9irtt4EIMQM1z
         Hw930Q61I1pSisyhD1G5MQ2+HwsbHvD70H2c4TDiCJS9vnqw2RNQDpenifPZdN0Y/2Ke
         R+lg==
X-Received: by 10.50.43.228 with SMTP id z4mr10666737igl.27.1452510393965;
 Mon, 11 Jan 2016 03:06:33 -0800 (PST)
MIME-Version: 1.0
Received: by 10.79.111.1 with HTTP; Mon, 11 Jan 2016 03:06:14 -0800 (PST)
In-Reply-To: <20160111130334-mutt-send-email-mst@redhat.com>
References: <1452509968-19778-1-git-send-email-mst@redhat.com> <20160111130334-mutt-send-email-mst@redhat.com>
From:   Julian Calaby <julian.calaby@gmail.com>
Date:   Mon, 11 Jan 2016 22:06:14 +1100
Message-ID: <CAGRGNgXnxjmvjD8_vT17ZWwK0uCsGNmXq_KdVj9KoT6NRZQvPA@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] checkpatch: handling of memory barriers
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-arch@vger.kernel.org,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        virtualization@lists.linux-foundation.org,
        Stefano Stabellini <stefano.stabellini@eu.citrix.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>,
        David Miller <davem@davemloft.net>, linux-ia64@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux <sparclinux@vger.kernel.org>,
        "Mailing List, Arm" <linux-arm-kernel@lists.infradead.org>,
        linux-metag@vger.kernel.org, linux-mips@linux-mips.org,
        x86@kernel.org, user-mode-linux-devel@lists.sourceforge.net,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-sh@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        xen-devel@lists.xenproject.org, Ingo Molnar <mingo@kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Russell King - ARM Linux <linux@arm.linux.org.uk>
Content-Type: text/plain; charset=UTF-8
Return-Path: <julian.calaby@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51059
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: julian.calaby@gmail.com
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

Hi Michael,

On Mon, Jan 11, 2016 at 10:04 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
> On Mon, Jan 11, 2016 at 12:59:25PM +0200, Michael S. Tsirkin wrote:
>> As part of memory barrier cleanup, this patchset
>> extends checkpatch to make it easier to stop
>> incorrect memory barrier usage.
>>
>> This replaces the checkpatch patches in my series
>>       arch: barrier cleanup + barriers for virt
>> and will be included in the pull request including
>> the series.
>>
>> changes from v3:
>>       rename smp_barrier_stems to barrier_stems
>>       as suggested by Julian Calaby.
>
> In fact it was Joe Perches that suggested it.
> Sorry about the confusion.

I was about to point that out.

FWIW this entire series is:

Acked-by: Julian Calaby <julian.calaby@gmail.com>

Thanks,

-- 
Julian Calaby

Email: julian.calaby@gmail.com
Profile: http://www.google.com/profiles/julian.calaby/
