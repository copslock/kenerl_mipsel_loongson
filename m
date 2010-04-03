Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 03 Apr 2010 17:43:22 +0200 (CEST)
Received: from apfelkorn.psychaos.be ([195.144.77.38]:34397 "EHLO
        apfelkorn.psychaos.be" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492240Ab0DCPnR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 3 Apr 2010 17:43:17 +0200
Received: from p2 by apfelkorn.psychaos.be with local (Exim 4.69)
        (envelope-from <p2@psychaos.be>)
        id 1Ny5VA-0003sJ-CL; Sat, 03 Apr 2010 18:43:12 +0300
Date:   Sat, 3 Apr 2010 18:43:12 +0300
From:   Peter 'p2' De Schrijver <p2@debian.org>
To:     Andreas Barth <aba@not.so.argh.org>
Cc:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: movidis x16 hard lockup using 2.6.33
Message-ID: <20100403154312.GY2437@apfelkorn>
References: <20100326184132.GU2437@apfelkorn> <4BAD03A5.9070701@caviumnetworks.com> <20100327230744.GG27216@mails.so.argh.org> <4BB0DB2A.9080405@caviumnetworks.com> <20100402133224.GR27216@mails.so.argh.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20100402133224.GR27216@mails.so.argh.org>
X-Unexpected-Header: The spanish inquisition !
X-mate: Mate, mann gewohnt sich an alles
X-Paddo: Munch, Munch
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <p2@psychaos.be>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26348
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: p2@debian.org
Precedence: bulk
X-list: linux-mips

Hi,

> * David Daney (ddaney@caviumnetworks.com) [100329 18:54]:
> > [...]
> 
> I need to admit I'm sorry but I can't read enough from the log file.
> Serial console output is http://alius.ayous.org/~aba/screenlog.0
> 
> This kernel is with the NMI-handler but without the "don't reboot"
> patch:
> Linux version 2.6.34-rc2-dsa-octeon (aba@gabrielli) (gcc version 4.4.3
> (Debian 4.4.3-3) ) #5 SMP Sat Mar 27 10:16:03 UTC 2010
> 
> and this one has NMI-handler plus the small loop:
> Linux version 2.6.34-rc2-dsa-octeon (aba@gabrielli) (gcc version 4.4.3
> (Debian 4.4.3-3) ) #6 SMP Mon Mar 29 22:23:26 UTC 2010
> 
> 
> Unfortunatly it looks like we get neither the information nor don't
> reboot, but adding the NMU handler changed behaviour from "machine
> freezes" to "machine reboots".
> 

http://zobel.ftbfs.de/.x/lucatelli-nmi-watchdog-output.txt 
Dump of one of those hangs. Most cores seem to be stuck in wait 
(0xffffffff81100b80), except for core 1 which is in octeon_irq_ciu0_ack 
(octeon_irq_ciu0_ack).

Any insight welcome. 

Thanks,

Peter.
