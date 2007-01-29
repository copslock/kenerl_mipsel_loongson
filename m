Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 15:47:03 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:23311 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038614AbXA2Pq6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 29 Jan 2007 15:46:58 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 29FBCE1C95;
	Mon, 29 Jan 2007 16:46:15 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DffxLO5UqxxV; Mon, 29 Jan 2007 16:46:14 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id BD548E1C75;
	Mon, 29 Jan 2007 16:46:14 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0TFkQup029419;
	Mon, 29 Jan 2007 16:46:26 +0100
Date:	Mon, 29 Jan 2007 15:46:20 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
cc:	Daniel Jacobowitz <dan@debian.org>, linux-mips@linux-mips.org,
	ralf@linux-mips.org, Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
Message-ID: <Pine.LNX.4.64N.0701291527130.26916@blysk.ds.pg.gda.pl>
References: <20070128180807.GA18890@nevyn.them.org>
 <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2500/Mon Jan 29 10:43:16 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13840
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, 29 Jan 2007, Franck Bui-Huu wrote:

> > The problem is __pa_symbol(&_end); the kernel is linked at
> > 0xffffffff80xxxxxx, so subtracting a PAGE_OFFSET of 0xa800000000000000
> > does not do anything useful to this address at all.
> >
> 
> In my understanding, if your kernel is linked at 0xffffffff80xxxxxx,
> you shouldn't have CONFIG_BUILD_ELF64 set.

 Well, the option used to select between 64-bit and 32-bit ELF for 
building 64-bit configurations.  I can see it has been changed from its 
original meaning and it now only controls whether "-mno-explicit-relocs" 
is passed to the compiler or not, which is sort of useless and certainly 
does not match the intent nor what the description says.  The 64-bit 
format is now used unconditionally and you can always pass such obscure 
options to the compiler on the make's command line, so instead of this fix 
I vote for complete removal of the BUILD_ELF64 option.

  Maciej
