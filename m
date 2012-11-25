Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 25 Nov 2012 13:27:55 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:56323 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824758Ab2KYM1ygXE6M (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 25 Nov 2012 13:27:54 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 2A0178F61;
        Sun, 25 Nov 2012 13:27:53 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id A6a4fF0P7EiW; Sun, 25 Nov 2012 13:27:43 +0100 (CET)
Received: from [IPv6:2001:470:1f0b:447:85f0:8d9:45b8:5348] (unknown [IPv6:2001:470:1f0b:447:85f0:8d9:45b8:5348])
        by hauke-m.de (Postfix) with ESMTPSA id DAB2D8F60;
        Sun, 25 Nov 2012 13:27:42 +0100 (CET)
Message-ID: <50B20EBB.3080204@hauke-m.de>
Date:   Sun, 25 Nov 2012 13:27:39 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     linville@tuxdriver.com, linux-wireless@vger.kernel.org,
        wim@iguana.be, linux-watchdog@vger.kernel.org,
        castet.matthieu@free.fr, biblbroks@sezampro.rs, m@bues.ch,
        zajec5@gmail.com, linux-mips@linux-mips.org
Subject: Re: [PATCH 04/15] watchdog: bcm47xx_wdt.c: rename wdt_timeout to
 timeout
References: <1353795855-22236-1-git-send-email-hauke@hauke-m.de> <1353795855-22236-5-git-send-email-hauke@hauke-m.de> <50B14BD6.8050302@mvista.com>
In-Reply-To: <50B14BD6.8050302@mvista.com>
X-Enigmail-Version: 1.4.6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 35124
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 11/24/2012 11:36 PM, Sergei Shtylyov wrote:
> Hello.
> 
> On 25-11-2012 2:24, Hauke Mehrtens wrote:
> 
>> Rename rename
> 
>    Once it enough. :-)
> 
>> wdt_timeout
> 
>    'wdt_time', you mean?
> 
>> to timeout to name it like the other watchdog
>> driver do it.
> 
>    It's not the only change you're doing.
> 
Thanks for spotting this, I will change the changelog.

Hauke
