Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Dec 2016 01:37:29 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:45174 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991960AbcLHAhWZ9qmc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 8 Dec 2016 01:37:22 +0100
Received: from localhost (cpe-66-108-81-97.nyc.res.rr.com [66.108.81.97])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 47610136475C3;
        Wed,  7 Dec 2016 15:37:56 -0800 (PST)
Date:   Wed, 07 Dec 2016 19:37:16 -0500 (EST)
Message-Id: <20161207.193716.50344961208535056.davem@davemloft.net>
To:     Jason@zx2c4.com
Cc:     dave.taht@gmail.com, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wireguard@lists.zx2c4.com
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
References: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
        <20161207.145240.1636297838792223189.davem@davemloft.net>
        <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 07 Dec 2016 15:37:56 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55970
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: davem@davemloft.net
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

From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 8 Dec 2016 01:29:42 +0100

> On Wed, Dec 7, 2016 at 8:52 PM, David Miller <davem@davemloft.net> wrote:
>> The only truly difficult case to handle is GRE encapsulation.  Is
>> that the situation you are running into?
>>
>> If not, please figure out what the header configuration looks like
>> in the case that hits for you, and what the originating device is
>> just in case it is a device driver issue.
> 
> My case is my own driver and my own protocol, which uses a 13 byte
> header. I can, if absolutely necessary, change the protocol to add
> another byte of padding. Or I can choose not to decrypt in place but
> rather use a different trick, like overwriting the header during
> decryption, though this removes some of the scatterwalk optimizations
> when src and dst are the same. Or something else. I wrote the top
> email of this thread inquiring about just exactly how bad it is to
> call netif_rx(skb) when skb->data is unaligned.

You really have to land the IP header on a proper 4 byte boundary.

I would suggest pushing 3 dummy garbage bytes of padding at the front
or the end of your header.
