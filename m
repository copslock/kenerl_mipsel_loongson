Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 30 Jan 2007 17:33:50 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:49935 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038516AbXA3Rdp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 30 Jan 2007 17:33:45 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 1EA42E1CB1;
	Tue, 30 Jan 2007 18:32:59 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AzLVfFUBAnhU; Tue, 30 Jan 2007 18:32:58 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 83AB4E1CA1;
	Tue, 30 Jan 2007 18:32:58 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l0UHX9ac008968;
	Tue, 30 Jan 2007 18:33:09 +0100
Date:	Tue, 30 Jan 2007 17:33:02 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
cc:	dan@debian.org, vagabon.xyz@gmail.com, linux-mips@linux-mips.org,
	ralf@linux-mips.org
Subject: Re: RFC: Sentosa boot fix
In-Reply-To: <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
Message-ID: <Pine.LNX.4.64N.0701301713350.9231@blysk.ds.pg.gda.pl>
References: <cda58cb80701290806p5d68ba5ck5e3e3b2b3490126f@mail.gmail.com>
 <20070129161450.GA3384@nevyn.them.org> <Pine.LNX.4.64N.0701291833480.26916@blysk.ds.pg.gda.pl>
 <20070130.234537.126574565.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2505/Tue Jan 30 11:40:21 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 30 Jan 2007, Atsushi Nemoto wrote:

> Though I do not object to remove "&& !defined(CONFIG_BUILD_ELF64)"
> from __pa_page_offset(), are there any point of CONFIG_BUILD_ELF64=y
> if your load address was CKSEG0?

 Checking for code correctness and validation of the toolchain (Linux is 
one of the few non-PIC users of (n)64) without having to chase hardware 
that would support running from XPHYS without serious pain (the firmware 
being the usual offender).

 That said, I have not checked the every single use of __pa_page_offset(), 
but the sole existence of this condition raises a question about whether 
we are sure __pa_page_offset() is going to be only used on virtual 
addresses in the same segment the kernel is linked to.  Sometimes 
references to both CKSEG0 and XPHYS may be used in the same kernel, e.g. 
because the the kernel is linked to XPHYS, but the firmware is limited to 
accept CKSEG0 addresses only (and we do call back into firmware on some 
platforms).

  Maciej
