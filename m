Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Jul 2008 08:26:34 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:18658 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20042504AbYGIH01 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 9 Jul 2008 08:26:27 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id D7674C8103;
	Wed,  9 Jul 2008 10:26:20 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id md1cu9u6lp6V; Wed,  9 Jul 2008 10:26:20 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id B2F12C8100;
	Wed,  9 Jul 2008 10:26:20 +0300 (EEST)
Message-ID: <487468E2.30402@movial.fi>
Date:	Wed, 09 Jul 2008 10:29:38 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Shane McDonald <mcdonald.shane@gmail.com>,
	linux-mips@linux-mips.org
Subject: Re: [MIPS] Fix section mismatches when compiling atlas and	decstation
 defconfigs
References: <E1KFH2c-0005iq-80@localhost> <20080708184922.GA27245@linux-mips.org>
In-Reply-To: <20080708184922.GA27245@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19746
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sat, Jul 05, 2008 at 05:19:42PM -0600, Shane McDonald wrote:
> 
>> From: Shane McDonald <mcdonald.shane@gmail.com>
>>
>> Section mismatches are reported when compiling the default
>> Atlas configuration and the default Decstation configuration.
>> This patch resolves those mismatches by defining affected
>> functions with the __cpuinit attribute, rather than __init.
>>
>> Signed-off-by: Shane McDonald <mcdonald.shane@gmail.com>
> 
> I already had an earlier version of your patch applied so I have only
> applied the c-r4k.c part now with an adjusted comment.

Isn't Atlas doomed to death?

Thanks,
Dmitri

> 
> Thanks,
> 
>   Ralf
> 
