Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 Jul 2005 14:28:38 +0100 (BST)
Received: from mra02.ch.as12513.net ([IPv6:::ffff:82.153.252.24]:33258 "EHLO
	mra02.ch.as12513.net") by linux-mips.org with ESMTP
	id <S8225296AbVGVN2U>; Fri, 22 Jul 2005 14:28:20 +0100
Received: from localhost (localhost [127.0.0.1])
	by mra02.ch.as12513.net (Postfix) with ESMTP id 03B03D4C79;
	Fri, 22 Jul 2005 14:30:18 +0100 (BST)
Received: from mra02.ch.as12513.net ([127.0.0.1])
 by localhost (mra02.ch.as12513.net [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id 00594-01-98; Fri, 22 Jul 2005 14:30:16 +0100 (BST)
Received: from euskadi.packetvision (unknown [82.152.104.245])
	by mra02.ch.as12513.net (Postfix) with ESMTP id CCD0BD4C5D;
	Fri, 22 Jul 2005 14:30:15 +0100 (BST)
Subject: Re: Going over 512M of memory
From:	Alex Gonzalez <linux-mips@packetvision.com>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
In-Reply-To: <20050722131417.GA29581@linux-mips.org>
References: <20050721153359Z8225218-3678+3745@linux-mips.org>
	 <20050722043057.GA3803@linux-mips.org>
	 <1122023087.30605.3.camel@euskadi.packetvision>
	 <20050722131417.GA29581@linux-mips.org>
Content-Type: text/plain
Message-Id: <1122039139.30605.21.camel@euskadi.packetvision>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-9) 
Date:	Fri, 22 Jul 2005 14:32:19 +0100
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by Eclipse VIRUSshield at eclipse.net.uk
Return-Path: <linux-mips@packetvision.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux-mips@packetvision.com
Precedence: bulk
X-list: linux-mips

It's a RM9020.

Quoting Ibrahim's,

"With a slightly extended patch it actually works. But afterwards
I get a lot of Illegal instructions and Segmentation faults, where
there shouldn't be any. Below is the patch I used."

And after you post an improved patch, he says,

"I presume CKSEG is CKSEG0 in the above patch. With that it works
about the same as before. So do you have any clue what the problem
behind all that really is? Furthermore I still have all those
"Illegal instruction" and "Segmentation fault" messages that
shouldn't be there."

The illegal instructions and segmentation faults turned to be the cpu_has_64bit_gp_regs setting. So I presume it worked for him.

In our case, it seems to work completely OK. I am running a complete memory test over the whole 1G to be completely sure (with memtester), and I'll report the result back.

Thanks,
Alex


On Fri, 2005-07-22 at 14:14, Ralf Baechle wrote:
> On Fri, Jul 22, 2005 at 10:04:47AM +0100, Alex Gonzalez wrote:
> 
> > Our target experienced a kernel panic at startup when trying to access
> > memory above 512MB.
> > 
> > Reading the list archives I found this thread with a proposed patch:
> > 
> > http://www.linux-mips.org/archives/linux-mips/2005-02/msg00115.html
> > 
> > After applying the patch our target boots OK and appears to be able to
> > access the whole memory range without problems.
> > 
> > Any idea why this patch didn't make it to the repository? Is it safe?
> 
> It is - but according to Ibrahim's posting that you're pointing to it
> didn't solve his problem.
> 
> What CPU are you using, btw?
> 
>   Ralf
-- 

Alex Gonzalez
Packet Vision Limited
Unit I4, Reading Enterprise Hub
Earley Gate, Whiteknights Road
Reading, Berkshire, UK
RG6 6AU
                                                                
T. +44 (0) 1189 357070
F. +44 (0) 1189 357330
                                                                
www.packetvision.com
===================================================== 
