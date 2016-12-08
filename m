Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 Dec 2016 00:15:10 +0100 (CET)
Received: from shards.monkeyblade.net ([184.105.139.130]:46838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993401AbcLHXPCgHtoy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 9 Dec 2016 00:15:02 +0100
Received: from localhost (cpe-66-108-81-97.nyc.res.rr.com [66.108.81.97])
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7A63013C12D40;
        Thu,  8 Dec 2016 14:15:35 -0800 (PST)
Date:   Thu, 08 Dec 2016 18:14:53 -0500 (EST)
Message-Id: <20161208.181453.1681964885150767592.davem@davemloft.net>
To:     Jason@zx2c4.com
Cc:     dave.taht@gmail.com, netdev@vger.kernel.org,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        wireguard@lists.zx2c4.com
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
References: <CAHmME9qxz6wcOZuurqahXeY6QSF=zz0gH7gY4RZujLAJPNSWBA@mail.gmail.com>
        <20161207.193716.50344961208535056.davem@davemloft.net>
        <CAHmME9qGoPGEFyqe0jBaZD5R51wHTEgAYb9edj+nu9nNPWSYCA@mail.gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.1 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 08 Dec 2016 14:15:36 -0800 (PST)
Return-Path: <davem@davemloft.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55976
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
Date: Thu, 8 Dec 2016 23:20:04 +0100

> Hi David,
> 
> On Thu, Dec 8, 2016 at 1:37 AM, David Miller <davem@davemloft.net> wrote:
>> You really have to land the IP header on a proper 4 byte boundary.
>>
>> I would suggest pushing 3 dummy garbage bytes of padding at the front
>> or the end of your header.
> 
> Are you sure 3 bytes to get 4 byte alignment is really the best? I was
> thinking that adding 1 byte to get 2 byte alignment might be better,
> since it would then ensure that the subsequent TCP header winds up
> being 4 byte aligned. Or is this in fact not the desired trade off,
> and so I should stick with the 3 bytes you suggested?

If the IP header is 4 byte aligned, the TCP header will be as well.
