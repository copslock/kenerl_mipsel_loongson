Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 May 2006 03:35:25 +0200 (CEST)
Received: from eastrmmtao05.cox.net ([68.230.240.34]:165 "HELO
	eastrmmtao05.cox.net") by ftp.linux-mips.org with SMTP
	id S8133764AbWEOBfS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 15 May 2006 03:35:18 +0200
Received: from hermes.mountolympos.net ([70.160.186.45])
          by eastrmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060515013511.IEQQ26910.eastrmmtao05.cox.net@hermes.mountolympos.net>;
          Sun, 14 May 2006 21:35:11 -0400
Received: from zeus.mountolympos.net (zeus.mountolympos.net [192.168.2.2])
	by hermes.mountolympos.net (Postfix) with ESMTP id F29751677B;
	Sun, 14 May 2006 21:35:10 -0400 (EDT)
Received: from [192.168.2.4] (odysseus.mountolympos.net [192.168.2.4])
	by zeus.mountolympos.net (Postfix) with ESMTP id BFE17100A116;
	Sun, 14 May 2006 21:35:10 -0400 (EDT)
Message-ID: <4467DACE.9000800@mountolympos.net>
Date:	Sun, 14 May 2006 21:35:10 -0400
From:	John Miller <jamiller1110@cox.net>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	linux-mips@linux-mips.org
Subject: Re: Instruction error with cache opcode
References: <446735C6.2080306@mountolympos.net>	<002a01c67761$253e97f0$0202a8c0@Ulysses>	<4467796E.8060000@mountolympos.net> <20060515.100659.126574393.nemoto@toshiba-tops.co.jp>
In-Reply-To: <20060515.100659.126574393.nemoto@toshiba-tops.co.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <jamiller1110@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11425
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamiller1110@cox.net
Precedence: bulk
X-list: linux-mips

Atsushi Nemoto wrote:
> On Sun, 14 May 2006 14:39:42 -0400, John Miller <jamiller1110@cox.net> wrote:
>   
>> I included asm/cacheops.h from the kernel tree, it is defined there as :
>>
>> #define Index_Store_Tag_I	0x08
>>     
>
> Then how about Fill_I ?
>
> ---
> Atsushi Nemoto
>   
That got it!  Sorry, I had my head up somewhere it was not supposed to 
be.  I do not know how many times I went over cacheops.h and missed the 
fact that Fill was defined, not Fill_I.  One I changed my code to Fill, 
it built the kernel nicely.  It still died before the first printk :) 
but at least I am a little closer.  I got Fill_I out of the See MIPS Run 
book, it has the same option hex (0x14) as Fill, does anyone know why 
this changed?
