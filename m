Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2010 12:00:24 +0200 (CEST)
Received: from t111.niisi.ras.ru ([193.232.173.111]:35532 "EHLO
        t111.niisi.ras.ru" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491056Ab0JSKAV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 19 Oct 2010 12:00:21 +0200
Received: from aa19.niisi.msk.ru (aa19.niisi.msk.ru [172.16.0.19] (may be forged))
        by t111.niisi.ras.ru (8.13.8/8.13.8) with ESMTP id o9JA0LA0012070;
        Tue, 19 Oct 2010 14:00:22 +0400
Received: from [192.168.173.2] (aa248 [172.16.0.248])
        by aa19.niisi.msk.ru (8.13.8/8.13.8) with ESMTP id o9J9oCT9025444;
        Tue, 19 Oct 2010 13:50:12 +0400
Message-ID: <4CBD6FDD.3020906@niisi.msk.ru>
Date:   Tue, 19 Oct 2010 14:15:57 +0400
From:   "Gleb O. Raiko" <raiko@niisi.msk.ru>
Organization: NIISI RAN
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Kevin Cernekee <cernekee@gmail.com>,
        Shinya Kuribayashi <skuribay@pobox.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        chris@mips.com
Subject: Re: [PATCH resend 5/9] MIPS: sync after cacheflush
References: <17ebecce124618ddf83ec6fe8e526f93@localhost> <17d8d27a2356640a4359f1a7dcbb3b42@localhost> <4CBC4F4E.5010305@pobox.com> <20101018191936.GH27377@linux-mips.org> <AANLkTimmatKpOFATCPDxthN-9pZzzXRAOnLGR1_348=r@mail.gmail.com> <4CBD5CC9.8070706@niisi.msk.ru> <20101019091729.GA31405@linux-mips.org>
In-Reply-To: <20101019091729.GA31405@linux-mips.org>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Content-Transfer-Encoding: 7bit
X-Antivirus: Dr.Web (R) for Mail Servers on t111.niisi.ras.ru host
X-Antivirus-Code: 100000
Return-Path: <raiko@niisi.msk.ru>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28154
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: raiko@niisi.msk.ru
Precedence: bulk
X-list: linux-mips



On 19.10.2010 13:17, Ralf Baechle wrote:
> On Tue, Oct 19, 2010 at 12:54:33PM +0400, Gleb O. Raiko wrote:
> The MIPS32 BIS v2.6 spec says on page 92:
>
>    "The CACHE instruction and the memory transactions which are sourced by
>     the CACHE instruction, such as cache refill or cache writeback, obey
>     the ordering and completion rules of the SYNC instruction."
>
> That's not as clearly spelt out as one would like but it seems to imply
> that only reads/writes preceeding the CACHE instruction are guaranteed
> to have completed that is the last CACHE instruction that was executed
> may still be incomplete.

I meant another piece:

"For implementations which implement multiple level of caches  ... 
<speaking about inclusive caches here> ... The software must place a 
SYNC instruction after the CACHE instruction whenever there are possible 
writebacks from the inner cache to ensure that the writeback data is 
resident in the outer cache before operating on the
outer cache. ... <the rest of statement is a bogeyman story about not 
doing so>

For implementations which implement muliple level of caches without the 
inclusion property, the use of a SYNC instruction after the CACHE 
instruction is still needed whenever writeback data has to be resident 
in the next level of memory hierarchy."

It seems the last sentence shall be also applied for inclusive caches too.

Gleb.
