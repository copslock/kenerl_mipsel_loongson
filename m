Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2006 21:48:07 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:8932 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20038781AbWKNVsB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 14 Nov 2006 21:48:01 +0000
Received: (qmail 11875 invoked by uid 101); 14 Nov 2006 21:47:46 -0000
Received: from unknown (HELO ogmios.pmc-sierra.bc.ca) (216.241.226.59)
  by mother.pmc-sierra.com with SMTP; 14 Nov 2006 21:47:46 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kAELljN7023611;
	Tue, 14 Nov 2006 13:47:45 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7S189C>; Tue, 14 Nov 2006 13:47:45 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4CD@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Tue, 14 Nov 2006 13:47:41 -0800
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
> Sent: Thursday, November 09, 2006 9:16 PM
> To: Trevor Hamm
> Cc: linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> Could you confirm that removing whole "if (mapping ..." block from
> __flush_dcache_page can hide your problem?
> 

Yes, removing this block seems to hide the problem.  I can boot completely to a login prompt.

> Or if you changed a line in __update_cache():
> 
> 	int exec = (vma->vm_flags & VM_EXEC) && !cpu_has_ic_fills_f_dc;
> 
> to
> 
> 	int exec = 1;
> 
> then your problem still happen?
> 

Yes, with this change, the boot-up problem persists.

Thanks,
Trevor
