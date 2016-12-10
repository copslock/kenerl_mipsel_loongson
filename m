Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 10 Dec 2016 21:10:11 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:37277 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991977AbcLJUKFZvn3A (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 10 Dec 2016 21:10:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name; s=20160729;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=lGntdfTDFBmNAB1Href4mbeDrSNj4/Ch/DO2oXgGTWU=;
        b=Jq+bpdk7idHO8CrRW1RneaUXXeTJwNLpMH2Xf3YefZezEdxAfYXj3AJZmNjuXliU4RgfKOUxgBDYSR06JA9eJGevzWndeLwQmc3YGVyd6YXmwyjkQXQTlZ4hCzNai+R+ckRYxO/VLtk6YcROBifzPUK6WgZCJ+jV8dNB2qFL0qo=;
Subject: Re: Misalignment, MIPS, and ip_hdr(skb)->version
To:     =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
 <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
 <20161207.135127.789629809982860453.davem@davemloft.net>
 <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
 <040bcdb2-2725-c8de-11d9-a4f77b75d9d8@nbd.name>
 <yw1x37hvykzk.fsf@unicorn.mansr.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        WireGuard mailing list <wireguard@lists.zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
From:   Felix Fietkau <nbd@nbd.name>
Message-ID: <7f8ba817-73ef-e1e1-4fdf-b9178e922008@nbd.name>
Date:   Sat, 10 Dec 2016 21:09:57 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:45.0)
 Gecko/20100101 Thunderbird/45.5.1
MIME-Version: 1.0
In-Reply-To: <yw1x37hvykzk.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-Path: <nbd@nbd.name>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55994
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

On 2016-12-10 14:25, Måns Rullgård wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> On 2016-12-07 19:54, Jason A. Donenfeld wrote:
>>> On Wed, Dec 7, 2016 at 7:51 PM, David Miller <davem@davemloft.net> wrote:
>>>> It's so much better to analyze properly where the misalignment comes from
>>>> and address it at the source, as we have for various cases that trip up
>>>> Sparc too.
>>> 
>>> That's sort of my attitude too, hence starting this thread. Any
>>> pointers you have about this would be most welcome, so as not to
>>> perpetuate what already seems like an issue in other parts of the
>>> stack.
>> Hi Jason,
>>
>> I'm the author of that hackish LEDE/OpenWrt patch that works around the
>> misalignment issues. Here's some context regarding that patch:
>>
>> I intentionally put it in the target specific patches for only one of
>> our MIPS targets. There are a few ar71xx devices where the misalignment
>> cannot be fixed, because the Ethernet MAC has a 4-byte DMA alignment
>> requirement, and does not support inserting 2 bytes of padding to
>> correct the IP header misalignment.
>>
>> With these limitations the choice was between this ugly network stack
>> patch or inserting a very expensive memmove in the data path (which is
>> better than taking the mis-alignment traps, but still hurts routing
>> performance significantly).
> 
> I solved this problem in an Ethernet driver by copying the initial part
> of the packet to an aligned skb and appending the remainder using
> skb_add_rx_frag().  The kernel network stack only cares about the
> headers, so the alignment of the packet payload doesn't matter.
I considered that as well, but it's bad for routing performance if the
ethernet MAC does not support scatter/gather for xmit.
Unfortunately that limitation is quite common on embedded hardware.

- Felix
