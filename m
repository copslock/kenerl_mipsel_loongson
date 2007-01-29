Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 18:47:56 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:43532 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038672AbXA2Srv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 18:47:51 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 963B3E1C99;
	Mon, 29 Jan 2007 19:47:04 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FeMhrNKi6vjh; Mon, 29 Jan 2007 19:47:04 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 26028E1C95;
	Mon, 29 Jan 2007 19:47:04 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0TIlJrh012959;
	Mon, 29 Jan 2007 19:47:19 +0100
Date:	Mon, 29 Jan 2007 18:47:12 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Daniel Jacobowitz <dan@debian.org>
cc:	Franck Bui-Huu <vagabon.xyz@gmail.com>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <20070129161450.GA3384@nevyn.them.org>
Message-ID: <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
References: <20070128180807.GA18890@nevyn.them.org>
 <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
 <20070129155253.GA2070@nevyn.them.org> <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
 <20070129161450.GA3384@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2500/Mon Jan 29 10:43:16 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13849
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Daniel,

> > Surely because none of them define CONFIG_BUILD_ELF64:
> 
> Huh - you're right, it must just be living in my local .config since
> back when it meant something different.

 It looks like the meaning is still the same (although the note about 
binutils versions supported needs be adjusted) and you are free to change 
what's provided by a default configuration to whatever you like.

 I have BUILD_ELF64 enabled for my SWARM configuration and I do not plan 
to change it.  If there is a bug in the definition of __pa_page_offset() 
for such a setup it should be fixed indeed.

 Also "-mno-explicit-relocs" was only required with the old hack to 
truncate addresses at the assembly level -- where "-mabi=64 -Wa,-mabi=32" 
was used.  The option should go now, yielding a small code size 
improvement for inline assembly, where the "R" constraint is used.

  Maciej
