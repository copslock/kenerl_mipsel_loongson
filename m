Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:34:01 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:3478 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20038752AbYFPOd7 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 15:33:59 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id 44361C80D7;
	Mon, 16 Jun 2008 17:33:53 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id jBeusUlqEw+M; Mon, 16 Jun 2008 17:33:53 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id 27802C80D3;
	Mon, 16 Jun 2008 17:33:53 +0300 (EEST)
Message-ID: <48567A12.3050206@movial.fi>
Date:	Mon, 16 Jun 2008 17:34:58 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] malta_mtd.c: add MODULE_LICENSE
References: <20080615161321.GB7865@cs181133002.pp.htv.fi> <20080616133049.GA24056@linux-mips.org>
In-Reply-To: <20080616133049.GA24056@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Sun, Jun 15, 2008 at 07:13:21PM +0300, Adrian Bunk wrote:
> 
>> This patch adds the missing MODULE_LICENSE("GPL").
>>
>> Reported-by: Adrian Bunk <bunk@kernel.org>
>> Signed-off-by: Adrian Bunk <bunk@kernel.org>
> 
> NACK.  This file is only a module because 2.6.20 wouldn't build otherwise.
> That's long fixed.

Every time I come across this file I wonder whether this needs to be
modularized at all. Isn't you chainsaw itching for this as well? :)

Dmitri

> 
>   Ralf
> 
