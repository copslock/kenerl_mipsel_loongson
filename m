Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 01:29:59 +0100 (CET)
Received: from frisell.zx2c4.com ([192.95.5.64]:45042 "EHLO frisell.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991960AbcLHA3xRnbHc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Dec 2016 01:29:53 +0100
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTP id bfd9b783
        for <linux-mips@linux-mips.org>;
        Thu, 8 Dec 2016 00:24:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :in-reply-to:references:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=9rsihvjJ3FTIjBqOBH+8oQbF20I=; b=L2+QQQ
        AVzzq4zi4GiYSg9qINI2e/W5Qm8e58GvtgwSFOc/NBLL62ExKa/U9PrJrpi9Dkvw
        FpR94szpE4avQHBdwMRK8Z3R/thck9EG33u6qzeII6dMjgPgSxd7jxnI2r3CIBMl
        Lw2LteuLUuK5/VWWQ5+UEYIryLYl74yDFqHxxN0DG6ayis26FnBNQK7sK6U3oO9Z
        OLXmgvXMMQdoe8QarqYHoPdjYDB4nQSKy3rFhAm2E2F9tDxpIVE3ePjrC1dTZ3aO
        ByAz8TCsKVKY74/x4shHTawj00JOPP1SuDx/mUYJ3EWv8TL61EVna7Tdbv5tRG7r
        LBKMHK3GFdxCOLew==
Received: by frisell.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 20aadde0 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128:NO)
        for <linux-mips@linux-mips.org>;
        Thu, 8 Dec 2016 00:24:15 +0000 (UTC)
Received: by mail-wm0-f47.google.com with SMTP id t79so779728wmt.0
        for <linux-mips@linux-mips.org>; Wed, 07 Dec 2016 16:29:44 -0800 (PST)
X-Gm-Message-State: AKaTC01P90qrkn04y/mbBwgGi+ljX0iK1uZuLcu0Awo6gCjjegmUSrwmbCEqNe2QiML7CeivHEnWSpMDWOFO5w==
X-Received: by 10.46.0.87 with SMTP id 84mr30168300lja.1.1481156983222; Wed,
 07 Dec 2016 16:29:43 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.31.140 with HTTP; Wed, 7 Dec 2016 16:29:42 -0800 (PST)
In-Reply-To: <20161207.145240.1636297838792223189.davem@davemloft.net>
References: <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
 <20161207.135127.789629809982860453.davem@davemloft.net> <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
 <20161207.145240.1636297838792223189.davem@davemloft.net>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 8 Dec 2016 01:29:42 +0100
X-Gmail-Original-Message-ID: <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
Message-ID: <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
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
X-archive-position: 55968
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

On Wed, Dec 7, 2016 at 8:52 PM, David Miller <davem@davemloft.net> wrote:
> The only truly difficult case to handle is GRE encapsulation.  Is
> that the situation you are running into?
>
> If not, please figure out what the header configuration looks like
> in the case that hits for you, and what the originating device is
> just in case it is a device driver issue.

My case is my own driver and my own protocol, which uses a 13 byte
header. I can, if absolutely necessary, change the protocol to add
another byte of padding. Or I can choose not to decrypt in place but
rather use a different trick, like overwriting the header during
decryption, though this removes some of the scatterwalk optimizations
when src and dst are the same. Or something else. I wrote the top
email of this thread inquiring about just exactly how bad it is to
call netif_rx(skb) when skb->data is unaligned.
