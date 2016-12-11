Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 09:07:30 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:26328 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993016AbcLKIHXSJFDw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 11 Dec 2016 09:07:23 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id uBB87ILl007276;
        Sun, 11 Dec 2016 09:07:18 +0100
Date:   Sun, 11 Dec 2016 09:07:18 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     David Miller <davem@davemloft.net>,
        Dave Taht <dave.taht@gmail.com>,
        Netdev <netdev@vger.kernel.org>, linux-mips@linux-mips.org,
        LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
Message-ID: <20161211080718.GA7253@1wt.eu>
References: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
 <20161207.145240.1636297838792223189.davem@davemloft.net>
 <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
 <20161207.193716.50344961208535056.davem@davemloft.net>
 <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
User-Agent: Mutt/1.6.1 (2016-04-27)
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55999
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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

Hi Jason,

On Thu, Dec 08, 2016 at 11:20:04PM +0100, Jason A. Donenfeld wrote:
> Hi David,
> 
> On Thu, Dec 8, 2016 at 1:37 AM, David Miller <davem@davemloft.net> wrote:
> > You really have to land the IP header on a proper 4 byte boundary.
> >
> > I would suggest pushing 3 dummy garbage bytes of padding at the front
> > or the end of your header.
> 
> Are you sure 3 bytes to get 4 byte alignment is really the best?

It's always the best. However there's another option which should be
considered : maybe it's difficult but not impossible to move some bits
from the current protocol to remove one byte. That's not always easy,
and sometimes you cannot do it just for one bit. However after you run
through this exercise, if you notice there's really no way to shave
this extra byte, you'll realize there's no room left for future
extensions and you'll more easily accept to add 3 empty bytes for
this, typically protocol version, tags, qos or flagss that you'll be
happy to rely on for future versions of your protocol.

Also while it can feel like you're making your protocol less efficient,
keep in mind that these 3 bytes only matter for small packets, and
Ethernet already pads small frames to 64 bytes, so in practice any
IP packet smaller than 46 bytes will not bring any extra savings.

Best regards,
Willy
