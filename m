Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Jun 2010 19:29:28 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:38831 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492267Ab0FOR3X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Jun 2010 19:29:23 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id D15AD6BA;
        Tue, 15 Jun 2010 19:29:17 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id Ml9MYYMuI7uY; Tue, 15 Jun 2010 19:29:17 +0200 (CEST)
Received: from [172.31.16.228] (d079044.adsl.hansenet.de [80.171.79.44])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 375CF6B7;
        Tue, 15 Jun 2010 19:29:11 +0200 (CEST)
Message-ID: <4C17B84C.2080306@metafoo.de>
Date:   Tue, 15 Jun 2010 19:28:44 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Anton Vorontsov <cbouatmailru@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 23/26] power: Add JZ4740 battery driver.
References: <1275505397-16758-1-git-send-email-lars@metafoo.de> <1275505950-17334-7-git-send-email-lars@metafoo.de> <20100614155108.GA30552@oksana.dev.rtsoft.ru>
In-Reply-To: <20100614155108.GA30552@oksana.dev.rtsoft.ru>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-archive-position: 27139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 10515

Anton Vorontsov wrote:
> On Wed, Jun 02, 2010 at 09:12:29PM +0200, Lars-Peter Clausen wrote:
>   
>> This patch adds support for the battery voltage measurement part of the JZ4740
>> ADC unit.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Cc: Anton Vorontsov <cbouatmailru@gmail.com>
>> ---
>>     
>
> Looks good. I see this is an RFC. Do you want me to apply it
> or there's a newer version to be submitted?
>
> Thanks,
>
>   
Hi. Thanks for taking a look at it.
I'll send a new series which has some minor cleanups for the battery
driver soon.

- Lars
