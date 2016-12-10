Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2016 13:25:17 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:51834 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990720AbcLJMZKznoMH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Dec 2016 13:25:10 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name; s=20160729;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=G2OJH9PeDqD7dGviJ28UD6iIxmya/C5SEdOuAGN6mNw=;
        b=fU6OSXSrxAvf0eOh5yGm6uvy/gFgesEgNQH9Ldj5yvEdm5zkZfYiR2H570nhogmCc3NFAFq+W++zonMLG6JC7DTcxBNag8mv6S8Hwf3C44k92HQGSomDBFWBVdNQT0QAsnf9MkWuPj6Y/mwfbZSzwsKSpy0zjAiw79wdDvkzDVs=;
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Miller <davem@davemloft.net>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
 <20161207.135127.789629809982860453.davem@davemloft.net>
 <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
Cc:     Dave Taht <dave.taht@gmail.com>, Netdev <netdev@vger.kernel.org>,
        linux-mips@linux-mips.org, LKML <linux-kernel@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <040bcdb2-2725-c8de-11d9-a4f77b75d9d8@nbd.name>
Date:   Sat, 10 Dec 2016 13:25:07 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: nbd@nbd.name
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

On 2016-12-07 19:54, Jason A. Donenfeld wrote:
> On Wed, Dec 7, 2016 at 7:51 PM, David Miller <davem@davemloft.net> wrote:
>> It's so much better to analyze properly where the misalignment comes from
>> and address it at the source, as we have for various cases that trip up
>> Sparc too.
> 
> That's sort of my attitude too, hence starting this thread. Any
> pointers you have about this would be most welcome, so as not to
> perpetuate what already seems like an issue in other parts of the
> stack.
Hi Jason,

I'm the author of that hackish LEDE/OpenWrt patch that works around the
misalignment issues. Here's some context regarding that patch:

I intentionally put it in the target specific patches for only one of
our MIPS targets. There are a few ar71xx devices where the misalignment
cannot be fixed, because the Ethernet MAC has a 4-byte DMA alignment
requirement, and does not support inserting 2 bytes of padding to
correct the IP header misalignment.

With these limitations the choice was between this ugly network stack
patch or inserting a very expensive memmove in the data path (which is
better than taking the mis-alignment traps, but still hurts routing
performance significantly).

There are a lot of places in the network stack that assume full 32 bit
alignment, and you only get to see those once you start using more of
netfilter, play with various tunnel encapsulations, etc.

I think you have 3 options to deal with this properly:
1. add 3 bytes of padding
2. allocate a separate skb for decryption (might be more expensive)
3. save the header and decrypt to the start of the packet data
(overwriting the misaligned header).

I'm not sure what the performance impact of 2 and 3 is, so it's probably
best to stick with the padding.

I've taken a quick look at the wireguard message headers, and my
recommendation would be to insert the 3-byte padding in struct
message_header and remove __packed from your structs.
This will also remove misaligment of your own protocol fields.

- Felix
