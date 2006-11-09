Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Nov 2006 17:20:32 +0000 (GMT)
Received: from mother.pmc-sierra.com ([216.241.224.12]:18099 "HELO
	mother.pmc-sierra.bc.ca") by ftp.linux-mips.org with SMTP
	id S20037722AbWKIRU0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Nov 2006 17:20:26 +0000
Received: (qmail 5561 invoked by uid 101); 9 Nov 2006 17:20:15 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 9 Nov 2006 17:20:15 -0000
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id kA9HKFhG010411;
	Thu, 9 Nov 2006 09:20:15 -0800
Received: by bby1exi01.pmc-sierra.bc.ca with Internet Mail Service (5.5.2657.72)
	id <VY7R0LRT>; Thu, 9 Nov 2006 09:20:15 -0800
Message-ID: <E8C8A5231DDE104C816ADF532E0639120194F4CC@bby1exm07.pmc_nt.nt.pmc-sierra.bc.ca>
From:	Trevor Hamm <Trevor_Hamm@pmc-sierra.com>
To:	"'Atsushi Nemoto'" <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: RE: Problems booting Linux 2.6.18.1 on MIPS34K core
Date:	Thu, 9 Nov 2006 09:20:12 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2657.72)
Content-Type: text/plain
Return-Path: <Trevor_Hamm@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Trevor_Hamm@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

 

> -----Original Message-----
> From: Atsushi Nemoto [mailto:anemo@mba.ocn.ne.jp] 
> Sent: Wednesday, November 08, 2006 7:58 PM
> To: Trevor Hamm
> Cc: linux-mips@linux-mips.org
> Subject: Re: Problems booting Linux 2.6.18.1 on MIPS34K core
> 
> Hmm, could you try init=/bin/sh?  If the shell invoked successfully it
> might be COW issue.  

Yes, /bin/sh works.  I've also run different /sbin/init programs successfully (sysvinit, busybox; I think I mentioned sysvinit worked in my original post).  It's just with simpleinit from util-linux 2.12r that we've seen this issue.

> In this case, could you try deleting
> __HAVE_ARCH_COPY_USER_HIGHPAGE in include/asm-mips/page.h?
> 

Okay, I did this, but /sbin/init still hangs in the same place.  I also had to delete the copy_user_highpage function in arch/mips/mm/init.c to get the kernel to build.  It's now using the copy_user_highpage from include/linux/highmem.h.  I assume this was your intention?

Thanks,
Trevor
