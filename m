Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Feb 2007 18:21:22 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:10502 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20038453AbXBFSVR (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 6 Feb 2007 18:21:17 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id B5CDEE1CA0;
	Tue,  6 Feb 2007 19:20:31 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hA1F6ShoORnV; Tue,  6 Feb 2007 19:20:31 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 58003E1C84;
	Tue,  6 Feb 2007 19:20:31 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l16IKiU4022676;
	Tue, 6 Feb 2007 19:20:44 +0100
Date:	Tue, 6 Feb 2007 18:20:39 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Yoichi Yuasa <yoichi_yuasa@tripeaks.co.jp>,
	linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH][MIPS] fix run_uncached warning about 32bit kernel
In-Reply-To: <20070206152817.GB5660@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0702061818550.28283@blysk.ds.pg.gda.pl>
References: <200702060159.l161xM59075711@mbox33.po.2iij.net>
 <20070206152817.GB5660@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.88.7/2527/Tue Feb  6 11:14:46 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 6 Feb 2007, Ralf Baechle wrote:

> On Tue, Feb 06, 2007 at 10:59:22AM +0900, Yoichi Yuasa wrote:
> 
> > arch/mips/lib/uncached.c: In function 'run_uncached':
> > arch/mips/lib/uncached.c:47: warning: comparison is always true due to limited range of data type
> > arch/mips/lib/uncached.c:48: warning: comparison is always false due to limited range of data type
> > arch/mips/lib/uncached.c:57: warning: comparison is always true due to limited range of data type
> > arch/mips/lib/uncached.c:58: warning: comparison is always false due to limited range of data type
> 
> Thanks, applied.

 "Fixing" bugs in the compiler, huh? ;-)  I suppose there should be a note 
somewhere nearby then, so there is a remote chance to remove the clutter 
in the future.

  Maciej
