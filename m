Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 May 2006 20:13:23 +0200 (CEST)
Received: from p549F4E10.dip.t-dialin.net ([84.159.78.16]:40615 "EHLO
	p549F4E10.dip.t-dialin.net") by ftp.linux-mips.org with ESMTP
	id S8133967AbWESSNQ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 May 2006 20:13:16 +0200
Received: from rtsoft2.corbina.net ([85.21.88.2]:45454 "HELO
	mail.dev.rtsoft.ru") by lappi.linux-mips.net with SMTP
	id S1099211AbWESSNO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 May 2006 11:13:14 -0700
Received: (qmail 29560 invoked from network); 19 May 2006 21:20:11 -0000
Received: from wasted.dev.rtsoft.ru (HELO ?192.168.1.248?) (192.168.1.248)
  by mail.dev.rtsoft.ru with SMTP; 19 May 2006 21:20:11 -0000
Message-ID: <446DFC2E.4040400@ru.mvista.com>
Date:	Fri, 19 May 2006 21:11:10 +0400
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
User-Agent: Mozilla/5.0 (X11; U; Linux i686; rv:1.7.2) Gecko/20040803
X-Accept-Language: ru, en-us, en-gb
MIME-Version: 1.0
To:	Jordan Crouse <jordan.crouse@amd.com>
CC:	Linux-MIPS <linux-mips@linux-mips.org>, clem.taylor@gmail.com
Subject: Re: I2C troubles with Au1550
References: <ecb4efd10605181454v34ef19degf2cdd2535b37fc30@mail.gmail.com> <20060519143247.GC9596@cosmic.amd.com> <446DDABE.2040105@ru.mvista.com> <20060519150851.GD9596@cosmic.amd.com>
In-Reply-To: <20060519150851.GD9596@cosmic.amd.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11502
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Jordan Crouse wrote:
> On 19/05/06 18:48 +0400, Sergei Shtylyov wrote:
>  
> 
>>   Alas, I have to NAK this. DBAu1200 code should be in 
>>arch/mips/au1000/pb1200/...

> if this was DB1200 code only, I would be inclined to agree, but its
> not - so this code is well placed.

    It's under #ifdef CONFIG_MIPS_DB1200, so is *completely* misplaced. This 
file is not even compiled for DBAu1200. Therefore, this code will never execute.

>>   Thou wait... that hunk won't even aplly to the current git tree... 

> Well, it does apply - latest GIT tree, right from l-m.o

    Hmm, indeed it applies with fuzz (because of PSC redefinitions)... So, I'm 
taking this back. :-)

>>Looks like this patch is trying to redeclare PSC base addresses for Au1200 

> Yeah, it does a redundant declaration - I'll pull that part of it.  The
> rest of the patch is still valid though - I see no reason why you should NAK
> it, especially when this was posted by popular request.

    Because I caught a defect in it with naked eye. Maybe NAKing it was indeed 
too much. :-)

> Jordan

MBR, Sergei
