Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Nov 2008 10:24:35 +0000 (GMT)
Received: from smtp.movial.fi ([62.236.91.34]:39304 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S23947879AbYK0KYc (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 27 Nov 2008 10:24:32 +0000
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 9AD0EC8092;
	Thu, 27 Nov 2008 12:24:26 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id 6XOtskLEbvj7; Thu, 27 Nov 2008 12:24:26 +0200 (EET)
Received: from webmail.movial.fi (webmail.movial.fi [62.236.91.25])
	(using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.movial.fi (Postfix) with ESMTP id 7F1BAC8001;
	Thu, 27 Nov 2008 12:24:26 +0200 (EET)
Received: by webmail.movial.fi (Postfix, from userid 33)
	id 6FC7523CE0B; Thu, 27 Nov 2008 12:24:26 +0200 (EET)
Received: from 88.114.226.209
        (SquirrelMail authenticated user dvorobye)
        by webmail.movial.fi with HTTP;
        Thu, 27 Nov 2008 12:24:26 +0200 (EET)
Message-ID: <43787.88.114.226.209.1227781466.squirrel@webmail.movial.fi>
In-Reply-To: <20081127091619.GA6255@alpha.franken.de>
References: <1227706472-16219-1-git-send-email-dmitri.vorobiev@movial.fi>
    <20081127091619.GA6255@alpha.franken.de>
Date:	Thu, 27 Nov 2008 12:24:26 +0200 (EET)
Subject: Re: [PATCH] [MIPS] Remove unused header file gio.h
From:	"Vorobiev Dmitri" <dmitri.vorobiev@movial.fi>
To:	"Thomas Bogendoerfer" <tsbogend@alpha.franken.de>
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
X-archive-position: 21458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

> On Wed, Nov 26, 2008 at 03:34:32PM +0200, Dmitri Vorobiev wrote:
>> Grepping reveals that arch/mips/include/asm/sgi/gio.h is
>> not used by anyone, so let's delete the orphan header.
>>
>> Signed-off-by: Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
>> ---
>
> NAK, I have work in progress, which adds GIO devices and uses this
> file.
>

That's interesting news! May I ask you which ones you're working on?

Dmitri

> Thomas.
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessary a
> good idea.                                                [ RFC1925, 2.3 ]
>
>
