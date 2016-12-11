Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 11 Dec 2016 11:47:58 +0100 (CET)
Received: from unicorn.mansr.com ([81.2.72.234]:44214 "EHLO unicorn.mansr.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993038AbcLKKrukzURe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 11 Dec 2016 11:47:50 +0100
Received: by unicorn.mansr.com (Postfix, from userid 51770)
        id D0FF618802; Sun, 11 Dec 2016 10:47:43 +0000 (GMT)
From:   =?iso-8859-1?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>
To:     Willy Tarreau <w@1wt.eu>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>, linux-mips@linux-mips.org,
        Netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        David Miller <davem@davemloft.net>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
References: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
        <20161207.145240.1636297838792223189.davem@davemloft.net>
        <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
        <20161207.193716.50344961208535056.davem@davemloft.net>
        <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
        <20161211080718.GA7253@1wt.eu>
Date:   Sun, 11 Dec 2016 10:47:43 +0000
In-Reply-To: <20161211080718.GA7253@1wt.eu> (Willy Tarreau's message of "Sun,
        11 Dec 2016 09:07:18 +0100")
Message-ID: <yw1xtwaawxm8.fsf@unicorn.mansr.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Return-Path: <mans@mansr.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mans@mansr.com
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

Willy Tarreau <w@1wt.eu> writes:

> Hi Jason,
>
> On Thu, Dec 08, 2016 at 11:20:04PM +0100, Jason A. Donenfeld wrote:
>> Hi David,
>> 
>> On Thu, Dec 8, 2016 at 1:37 AM, David Miller <davem@davemloft.net> wrote:
>> > You really have to land the IP header on a proper 4 byte boundary.
>> >
>> > I would suggest pushing 3 dummy garbage bytes of padding at the front
>> > or the end of your header.
>> 
>> Are you sure 3 bytes to get 4 byte alignment is really the best?
>
> It's always the best. However there's another option which should be
> considered : maybe it's difficult but not impossible to move some bits
> from the current protocol to remove one byte. That's not always easy,
> and sometimes you cannot do it just for one bit. However after you run
> through this exercise, if you notice there's really no way to shave
> this extra byte, you'll realize there's no room left for future
> extensions and you'll more easily accept to add 3 empty bytes for
> this, typically protocol version, tags, qos or flagss that you'll be
> happy to rely on for future versions of your protocol.

Always include some way of extending the protocol in the future.  A
single bit is often enough.  Require a value of zero initially, then if
you ever want to change anything, setting it to one can indicate
whatever you want, including a complete redesign of the header.
Alternatively, a one-bit field can indicate the presence of an extended
header yet to be defined.  Then old software can still make sense of the
basic header.

-- 
Måns Rullgård
