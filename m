Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Jul 2008 16:25:55 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:51642 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20132827AbYGCPZw (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 3 Jul 2008 16:25:52 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 88585C80EF;
	Thu,  3 Jul 2008 18:25:46 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id T-B8x4W0+2TB; Thu,  3 Jul 2008 18:25:46 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 68BEBC80ED;
	Thu,  3 Jul 2008 18:25:46 +0300 (EEST)
Message-ID: <486CF01F.9080808@movial.fi>
Date:	Thu, 03 Jul 2008 18:28:31 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: [PATCH 5/5] [MIPS] Add an appropriate header into display.c
References: <1213773503-23536-1-git-send-email-dmitri.vorobiev@movial.fi> <1213773503-23536-6-git-send-email-dmitri.vorobiev@movial.fi> <20080703152338.GC11434@linux-mips.org>
In-Reply-To: <20080703152338.GC11434@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19713
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Wed, Jun 18, 2008 at 10:18:23AM +0300, Dmitri Vorobiev wrote:
> 
>> The following errors were caught by sparse:
>>
>> arch/mips/mips-boards/generic/display.c:30:6: warning: symbol
>> 'mips_display_message' was not declared. Should it be static?
>>
>> arch/mips/mips-boards/generic/display.c:58:6: warning: symbol
>> 'mips_scroll_message' was not declared. Should it be static?
>>
>> This patch includes the asm/mips-boards/prom.h header file into
>> arch/mips/mips-boards/generic/display.c. This adds the needed
>> function declarations, and the errors are gone.
>>
>> Compile-tested using defconfigs for Malta, Atlas and SEAD boards.
>> Runtime test was successfully performed by booting a Malta 4Kc
>> board up to the shell prompt.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
> 
> Queued for 2.6.27.  Thanks,

Ralf, thanks for picking up the series.

Dmitri
