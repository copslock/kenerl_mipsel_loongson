Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 17:59:14 +0200 (CEST)
Received: from arrakis.dune.hu ([78.24.191.176]:54020 "EHLO arrakis.dune.hu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27011859AbbHNP7MKAa7r (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 14 Aug 2015 17:59:12 +0200
Received: from localhost (localhost [127.0.0.1])
        by arrakis.dune.hu (Postfix) with ESMTP id 0FA1128089D;
        Fri, 14 Aug 2015 17:58:24 +0200 (CEST)
X-Virus-Scanned: at arrakis.dune.hu
Received: from mail-lb0-f173.google.com (mail-lb0-f173.google.com [209.85.217.173])
        by arrakis.dune.hu (Postfix) with ESMTPSA id 8C53628BC31;
        Fri, 14 Aug 2015 17:58:18 +0200 (CEST)
Received: by lbcbn3 with SMTP id bn3so47817788lbc.2;
        Fri, 14 Aug 2015 08:59:00 -0700 (PDT)
X-Received: by 10.112.50.177 with SMTP id d17mr44275234lbo.18.1439567940771;
 Fri, 14 Aug 2015 08:59:00 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.25.143.76 with HTTP; Fri, 14 Aug 2015 08:58:41 -0700 (PDT)
In-Reply-To: <55CE0179.3010205@broadcom.com>
References: <55CB03D2.6080404@broadcom.com> <55CE0179.3010205@broadcom.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Fri, 14 Aug 2015 17:58:41 +0200
Message-ID: <CAOiHx=nX_nNYNZ-1s2uPFM-zEmoZSySvMYzUA2q=RjYZOiRJ8A@mail.gmail.com>
Subject: Re: [4.2-rc4] recurring build issue
To:     Arend van Spriel <arend@broadcom.com>
Cc:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48895
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

On Fri, Aug 14, 2015 at 4:55 PM, Arend van Spriel <arend@broadcom.com> wrote:
> + LKML

Huh, didn't know Florian is LKML ;-)

> On 08/12/2015 10:29 AM, Arend van Spriel wrote:
>>
>> A while ago we faced a build issue for MIPS architecture (see attached
>> config) and someone (forgot who) provided reference to following patch
>> which fixed the issue so I applied it in our repo.
>>
>> commit cd532e6356425fef41f25c31411867cf80d7541b
>> Author: Maciej W. Rozycki <macro@linux-mips.org>
>> Date:   Sun May 3 10:36:19 2015 +0100
>>
>>      MIPS: pgtable-bits.h: Correct _PAGE_GLOBAL_SHIFT build failure
>>
>>      Correct a build failure introduced by be0c37c9 [MIPS: Rearrange PTE
>> bits
>>      into fixed positions.]:
>>
>> With a merge of 4.2-rc4 those changes were lost and the build issue was
>> back. Is there any chance the patch will be posted upstream in some
>> form. For now I reapplied the patch, but would like to get rid of that
>> type of maintenance.
>
>
> Ping? Any reaction from mips community? My knowledge about MIPS architecture
> is next to nil so try to avoid fiddling with it myself.

@Ralf, any reason for not having applied
http://patchwork.linux-mips.org/patch/9960/ ? Or just slipped to the
cracks?


Jonas
