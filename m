Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 May 2005 12:01:09 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:31503 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225430AbVEPLAy>; Mon, 16 May 2005 12:00:54 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id AD618F5F8E; Mon, 16 May 2005 13:00:44 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22259-07; Mon, 16 May 2005 13:00:44 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 550ACF5C8A; Mon, 16 May 2005 13:00:44 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j4GAxu2c027225;
	Mon, 16 May 2005 13:00:47 +0200
Date:	Mon, 16 May 2005 12:00:02 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Mile Davidovic <mile.davidovic@micronasnit.com>
Cc:	"'Linux/MIPS Development'" <linux-mips@linux-mips.org>
Subject: Re: Mips 4lkecr2 
In-Reply-To: <200505161001.j4GA1V1p028192@krt.neobee.net>
Message-ID: <Pine.LNX.4.61L.0505161126220.15490@blysk.ds.pg.gda.pl>
References: <200505161001.j4GA1V1p028192@krt.neobee.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/879/Sun May 15 15:43:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7915
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 16 May 2005, Mile Davidovic wrote:

> I have embedded processor with MIPS 4KECr2 processor and tried to port
> linux-2.6.11-mipscvs-20050313.
> I follow tutorial from linux-mips and add custom code for int handler, time
> ...
> But I have some problem with detecting of cpu. In cpu-probe.c I added:
> cpu_probe_mips with:
>        case PRID_IMP_4KEC:
>        case PRID_IMP_4KECR2:   /* this line is added */
>         c->cputype = CPU_4KEC;
> 		c->isa_level = MIPS_CPU_ISA_M32;
> 
> Is it ok ? Did I forgot something?

 Well, the processor is already supported in the current version of Linux.  
Had you chosen it for your port, you wouldn't have had to change anything.

> I have problem with mem_init, here is output log, can You please tell me
> what is problem with this?
> Linux version 2.6.11-mipscvs-20050313-md (davidovic@rhel.micronasnit.com)
> (gcc version 3.4.2) #207 Mon May 16 10:37:55 CEST 2005
> CPU revision is: 00019064
[...]
> Bad page state at __free_pages_ok (in process 'swapper', page 810037c0)
> flags:0x00000000 mapping:00000004 mapcount:0 count:0

 Please retry with the current version and if still failing, then send 
another report.

  Maciej
