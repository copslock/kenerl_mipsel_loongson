Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 23:20:25 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:34163 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993264AbcLHWUS3CRja (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2016 23:20:18 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 6e1aeba1
        for <linux-mips@linux-mips.org>;
        Thu, 8 Dec 2016 22:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=+xM8KLlVpCz/Zd9sAiEnjE9l5NY=; b=FNySKc
        Bf478T2aMIZT05CZz3efWIbqIkMFl6dsRPT84jtHunROdR6P476FT7Vr7qoLk/w7
        yTLgibLyqE1bKmdndb6kfIakW23wHe72KM4NHpL7+AAS9/RJ2L+f43nlN8wMfvbZ
        CEF9Dwm+RhZTLeTgmlnGsV8S+C7Z4IeMB9mSLfb7RLiSX8sbpx2yQLFqmFNGxYsp
        s1X2cL9RBmtvTXGndoNNe4lvQzRgATJcBOZ3Rg0tEP8eKsN3SLjyLLtbKIck5wbx
        pSWyuCXxxdRXpH+yWMk2rxmU4z9ny1qpGWbDavP+y3XGJS4jImFebKKJWgYTOGuP
        D71g7ISP6hW5d9tQ==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a05d4516 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 8 Dec 2016 22:14:31 +0000 (UTC)
Received: by mail-wm0-f52.google.com with SMTP id g23so23712wme.1
        for <linux-mips@linux-mips.org>; Thu, 08 Dec 2016 14:20:06 -0800 (PST)
X-Gm-Message-State: AKaTC03XszhqJzV0ZnwkFoRTazfyXVjdAtZ7yM71CCcR8TYupBOadYXL1LqmFvZRzzaKa3twcSwdns7H4w5lTw==
X-Received: by 10.25.195.195 with SMTP id t186mr21315645lff.96.1481235604947;
 Thu, 08 Dec 2016 14:20:04 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.31.140 with HTTP; Thu, 8 Dec 2016 14:20:04 -0800 (PST)
In-Reply-To: <20161207.193716.50344961208535056.davem@davemloft.net>
References: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
 <20161207.145240.1636297838792223189.davem@davemloft.net> <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
 <20161207.193716.50344961208535056.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 8 Dec 2016 23:20:04 +0100
X-Gmail-Original-Message-ID: <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
Message-ID: <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     David Miller <davem@davemloft.net>
Cc:     Dave Taht <dave.taht@gmail.com>, Netdev <netdev@vger.kernel.org>,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Content-Type: text/plain; charset=UTF-8
Return-Path: <Jason@zx2c4.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55975
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

Hi David,

On Thu, Dec 8, 2016 at 1:37 AM, David Miller <davem@davemloft.net> wrote:
> You really have to land the IP header on a proper 4 byte boundary.
>
> I would suggest pushing 3 dummy garbage bytes of padding at the front
> or the end of your header.

Are you sure 3 bytes to get 4 byte alignment is really the best? I was
thinking that adding 1 byte to get 2 byte alignment might be better,
since it would then ensure that the subsequent TCP header winds up
being 4 byte aligned. Or is this in fact not the desired trade off,
and so I should stick with the 3 bytes you suggested?

Jason
