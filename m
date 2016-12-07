Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 07 Dec 2016 19:36:07 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:33739 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992571AbcLGSgAt3pBI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 7 Dec 2016 19:36:00 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 84504c58
        for <linux-mips@linux-mips.org>;
        Wed, 7 Dec 2016 18:30:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :from:date:message-id:subject:to:cc:content-type; s=mail; bh=oyk
        v23MKIpqPS3M5VuCoaQAcrr0=; b=bpimWirKQQAE9hVd7b5yTOQV/hdSyB2qHg/
        DEnAH4CEwnNGW95VyBdB/q/ePWUUR3Tmb/bkbLzYgt+Dg1s41/UeOQik2IKAE0Ax
        STiMYBE9t00EbtnlhIrB1h1X7S5i2TPQ0rURRnrYeMwkbp3vHmsDt7aygQxXt0zT
        SA6jgLOKR6QqlB9Ci6ig+coZSlkGwsJNJK80YmroAPMu+1UbIBps/wKREdaAgeEV
        oj3FpT1/Cq86Vefyt/seLz3NtlMQT9mzN7e8J8Z9S5EONPQfzS+flxc2+tX+NI1d
        UkFZ7N5i/8Sf9NTvhgIBK/BavDMkaOhh0WhXfKhM7U1V79swWIg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id f6418b93 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Wed, 7 Dec 2016 18:30:26 +0000 (UTC)
Received: by mail-wm0-f49.google.com with SMTP id g23so181810653wme.1
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2016 10:35:52 -0800 (PST)
X-Gm-Message-State: AKaTC00WUw0MkHochXwKixgvlAVZS0yZJNjnGDY2nkGT7oNr3Dc9B1x+DAUT4v42/8/OuEIuV+/s111E3guMMA==
X-Received: by 10.46.75.1 with SMTP id y1mr29004729lja.45.1481135751710; Wed,
 07 Dec 2016 10:35:51 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.17.101 with HTTP; Wed, 7 Dec 2016 10:35:51 -0800 (PST)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Wed, 7 Dec 2016 19:35:51 +0100
X-Gmail-Original-Message-ID: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
Message-ID: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
Subject: Misalignment, MIPS, and ip_hdr(skb)->version
To:     Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org
Cc:     LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55958
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

Hey MIPS Networking People,

I receive encrypted packets with a 13 byte header. I decrypt the
ciphertext in place, and then discard the header. I then pass the
plaintext to the rest of the networking stack. The plaintext is an IP
packet. Due to the 13 byte header that was discarded, the plaintext
possibly begins at an unaligned location (depending on whether
dev->needed_headroom was respected).

Does this matter? Is this bad? Will there be a necessary performance hit?

In order to find out, I instrumented the MIPS unaligned access
exception handler to see where I was actually in trouble.
Surprisingly, the only part of the stack that seemed to be upset was
on calls to ip_hdr(skb)->version.

Two things disturb me about this. First, this seems too good to be
true. Does it seem reasonable to you that this is actually the only
place that would be problematic? Or was my testing methodology wrong
to arrive at such an optimistic conclusion?

Secondly, why should a call to ip_hdr(skb)->version cause an unaligned
access anyway? This struct member is simply the second half of a
single byte in a bit field. I'd expect for the compiler to generate a
single byte load, followed by a bitshift or a mask. Instead, the
compiler appears to generate a double byte load, hence the exception.
What's up with this? Stupid compiler that should be fixed? Some odd
optimization? What to do?

I'm considering just adding an extra byte of padding (see discussion
in [1]), but before I make any decision like that (and hopefully it
won't be necessary), I'd like to completely and entirely understand
the full effects and consequences of calling netif_rx(skb) when
skb->data is unaligned. Any insight you have to offer would be most
welcome.

Thanks,
Jason

[1] https://lists.zx2c4.com/pipermail/wireguard/2016-December/000709.html
