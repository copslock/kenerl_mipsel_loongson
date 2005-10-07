Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Oct 2005 21:42:19 +0100 (BST)
Received: from dragonboat.cs.uoguelph.ca ([131.104.96.108]:26042 "EHLO
	dragonboat.cs.uoguelph.ca") by ftp.linux-mips.org with ESMTP
	id S8133582AbVJGUl7 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Oct 2005 21:41:59 +0100
Received: from beddie.cis.uoguelph.ca (marvin.cis.uoguelph.ca [131.104.48.131])
	by dragonboat.cs.uoguelph.ca (8.13.1/8.13.1) with ESMTP id j97KfucQ016403;
	Fri, 7 Oct 2005 16:41:56 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id E1EBF1DF03;
	Fri,  7 Oct 2005 16:41:46 -0400 (EDT)
Received: from beddie.cis.uoguelph.ca ([127.0.0.1])
	by localhost (beddie [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 29786-02; Fri, 7 Oct 2005 16:41:46 -0400 (EDT)
Received: from [131.104.49.198] (unknown [131.104.49.198])
	by beddie.cis.uoguelph.ca (Postfix) with ESMTP id 2C3808A6E;
	Fri,  7 Oct 2005 16:41:46 -0400 (EDT)
Message-ID: <4346DD97.40106@uoguelph.ca>
Date:	Fri, 07 Oct 2005 16:41:59 -0400
From:	Brett Foster <fosterb@uoguelph.ca>
User-Agent: Mozilla Thunderbird 1.0 (Windows/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Kyle Unice <unixe@comcast.net>
CC:	linux-mips@linux-mips.org
Subject: Re: Cross-compiling Linux problem
References: <002b01c5cb7c$45c181e0$0400a8c0@buzz>
In-Reply-To: <002b01c5cb7c$45c181e0$0400a8c0@buzz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at cs-club.org
X-Scanned-By: MIMEDefang 2.52 on 131.104.96.108
Return-Path: <fosterb@uoguelph.ca>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9190
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: fosterb@uoguelph.ca
Precedence: bulk
X-list: linux-mips

Kyle Unice wrote:

>arch/mips/mm/tlbex.c:516:5: warning: "CONFIG_64BIT" is not defined
>  AS      arch/mips/mm/tlbex-fault.o
>  CC      arch/mips/mm/ioremap.o
>arch/mips/mm/ioremap.c: In function `__ioremap':
>include/asm-mips/mach-au1x00/ioremap.h:15: sorry, unimplemented: inlining
>failed
> in call to '__fixup_bigphys_addr': function body not available
>arch/mips/mm/ioremap.c:28: sorry, unimplemented: called from here
>make[1]: *** [arch/mips/mm/ioremap.o] Error 1
>make: *** [arch/mips/mm] Error 2
>  
>
I once had this sort of problem when I forgot to specify the cross 
compiler while invoking make and tried to compile a MIPS kernel on X86 gcc.

Brett
