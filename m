Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2016 18:40:10 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:51108 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993148AbcKJRkD5WtiO (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 10 Nov 2016 18:40:03 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 55c364f1
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 17:37:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=w+c5j4Nw6cNicku3RtnNkhoTcP8=; b=iVlhuw
        EoOuGN+ClUbhYGbbpE1S0lgsj+9gJmF86IImRyOxyvdtdjhw9leCCYwvYQ+zHe7Z
        /8YXBNhsXHZvNf2ZgHyhDOctCBqIHJPcQr78rq6cfu71pETHjjINol8INHQXeWav
        hxNA3nftpxcvbpE1BOMX8CYm0ubYvmdJMznsQcoLjJBQDsyWqARnd5NRuRAPzE5d
        uGY8N5i2cDVexy2txDqWi4NPsYoLYeqpO4+vNTD0pUMWl8jE+zARW2PXbECBRyv6
        miUeOAoMXAiy6uJEhH46g5QwQ5VMGDAScnmCUoX4vjK1HB5wd4PEdOpbDHNC8CE2
        spcUX5tPeQV9bEcQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 61991641 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 10 Nov 2016 17:37:49 +0000 (UTC)
Received: by mail-lf0-f51.google.com with SMTP id b14so195443435lfg.2
        for <linux-mips@linux-mips.org>; Thu, 10 Nov 2016 09:39:56 -0800 (PST)
X-Gm-Message-State: ABUngvcqYRg2baqBAl4gY8nKyHBviOGyaZCy97LWbvDaytfHY940MtcIEsY/5yKpjrnkwr/QJraGDvvpO2qhDA==
X-Received: by 10.25.44.66 with SMTP id s63mr3923815lfs.159.1478799594853;
 Thu, 10 Nov 2016 09:39:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.208.80 with HTTP; Thu, 10 Nov 2016 09:39:54 -0800 (PST)
In-Reply-To: <alpine.DEB.2.20.1611101351260.3501@nanos>
References: <CAHmME9oSUcAXVMhpLt0bqa9DKHE8rd3u+3JDb_wgviZnOpP7JA@mail.gmail.com>
 <alpine.DEB.2.20.1611092227200.3501@nanos> <CAHmME9pGoRogjHSSy-G-sB4-cHMGcjCeW9PSrNw1h5FsKzfWAw@mail.gmail.com>
 <alpine.DEB.2.20.1611100959040.3501@nanos> <CAHmME9pHYA82M3iDNfDtDE96gFaZORSsEAn_KnePd3rhFioqHQ@mail.gmail.com>
 <alpine.DEB.2.20.1611101351260.3501@nanos>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 10 Nov 2016 18:39:54 +0100
X-Gmail-Original-Message-ID: <CAHmME9rv8CfgY87S_HVN3njc2RnisjoxzfZxY=H=2FzZkrQqLg@mail.gmail.com>
Message-ID: <CAHmME9rv8CfgY87S_HVN3njc2RnisjoxzfZxY=H=2FzZkrQqLg@mail.gmail.com>
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
X-archive-position: 55778
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

Hi Thomas,

On Thu, Nov 10, 2016 at 2:00 PM, Thomas Gleixner <tglx@linutronix.de> wrote:
> Do not even think about going there. That's going to be a major
> mess.

Lol! Okay. Thank you for reigning in my clearly reckless
propensities... Sometimes playing in traffic is awfully tempting.

>
> As a short time workaround you can increase THREAD_SIZE_ORDER for now and
> then fix it proper with switching to seperate irq stacks.

Okay. I think in the end I'll kmalloc, accept the 16% slowdown [1],
and focus efforts on having a separate IRQ stack. Matt emailed in this
thread saying he was already looking into it, so I think by the time
that slowdown makes a difference, we'll have the right pieces in place
anyway.

Thanks for the guidance here.

Regards,
Jason

[1] https://git.zx2c4.com/WireGuard/commit/?id=cc3d7df096a88cdf96d016bdcb2f78fa03abb6f3
