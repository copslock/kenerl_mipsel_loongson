Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Dec 2016 17:19:31 +0100 (CET)
Received: from smtp-out6.electric.net ([192.162.217.190]:62185 "EHLO
        smtp-out6.electric.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990601AbcLLQTXkELdu convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Dec 2016 17:19:23 +0100
Received: from 1cGTJw-0001SB-Tc by out6d.electric.net with emc1-ok (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1cGTJx-0001Vq-U7; Mon, 12 Dec 2016 08:19:21 -0800
Received: by emcmailer; Mon, 12 Dec 2016 08:19:21 -0800
Received: from [213.249.233.130] (helo=AcuExch.aculab.com)
        by out6d.electric.net with esmtps (TLSv1:AES128-SHA:128)
        (Exim 4.87)
        (envelope-from <David.Laight@ACULAB.COM>)
        id 1cGTJw-0001SB-Tc; Mon, 12 Dec 2016 08:19:20 -0800
Received: from ACUEXCH.Aculab.com ([::1]) by AcuExch.aculab.com ([::1]) with
 mapi id 14.03.0123.003; Mon, 12 Dec 2016 16:19:18 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     =?Windows-1252?B?J03lbnMgUnVsbGflcmQn?= <mans@mansr.com>,
        Felix Fietkau <nbd@nbd.name>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        David Miller <davem@davemloft.net>,
        Netdev <netdev@vger.kernel.org>,
        "WireGuard mailing list" <wireguard@lists.zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Subject: RE: Misalignment, MIPS, and ip_hdr(skb)->version
Thread-Topic: Misalignment, MIPS, and ip_hdr(skb)->version
Thread-Index: AQHSUuCZSiY7WnBz2Eyc66nqgU4ToqEBLAZXgANTVMA=
Date:   Mon, 12 Dec 2016 16:19:17 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB023BF78@AcuExch.aculab.com>
References: <CAHmME9o_eCNXpVztOZKW55kpRtE+1KSEQTQOjUBVn68Y2+or2g@mail.gmail.com>
        <CAA93jw7hcmkcyD=t4VRrQFfHk+n+EkSVgY6KFDq0_-DGpMADYw@mail.gmail.com>
        <20161207.135127.789629809982860453.davem@davemloft.net>
        <CAHmME9oLgjDA2F0gkFzHU2Es8-XCxQHRABS18OKF0EnZgt1=LQ@mail.gmail.com>
        <040bcdb2-2725-c8de-11d9-a4f77b75d9d8@nbd.name>
 <yw1x37hvykzk.fsf@unicorn.mansr.com>
In-Reply-To: <yw1x37hvykzk.fsf@unicorn.mansr.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.202.99.200]
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Outbound-IP: 213.249.233.130
X-Env-From: David.Laight@ACULAB.COM
X-Proto: esmtps
X-Revdns: 
X-HELO: AcuExch.aculab.com
X-TLS:  TLSv1:AES128-SHA:128
X-Authenticated_ID: 
X-PolicySMART: 3396946, 3397078
X-Virus-Status: Scanned by VirusSMART (c)
X-Virus-Status: Scanned by VirusSMART (s)
Return-Path: <David.Laight@ACULAB.COM>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: David.Laight@ACULAB.COM
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

From: Måns Rullgård
> Sent: 10 December 2016 13:25
...
> I solved this problem in an Ethernet driver by copying the initial part
> of the packet to an aligned skb and appending the remainder using
> skb_add_rx_frag().  The kernel network stack only cares about the
> headers, so the alignment of the packet payload doesn't matter.

That rather depends on where the packet payload ends up.
It is likely that it will be copied to userspace (or maybe
into some aligned kernel buffer).
In which case you get an expensive misaligned copy.

Encapsulation protocols not using headers that are multiples
of 4 bytes is as stupid as ethernet hardware that can't place
the mac address on a 4n+2 boundary.
The latter is particularly stupid when it happens on embedded
silicon with a processor that can only do aligned memory accesses.
What do the hardware engineers think the ethernet interface will
be used for!

	David
