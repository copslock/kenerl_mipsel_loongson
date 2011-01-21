Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Jan 2011 09:53:03 +0100 (CET)
Received: from rtits2.realtek.com ([60.250.210.242]:43447 "EHLO
        rtits2.realtek.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491765Ab1AUIxA convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 21 Jan 2011 09:53:00 +0100
Received: from mail.realtek.com.tw (rtitmbs7.realtek.com.tw [172.21.1.183])
        by rtits2.realtek.com (8.14.4/8.14.4) with ESMTP id p0L8qtKu022041;
        Fri, 21 Jan 2011 16:52:56 +0800
Received: from rtitmbs7.realtek.com.tw ([172.21.1.183]) by
 rtitmbs7.realtek.com.tw ([172.21.1.183]) with mapi; Fri, 21 Jan 2011 16:52:55
 +0800
From:   COLin <colin@realtek.com>
To:     "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>
Date:   Fri, 21 Jan 2011 16:52:54 +0800
Subject: 24k data cache, PIPT or VIPT?
Thread-Topic: 24k data cache, PIPT or VIPT?
Thread-Index: AQHLuUbVXlaQIiHjVkiVJGPYIadBqA==
X-BOX-Message-Id: p0L8qtKu022041
Message-ID: <AB43F607AA1BE0439402E9061AC9519D011EF513EB8D@rtitmbs7.realtek.com.tw>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: zh-TW, en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <colin@realtek.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29005
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: colin@realtek.com
Precedence: bulk
X-list: linux-mips


Hi all,
I found that there is this information while Linux is booting:
    [Primary data cache 32kB, 4-way, PIPT, no aliases, linesize 32 bytes]
I thought the latest MIPS CPUs all use VIPT. I didn't find anything about PIPT on 24k Software User's Manual, either.
The code related to this is here:
        case CPU_24K:
        case CPU_34K:
        case CPU_74K:
        case CPU_1004K:
                if ((read_c0_config7() & (1 << 16))) {
                        /* effectively physically indexed dcache,
                           thus no virtual aliases. */ 
                        c->dcache.flags |= MIPS_CACHE_PINDEX;
                        break;

The 16's bit of config 7 register:
    [Alias removed: This bit indicates that the data cache is organized to
avoid virtual aliasing problems. This bit is only set if the data cache
config and MMU type would normally cause aliasing - i.e., only for
the 32KB and larger data cache and TLB-based MMU.]

Does it imply that the CPU is using PIPT?

Thanks and regards,
Colin
