Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2006 17:31:32 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:61966 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133537AbWAaRbO (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 31 Jan 2006 17:31:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 67A79F5BBC;
	Tue, 31 Jan 2006 18:36:11 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 20610-09; Tue, 31 Jan 2006 18:36:11 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 23A61F5BA3;
	Tue, 31 Jan 2006 18:36:11 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0VHZxR2029305;
	Tue, 31 Jan 2006 18:36:01 +0100
Date:	Tue, 31 Jan 2006 17:36:13 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Johannes Stezenbach <js@linuxtv.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
In-Reply-To: <20060131171508.GB6341@linuxtv.org>
Message-ID: <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
References: <20060131171508.GB6341@linuxtv.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1263/Tue Jan 31 15:48:20 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10257
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 31 Jan 2006, Johannes Stezenbach wrote:

> I think (maybe in error ;-), that all binaries compiled for
> a 32bit ABI, but a 64bit ISA, have this flag set, as the kernel
> will refuse to execute 64bt code (i.e. not o32 or n32 ABI). Therefore,
> shouldn't gdb also evaluate this flag when deciding about the ISA
> register size?

 O32 implies 32-bit registers no matter what ISA is specified (while 
o32/MIPS-III is effectively o32/MIPS-II, o32/MIPS-IV makes a difference), 
therefore it's a bug.  You should try sending your proposal to 
<gdb-patches@sources.redhat.com> instead.  But I smell the problem is 
elsewhere -- mips_isa_regsize() shouldn't be called for the "cooked" 
registers and these are ones you should only see under Linux or, as a 
matter of fact, any hosted environment.  See mips_register_type() for a 
start.

  Maciej
