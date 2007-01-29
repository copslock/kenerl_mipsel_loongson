Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 18:33:33 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:42756 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038660AbXA2Sd2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 18:33:28 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9316BE1C98;
	Mon, 29 Jan 2007 19:32:41 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7rB21CgQVCyl; Mon, 29 Jan 2007 19:32:41 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 10E30E1C95;
	Mon, 29 Jan 2007 19:32:41 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0TIWtu2004090;
	Mon, 29 Jan 2007 19:32:56 +0100
Date:	Mon, 29 Jan 2007 18:32:48 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	vagabon.xyz@gmail.com, dan@debian.org, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0701291829280.26916@blysk.ds.pg.gda.pl>
References: <20070128180807.GA18890@nevyn.them.org>
 <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
 <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
 <20070130.011442.21365159.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2500/Mon Jan 29 10:43:16 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Jan 2007, Atsushi Nemoto wrote:

> >  Well, the option used to select between 64-bit and 32-bit ELF for 
> > building 64-bit configurations.  I can see it has been changed from its 
> > original meaning and it now only controls whether "-mno-explicit-relocs" 
> > is passed to the compiler or not, which is sort of useless and certainly 
> > does not match the intent nor what the description says.  The 64-bit 
> > format is now used unconditionally and you can always pass such obscure 
> > options to the compiler on the make's command line, so instead of this fix 
> > I vote for complete removal of the BUILD_ELF64 option.
> 
> Though I do not know much about -mno-explicit-relocs,
> CONFIG_BUILD_ELF64 controls -msym32 option and this is the reason of
> the tweak in __pa_page_offset().

 I missed this bit, sorry.  Then the original note applies -- the setting 
of BUILD_ELF64 is whatever suits one building the kernel the best.  And 
certainly for binaries built to run from CKSEG0 either value of 
BUILD_ELF64 is reasonable.

  Maciej
