Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Jan 2006 15:00:18 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:33286 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133421AbWA0PAB (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Jan 2006 15:00:01 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 47404F59F6;
	Fri, 27 Jan 2006 16:04:32 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 14547-03; Fri, 27 Jan 2006 16:04:32 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id ED114F59E7;
	Fri, 27 Jan 2006 16:04:31 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k0RF4MpK019968;
	Fri, 27 Jan 2006 16:04:22 +0100
Date:	Fri, 27 Jan 2006 15:04:34 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Nigel Stephens <nigel@mips.com>,
	"Kevin D. Kissell" <kevink@mips.com>, linux-mips@linux-mips.org
Subject: Re: [RFC] Optimize swab operations on mips_r2 cpu
In-Reply-To: <cda58cb80601270654jf779622w@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0601271501030.12202@blysk.ds.pg.gda.pl>
References: <cda58cb80601250136p5ee350e6g@mail.gmail.com> 
 <cda58cb80601260702wf781e70l@mail.gmail.com>  <005101c6228c$6ebfb0a0$10eca8c0@grendel>
 <43D8F000.9010106@mips.com>  <cda58cb80601260831i61167787g@mail.gmail.com>
  <43D8FF16.40107@mips.com>  <cda58cb80601261002w6eb02249k@mail.gmail.com> 
 <43D93025.9040800@mips.com>  <cda58cb80601270103t1419117cq@mail.gmail.com>
  <43DA240F.5070301@mips.com> <cda58cb80601270654jf779622w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1253/Fri Jan 27 11:10:20 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 27 Jan 2006, Franck wrote:

> To use -march=4ksd, you need to tell to the building process that
> you're using a 4KSD cpu. The only way to do that is to define a new
> CPU_4KSD. But, if I understood mips configuration script, you cannot
> define CPU_4KSD _and_ CPU_MIPS32R2 at the same time; at least easily.

 You may still specify "-mtune=4ksd" at the command line.  This option is 
not going to be overridden as it's nowhere used in Makefiles.

  Maciej
