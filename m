Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Dec 2008 20:33:08 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:41647 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S24149369AbYLJUdA (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 10 Dec 2008 20:33:00 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id C490AC8012;
	Wed, 10 Dec 2008 22:32:53 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 4w67wBFBTdXL; Wed, 10 Dec 2008 22:32:53 +0200 (EET)
Received: from webmail.movial.fi (webmail.movial.fi [62.236.91.25])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id A7D4BC8010;
	Wed, 10 Dec 2008 22:32:53 +0200 (EET)
Received: by webmail.movial.fi (Postfix, from userid 33)
	id 9A2B423C85A; Wed, 10 Dec 2008 22:32:53 +0200 (EET)
Received: from 88.114.236.15
        (SquirrelMail authenticated user dvorobye)
        by webmail.movial.fi with HTTP;
        Wed, 10 Dec 2008 22:32:53 +0200 (EET)
Message-ID: <35373.88.114.236.15.1228941173.squirrel@webmail.movial.fi>
In-Reply-To: <b2b2f2320812101228i285257f6v64e1de88910ea63e@mail.gmail.com>
References: <1228936355-11675-1-git-send-email-dmitri.vorobiev@movial.fi>
    <b2b2f2320812101228i285257f6v64e1de88910ea63e@mail.gmail.com>
Date:	Wed, 10 Dec 2008 22:32:53 +0200 (EET)
Subject: Re: [PATCH] [MIPS] Kconfig: fix the arch-specific header path
From:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
To:	"Shane McDonald" <mcdonald.shane@gmail.com>
Cc:	"Dmitri Vorobiev" <dmitri.vorobiev@movial.fi>, ralf@linux-mips.org,
	linux-mips@linux-mips.org
User-Agent: SquirrelMail/1.4.9a
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21570
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

> As long as you're changing that line, I'd suggest fixing the spelling
> mistake, too (debuging should be debugging).

Indeed :) Didn't notice that, thank you.

Dmitri

>
> Shane
>
> On Wed, Dec 10, 2008 at 1:12 PM, Dmitri Vorobiev
> <dmitri.vorobiev@movial.fi> wrote:
>>
>> The header path in the help text for the RUNTIME_DEBUG config
>> option is obsolete and needs to be updated to match the new
>> location of architecture-specific header files.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
>> ---
>>  arch/mips/Kconfig.debug |    2 +-
>>  1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
>> index 765c8e2..aab004f 100644
>> --- a/arch/mips/Kconfig.debug
>> +++ b/arch/mips/Kconfig.debug
>> @@ -48,7 +48,7 @@ config RUNTIME_DEBUG
>>        help
>>          If you say Y here, some debugging macros will do run-time
>> checking.
>>          If you say N here, those macros will mostly turn to no-ops.
>> See
>> -         include/asm-mips/debug.h for debuging macros.
>> +         arch/mips/include/asm/debug.h for debuging macros.
>>          If unsure, say N.
>>
>>  endmenu
>> --
>> 1.5.4.3
>>
>>
>
