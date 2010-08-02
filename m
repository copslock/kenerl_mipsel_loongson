Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Aug 2010 23:47:01 +0200 (CEST)
Received: from server19320154104.serverpool.info ([193.201.54.104]:60923 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492789Ab0HBVq6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 2 Aug 2010 23:46:58 +0200
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 63FAC85E2;
        Mon,  2 Aug 2010 23:46:55 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id pG8X+-82jwhn; Mon,  2 Aug 2010 23:46:51 +0200 (CEST)
Received: from [192.168.0.200] (host-091-096-211-123.ewe-ip-backbone.de [91.96.211.123])
        by hauke-m.de (Postfix) with ESMTPSA id 5E6BD85E1;
        Mon,  2 Aug 2010 23:46:51 +0200 (CEST)
Message-ID: <4C573CC9.7020608@hauke-m.de>
Date:   Mon, 02 Aug 2010 23:46:49 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.11) Gecko/20100713 Lightning/1.0b1 Thunderbird/3.0.6
MIME-Version: 1.0
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH 2/4] MIPS: BCM47xx: Fill values for b43 into ssb sprom
References: <1280261566-8247-1-git-send-email-hauke@hauke-m.de> <1280261566-8247-3-git-send-email-hauke@hauke-m.de> <20100802153103.GB11598@linux-mips.org> <20100802192543.GA31070@linux-mips.org>
In-Reply-To: <20100802192543.GA31070@linux-mips.org>
X-Enigmail-Version: 1.0.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
Precedence: bulk
X-list: linux-mips

Am 02.08.2010 21:25, schrieb Ralf Baechle:
> On Mon, Aug 02, 2010 at 04:31:03PM +0100, Ralf Baechle wrote:
>> Date: Mon, 2 Aug 2010 16:31:03 +0100
>> From: Ralf Baechle <ralf@linux-mips.org>
>> To: Hauke Mehrtens <hauke@hauke-m.de>
>> Cc: linux-mips@linux-mips.org
>> Subject: Re: [PATCH 2/4] MIPS: BCM47xx: Fill values for b43 into ssb sprom
>> Content-Type: text/plain; charset=us-ascii
>>
>> Thanks, applied.
> 
> Causes warnings which then break the build.  Dropped.
> 
>   Ralf

Hi,

what warnings and error messages do you get?

Hauke
