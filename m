Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 21:26:29 +0100 (CET)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:50521 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823127AbaAUU00b1uio (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 21 Jan 2014 21:26:26 +0100
Received: by mail-pa0-f46.google.com with SMTP id rd3so8866928pab.19
        for <linux-mips@linux-mips.org>; Tue, 21 Jan 2014 12:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=zF2ImEAmyDYhAN9uZvtsewyRUCVwC0rzPODUZIR6RTw=;
        b=ioPS0Seg9dHibe7KDcmiR8XmWWklqjWgRe16O/q+ZtTRRz+305iV1UsFLi8FGKvzv9
         9SnNwtPvCE6TvxV53Iz0GXdw+p95uT0t6ogTWrUzmSQ3r92FkeysOJQrK3UBc/9xOsn1
         CpH8K5JKTNcg0J1ASulJR3z5v7qjRxm98i8iJ+Q5IO1wKLDHmgbJNowNNolJgNLG/gpe
         9HGRSlMQaKVj9GZkCiePk92IvbBZHHkDaoxtmFdJ9uMi7uO6Etv5nfGXFUG/Wz2tnkDp
         o2p4YN76Uy1MlbzuTULDRmLcUV3dRjSlM2n1oyMQ0dE1ifOTrKAtbdLqatQgzUv0dgPG
         cJYg==
X-Received: by 10.66.14.41 with SMTP id m9mr27146329pac.123.1390335979805;
 Tue, 21 Jan 2014 12:26:19 -0800 (PST)
MIME-Version: 1.0
Received: by 10.68.186.101 with HTTP; Tue, 21 Jan 2014 12:25:39 -0800 (PST)
In-Reply-To: <52DED597.1040607@imgtec.com>
References: <1390321122-25634-1-git-send-email-Steven.Hill@imgtec.com>
 <52DEBBA6.9070701@gmail.com> <52DED597.1040607@imgtec.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Tue, 21 Jan 2014 12:25:39 -0800
Message-ID: <CAGVrzcZ2SucNRyBBqyhbM7RQkGNERPZY=YsfSp0R8GiS0BLpbA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: lib: Optimize partial checksum ops using prefetching.
To:     "Steven J. Hill" <Steven.Hill@imgtec.com>
Cc:     David Daney <ddaney.cavm@gmail.com>,
        LMOL <linux-mips@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39047
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014/1/21 Steven J. Hill <Steven.Hill@imgtec.com>:
> On 01/21/2014 12:25 PM, David Daney wrote:
>>
>> On 01/21/2014 08:18 AM, Steven J. Hill wrote:
>>>
>>> From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>>
>>> Use the PREF instruction to optimize partial checksum operations.
>>>
>>> Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
>>> Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
>>
>>
>> NACK.  The proper latench and cacheline stride vary by CPU, you cannot
>> just hard code them for 32-byte cacheline size with some random latency.
>>
>> This will make some CPUs slower.
>>
> Note that memcpy.S already uses fixed cache lines (32 bytes) so this is
> merely doing the same thing. I assume you have some empirical evidence
> concerning other CPUs being slower?

How about using cpu_dcache_line_size()/MIPS_L1_CACHE_SHIFT? These
should provide a good hint. Octeon has a 128bytes D$ line size, so
prefetching via slices of 32 bytes is most likely suboptimal.
-- 
Florian
