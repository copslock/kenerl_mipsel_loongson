Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 15:50:55 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:50799 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990601AbcLKOunldXp4 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 15:50:43 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id fa6bac46
        for <linux-mips@linux-mips.org>;
        Sun, 11 Dec 2016 14:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=euGlYEU0Lw85UV1xNz6XmFoiXF4=; b=rYlba4
        OItYN2XJfH5IR3/UceT9+QYXg+FUKIZLC4J1nPhLIqEmfQH4eQpzfeDYZbRsl9o4
        lHFQziw3+qTQHDFkFHsdjFysTapv1+tY5CLtxCDRDk90IrItIT1ScgEJjHjCp4cK
        7F8GU9dPhBcl2wotRIVOtHoivd/EaSLON/6W1OAm34i/0p8RWh6W0v/XIrO82OM3
        FTZH0KVvxNdp6D6w6UTIaNhsabAZIbKQNAobpelytUq6j0B0/R5tlecHHXCDmgB7
        okV1gtBCXgNc55IJqYj2wK5Ahb7qkO0ms6tWORWtc7rcR7T9F+mnKl/BwGelt/SR
        PhBpg/Fm55ciFtMg==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id c9c12607 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Sun, 11 Dec 2016 14:44:39 +0000 (UTC)
Received: by mail-wm0-f41.google.com with SMTP id c184so6689436wmd.0
        for <linux-mips@linux-mips.org>; Sun, 11 Dec 2016 06:50:34 -0800 (PST)
X-Gm-Message-State: AKaTC01NSX2iC33LsTnGYUVsThC0p0Jz9dwzOnmPHGOQ1GTkVHFvyvVJE0rgTcwSfhEJkGB2iVgck+rwuPfvEw==
X-Received: by 10.25.44.66 with SMTP id s63mr30285270lfs.159.1481467832704;
 Sun, 11 Dec 2016 06:50:32 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.31.140 with HTTP; Sun, 11 Dec 2016 06:50:31 -0800 (PST)
In-Reply-To: <20161211071501.GA32621@kroah.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <095cac5b-b757-6f4a-e699-8eedf9ed7221@stressinduktion.org>
 <87vauvhwdu.fsf@alice.fifthhorseman.net> <CE942916-BF45-44CC-A5F5-3838CF9C93BC@danrl.com>
 <20161211071501.GA32621@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Sun, 11 Dec 2016 15:50:31 +0100
X-Gmail-Original-Message-ID: <CAHmME9q5ifwwishXjXYE3J=sVeR4jYY9fLUgs_FHCP594EZr6g@mail.gmail.com>
Message-ID: <CAHmME9q5ifwwishXjXYE3J=sVeR4jYY9fLUgs_FHCP594EZr6g@mail.gmail.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     linux-mips@linux-mips.org, Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     =?UTF-8?Q?Dan_L=C3=BCdtke?= <mail@danrl.com>,
        Willy Tarreau <w@1wt.eu>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Hannes Frederic Sowa <hannes@stressinduktion.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        Felix Fietkau <nbd@nbd.name>, Jiri Benc <jbenc@redhat.com>,
        David Miller <davem@davemloft.net>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56001
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

Hey guys,

Thanks for the extremely detailed answers. The main take-away from
this is that passing unaligned packets to the networking stack kills
kittens. So now it's a question of mitigation. I have three options:

1. Copy the plaintext to three bytes before the start of the cipher
text, overwriting parts of the header that aren't actually required.
Pros: no changes required, MTU stays small.
Cons: scatterwalk's fast paths aren't hit, which means two page table
mappings are taken instead of one. I have no idea if this actually
matters or will slow down anything relavent.

2. Add 3 bytes to the plaintext header, set to zero, marked for future use.
Pros: satisfies IETF mantras and makes unaligned in-place decryption
straightforward.
Cons: lowers MTU, additional unauthenticated cleartext bits in the
header are of limited utility in protocol.

3. Add 3 bytes of padding, set to zero, to the encrypted section just
before the IP header, marked for future use.
Pros: satisfies IETF mantras, can use those extra bits in the future
for interesting protocol extensions for authenticated peers.
Cons: lowers MTU, marginally more difficult to implement but still
probably just one or two lines of code.

Of these, I'm leaning toward (3).

Anyway, thanks a lot for the input. "Doing nothing" is no longer under
serious consideration, thanks to your messages.

Thanks,
Jason
