Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Jan 2003 01:39:08 +0000 (GMT)
Received: from h0000c06cf87e.ne.client2.attbi.com ([IPv6:::ffff:24.147.212.21]:59911
	"EHLO compaq.parker.boston.ma.us") by linux-mips.org with ESMTP
	id <S8225234AbTA2BjH>; Wed, 29 Jan 2003 01:39:07 +0000
Received: from p2.parker.boston.ma.us (p2 [192.245.5.16])
	by compaq.parker.boston.ma.us (8.11.6/8.11.6) with ESMTP id h0T1d3M06983;
	Tue, 28 Jan 2003 20:39:04 -0500
Received: from p2 (brad@localhost)
	by p2.parker.boston.ma.us (8.11.2/8.11.2) with ESMTP id h0T1d3R01891;
	Tue, 28 Jan 2003 20:39:03 -0500
Message-Id: <200301290139.h0T1d3R01891@p2.parker.boston.ma.us>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Ralf Baechle <ralf@linux-mips.org>, Mike Uhler <uhler@mips.com>,
	Linux/MIPS Development <linux-mips@linux-mips.org>
Subject: Re: unaligned load in branch delay slot 
In-Reply-To: Message from Geert Uytterhoeven <geert@linux-m68k.org> 
   of "Tue, 28 Jan 2003 13:27:42 +0100." <Pine.GSO.4.21.0301281315380.9269-100000@vervain.sonytel.be> 
Date: Tue, 28 Jan 2003 20:39:03 -0500
From: Brad Parker <brad@parker.boston.ma.us>
Return-Path: <brad@parker.boston.ma.us>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: brad@parker.boston.ma.us
Precedence: bulk
X-list: linux-mips


Geert Uytterhoeven wrote:
>On Tue, 28 Jan 2003, Ralf Baechle wrote:
>> On Tue, Jan 28, 2003 at 10:30:20AM +0100, Geert Uytterhoeven wrote:
>> > If it happens, I should get a SIGILL, right?
>> 
>> Right.
>> 
>> Hmm...  If you can't reproduce this anymore I guess we should pull this
>> patch again?  Despite Mike basically acknowledging that such behaviour
>
>I cannot reproduce it in user space. I can still reproduce it in kernel space
>when an incoming TCP connection is accepted:
>
>| 8034d568 <tcp_v4_conn_request>:

I had a problem in tcp_rcv_established() where this "if" would trigger
even though "th->syn" was zero:

...
	if (th->syn && !before(TCP_SKB_CB(skb)->seq, tp->rcv_nxt)) {
...

It turned out the tcp header was 'misaligned' after coming across a
usb link.  I never figured out why it was failing, but it was clearly
the emulation code which was doing the wrong thing.  This was on an
alchemy au1000 (MIPS32).

also in the kernel...

-brad
