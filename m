Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Feb 2007 15:29:23 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:37905 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20037596AbXBVP3S (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Feb 2007 15:29:18 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E5EECE1CBB;
	Thu, 22 Feb 2007 16:28:27 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Iub+xt3jhcfa; Thu, 22 Feb 2007 16:28:27 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9C5AAE1C78;
	Thu, 22 Feb 2007 16:28:27 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l1MFSbkv020543;
	Thu, 22 Feb 2007 16:28:37 +0100
Date:	Thu, 22 Feb 2007 15:28:32 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Fix mmiowb() for MIPS I
In-Reply-To: <20070221181037.GB4157@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0702221500100.31423@blysk.ds.pg.gda.pl>
References: <20070222.021014.85684636.anemo@mba.ocn.ne.jp>
 <Pine.LNX.4.64N.0702211727530.29504@blysk.ds.pg.gda.pl>
 <20070221181037.GB4157@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2628/Thu Feb 22 12:31:25 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14204
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 21 Feb 2007, Ralf Baechle wrote:

> > should guarantee "val" has reached the register (mmiowb() replacing 
> > incorrect mb() used in many places like this), but with either definition 
> > of mmiowb() and a MIPS-I-style external write-back buffer it will not 
> > work.
> 
> Does a read from the same device suffice to provide the necessary flushing
> the same way as it does on PCI?

 No.  Neither the R2020 nor the R3220 write-back buffer chips (used for 
the R2000 and R3000, respectively) as used in DECstation systems support 
snooping for MMIO, so reads from that space will bypass writes pending in 
the buffer, even for the very same address.  There is some logic in the 
memory controller to resolve such conflicts, but it is activated for main 
RAM accesses only.  Once the write-back buffer has been drained there is 
no need for a read-back though.  The CP0 condition can be used to check 
whether there are any pending writes in the buffer (it is false if there 
are).

 OTOH, DECstation systems that do not use either of the write-back buffers 
mentioned above do require a "sync" (if using the R4000 or R4400 CPU) 
followed by a read-back (any uncached address does) to drain the 
write-back buffer in the MB (memory buffer) ASIC.

> I'm not opposed to allowing platform specific definitions for operations
> like mmiowbb() but I think we really should get rid of the special MIPS
> iob() operation.

 Certainly, but before that happens there has to be a way to be able to 
specify the desired barrier in a generic driver like defxx.c without the 
need to know the underlying platform.

  Maciej
