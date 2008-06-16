Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 15:39:13 +0100 (BST)
Received: from smtp.movial.fi ([62.236.91.34]:17559 "EHLO smtp.movial.fi")
	by ftp.linux-mips.org with ESMTP id S20039520AbYFPOjK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 15:39:10 +0100
Received: from localhost (mailscanner.hel.movial.fi [172.17.81.9])
	by smtp.movial.fi (Postfix) with ESMTP id E3762C80D3;
	Mon, 16 Jun 2008 17:39:04 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at movial.fi
Received: from smtp.movial.fi ([62.236.91.34])
	by localhost (mailscanner.hel.movial.fi [172.17.81.9]) (amavisd-new, port 10026)
	with ESMTP id xoJJQC1WY8s2; Mon, 16 Jun 2008 17:39:04 +0300 (EEST)
Received: from [172.17.49.48] (sd048.hel.movial.fi [172.17.49.48])
	by smtp.movial.fi (Postfix) with ESMTP id C66A7C809E;
	Mon, 16 Jun 2008 17:39:04 +0300 (EEST)
Message-ID: <48567B4A.4090706@movial.fi>
Date:	Mon, 16 Jun 2008 17:40:10 +0300
From:	Dmitri Vorobiev <dmitri.vorobiev@movial.fi>
Organization: Movial Creative Technologies
User-Agent: Icedove 1.5.0.14eol (X11/20080509)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Adrian Bunk <bunk@kernel.org>, linux-mips@linux-mips.org
Subject: Re: [2.6 patch] malta_mtd.c: add MODULE_LICENSE
References: <20080615161321.GB7865@cs181133002.pp.htv.fi> <20080616133049.GA24056@linux-mips.org> <48567A12.3050206@movial.fi> <20080616143700.GA28471@linux-mips.org>
In-Reply-To: <20080616143700.GA28471@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <dmitri.vorobiev@movial.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19568
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dmitri.vorobiev@movial.fi
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Mon, Jun 16, 2008 at 05:34:58PM +0300, Dmitri Vorobiev wrote:
> 
>> Every time I come across this file I wonder whether this needs to be
>> modularized at all. Isn't you chainsaw itching for this as well? :)
> 
> The reason why it was implemented as a module was that due to a MTD
> "feature" the code wouldn't compile in 2.6.20 and earlier.  So yes, I
> chainsawed it into the right shape, patch is on the way to Linus.
> 

Understood. Thanks for the fast reply!

Dmitri

>   Ralf
