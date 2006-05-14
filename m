Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 May 2006 20:39:57 +0200 (CEST)
Received: from eastrmmtao01.cox.net ([68.230.240.38]:5268 "HELO
	eastrmmtao01.cox.net") by ftp.linux-mips.org with SMTP
	id S8133622AbWENSju (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 May 2006 20:39:50 +0200
Received: from hermes.mountolympos.net ([70.160.186.45])
          by eastrmmtao01.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060514183943.EVXM17255.eastrmmtao01.cox.net@hermes.mountolympos.net>
          for <linux-mips@linux-mips.org>; Sun, 14 May 2006 14:39:43 -0400
Received: from zeus.mountolympos.net (zeus.mountolympos.net [192.168.2.2])
	by hermes.mountolympos.net (Postfix) with ESMTP id EB4A81677B
	for <linux-mips@linux-mips.org>; Sun, 14 May 2006 14:39:42 -0400 (EDT)
Received: from [192.168.2.3] (kronos.mountolympos.net [192.168.2.3])
	by zeus.mountolympos.net (Postfix) with ESMTP id D75DC100A116
	for <linux-mips@linux-mips.org>; Sun, 14 May 2006 14:39:42 -0400 (EDT)
Message-ID: <4467796E.8060000@mountolympos.net>
Date:	Sun, 14 May 2006 14:39:42 -0400
From:	John Miller <jamiller1110@cox.net>
User-Agent: Thunderbird 1.5 (X11/20060402)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Instruction error with cache opcode
References: <446735C6.2080306@mountolympos.net> <002a01c67761$253e97f0$0202a8c0@Ulysses>
In-Reply-To: <002a01c67761$253e97f0$0202a8c0@Ulysses>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <jamiller1110@cox.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11420
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jamiller1110@cox.net
Precedence: bulk
X-list: linux-mips


> Where and how is the value of Index_Store_Tag_I  defined?
>
>             Regards,
>
>             Kevin K.
>   

I included asm/cacheops.h from the kernel tree, it is defined there as :

#define Index_Store_Tag_I	0x08

I also tried to substitute 0x08 directly into my source and I got the
same error.  Strangely enough, if I remove the include line, I get the
same exact error.
