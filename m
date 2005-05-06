Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2005 15:51:35 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:29710 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225459AbVEFOvT>; Fri, 6 May 2005 15:51:19 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 6E104F5CB2
	for <linux-mips@linux-mips.org>; Fri,  6 May 2005 16:51:13 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 11801-04 for <linux-mips@linux-mips.org>;
 Fri,  6 May 2005 16:51:13 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 2D1E2F5CAF
	for <linux-mips@linux-mips.org>; Fri,  6 May 2005 16:51:13 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.13.1) with ESMTP id j46EpHgD014072
	for <linux-mips@linux-mips.org>; Fri, 6 May 2005 16:51:17 +0200
Date:	Fri, 6 May 2005 15:51:25 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050506143118Z8225421-1340+6642@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0505061540540.25293@blysk.ds.pg.gda.pl>
References: <20050506143118Z8225421-1340+6642@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.83/871/Thu May  5 15:50:45 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7882
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 6 May 2005 ralf@linux-mips.org wrote:

> CVSROOT:	/home/cvs
> Module name:	linux
> Changes by:	ralf@ftp.linux-mips.org	05/05/06 15:31:13
> 
> Modified files:
> 	arch/mips/kernel: cpu-probe.c 
> 
> Log message:
> 	No point in checking cpu_has_tlb before we've computed the CPU options.

 ???  decode_config0() sets up the CPU option in question, so doing a 
check after decode_configs() is fine.

> 	So for now we just unconditionally set the option - Linux wouldn't
> 	work without a TLB anyway.

 I don't like the idea -- bits shouldn't be scattered all over the place, 
so that all the places need to be chased and fixed once conditions change.  

 Instead of polluting all the cpu_probe_*() functions, it should actually 
be moved to decode_config0().  I can apply a suitable fix.

  Maciej
