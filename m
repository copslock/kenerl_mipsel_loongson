Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Feb 2013 21:50:11 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:41853 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6825899Ab3BSUuJL9hd9 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 19 Feb 2013 21:50:09 +0100
Message-ID: <5123E45B.8060203@phrozen.org>
Date:   Tue, 19 Feb 2013 21:45:15 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:10.0.7) Gecko/20120922 Icedove/10.0.7
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     ralf@linux-mips.org, "David S. Miller" <davem@davemloft.net>,
        linux-mips@linux-mips.org,
        Network Development <netdev@vger.kernel.org>,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: Re: Upcoming cross-tree build breakage on merge window
References: <CACna6ryD3SjLN-oauvVuRa+q7an8DaULj+Uj4bwFSzQf2WCvMw@mail.gmail.com> <CACna6rwYZWsGhb8ksko+XGvod=hVyVHu2QrCfEisTG=YAEfBRQ@mail.gmail.com>
In-Reply-To: <CACna6rwYZWsGhb8ksko+XGvod=hVyVHu2QrCfEisTG=YAEfBRQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-archive-position: 35789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 19/02/13 20:44, Rafał Miłecki wrote:
> 2013/1/23 Rafał Miłecki<zajec5@gmail.com>:
>> I've noticed possible build breakage when two trees get merged:
>> net-next and linux-john (MIPS).
>>
>> This is about two following commits:
>> http://git.kernel.org/?p=linux/kernel/git/davem/net-next.git;a=commit;h=dd4544f05469aaaeee891d7dc54d66430344321e
>> http://git.linux-mips.org/?p=john/linux-john.git;a=commit;h=a008ca117bc85a9d66c47cd5ab18a6c332411919
>>
>> The first one adds "bgmac" driver which uses asm/mach-bcm47xx/nvram.h
>> and nvram_getenv. The second one renames them.
>>
>> Can you handle this in some clever way during merge window, please?
>>
>> The fix is trivial:
>> 1) Use<bcm47xx_nvram.h>
>> 2) Use bcm47xx_nvram_getenv
>
> Just a reminder.
>


Hi,

Ralf told me he will pull the fix into his upstream-sfr.git today so 
that the upcoming linux-next should not build break due to this patch

	John
