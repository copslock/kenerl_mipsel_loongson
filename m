Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 31 Jul 2003 17:50:58 +0100 (BST)
Received: from mother.pmc-sierra.com ([IPv6:::ffff:216.241.224.12]:19436 "HELO
	mother.pmc-sierra.bc.ca") by linux-mips.org with SMTP
	id <S8225207AbTGaQu4>; Thu, 31 Jul 2003 17:50:56 +0100
Received: (qmail 21028 invoked by uid 104); 31 Jul 2003 16:50:47 -0000
Received: from Adam_Kiepul@pmc-sierra.com by mother by uid 101 with qmail-scanner-1.15 
 (uvscan: v4.1.40/v4281.  Clear:. 
 Processed in 0.530752 secs); 31 Jul 2003 16:50:47 -0000
Received: from unknown (HELO ogyruan.pmc-sierra.bc.ca) (216.241.226.236)
  by mother.pmc-sierra.com with SMTP; 31 Jul 2003 16:50:46 -0000
Received: from bby1exi01.pmc-sierra.bc.ca (bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogyruan.pmc-sierra.bc.ca (8.12.9/8.12.7) with ESMTP id h6VHHLpD013520;
	Thu, 31 Jul 2003 10:17:24 -0700
Received: by bby1exi01 with Internet Mail Service (5.5.2656.59)
	id <P4MM4VJT>; Thu, 31 Jul 2003 09:50:37 -0700
Message-ID: <9DFF23E1E33391449FDC324526D1F259017DF087@SJC1EXM02>
From: Adam Kiepul <Adam_Kiepul@pmc-sierra.com>
To: "'Ralf Baechle'" <ralf@linux-mips.org>,
	Fuxin Zhang <fxzhang@ict.ac.cn>
Cc: MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
Subject: RE: RM7k cache_flush_sigtramp
Date: Thu, 31 Jul 2003 09:50:36 -0700
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2656.59)
Content-Type: text/plain
Return-Path: <Adam_Kiepul@pmc-sierra.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2941
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Adam_Kiepul@pmc-sierra.com
Precedence: bulk
X-list: linux-mips

Hi,

If this is just to ensure the I Cache coherency for modified code then the following should be sufficient:

cache Hit_Writeback_D, offset(base_register)
cache Hit_Invalidate_I, offset(base_register)

The ordering does matter however since the Hit_Invalidate_I makes sure the write buffer is flushed.

Kind Regards,

_______________________________

Adam Kiepul
Sr. Applications Engineer

PMC-Sierra, Microprocessor Division
Mission Towers One
3975 Freedom Circle
Santa Clara, CA 95054, USA
Direct: 408 239 8124
Fax: 408 492 9462



-----Original Message-----
From: Ralf Baechle [mailto:ralf@linux-mips.org]
Sent: Thursday, July 31, 2003 4:47 AM
To: Fuxin Zhang
Cc: MAKE FUN PRANK CALLS
Subject: Re: RM7k cache_flush_sigtramp


On Thu, Jul 31, 2003 at 09:56:08AM +0800, Fuxin Zhang wrote:
> Date:	Thu, 31 Jul 2003 09:56:08 +0800
> From:	Fuxin Zhang <fxzhang@ict.ac.cn>
> To:	MAKE FUN PRANK CALLS <linux-mips@linux-mips.org>
        ^^^^^^^^^^^^^^^^^^^^

Funny name for the list :-)

> r4k_cache_flush_sigtrap seems not enough for RM7000 cpus because
> there is a writebuffer between L1 dcache & L2 cache,so the written back
> block may not be seen by icache. This small patch fixes crashes of my
> Xserver on ev64240.

It would seem a similar fix is also needed in other places then?

  Ralf
