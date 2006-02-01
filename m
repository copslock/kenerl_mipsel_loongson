Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Feb 2006 16:49:09 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:22033 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S3458481AbWBAQsw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 1 Feb 2006 16:48:52 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 7FE06F59F6;
	Wed,  1 Feb 2006 17:53:53 +0100 (CET)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07299-01; Wed,  1 Feb 2006 17:53:53 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 37487E1CAE;
	Wed,  1 Feb 2006 17:53:53 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id k11Grfx3028924;
	Wed, 1 Feb 2006 17:53:41 +0100
Date:	Wed, 1 Feb 2006 16:53:55 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
Cc:	Johannes Stezenbach <js@linuxtv.org>, linux-mips@linux-mips.org
Subject: Re: gdb vs. gdbserver with -mips3 / 32bitmode userspace
In-Reply-To: <20060201164423.GA4891@nevyn.them.org>
Message-ID: <Pine.LNX.4.64N.0602011649430.6677@blysk.ds.pg.gda.pl>
References: <20060131171508.GB6341@linuxtv.org>
 <Pine.LNX.4.64N.0601311724340.31371@blysk.ds.pg.gda.pl>
 <20060201164423.GA4891@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.87.1/1264/Wed Feb  1 13:38:31 2006 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 10286
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, 1 Feb 2006, Daniel Jacobowitz wrote:

> All of this code is flat-out wrong, as far as I'm concerned.  I have a
> project underway which will fix it, as a nice side effect.

 Great!.

> GDB is trying to do something confusing, but admirable, here.  When
> you're running on a 64-bit system the full 64 bits are always there:
> even if the binary only uses half of them (is this true in Linux?  I
> don't remember if the relevant control bits get fudged, it's been a
> while; it's definitely true on some other systems).  Thus it's possible
> for a bogus instruction to corrupt the top half of a register, leading
> to otherwise inexplicable problems.

 Well, cp0.status.ux is always set with a 64-bit kernel.  It is not with a 
32-bit one.  A binary marked as o32/MIPS-III will work with either as long 
as 64-bit operations are not used.  For implementations that provide the 
cp0.status.xx bit, it is always set so that at least 32-bit MIPS-IV 
instructions work.

  Maciej
