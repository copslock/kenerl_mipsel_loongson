Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jul 2007 16:11:49 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:35088 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20024722AbXGPPLr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 16 Jul 2007 16:11:47 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E91DFE1CBB;
	Mon, 16 Jul 2007 17:11:43 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gGEcnFzwpPFA; Mon, 16 Jul 2007 17:11:43 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 8B840E1C63;
	Mon, 16 Jul 2007 17:11:43 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6GFBk6L017549;
	Mon, 16 Jul 2007 17:11:48 +0200
Date:	Mon, 16 Jul 2007 16:11:45 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Songmao Tian <tiansm@lemote.com>
cc:	LinuxBIOS Mailing List <linuxbios@linuxbios.org>,
	marc.jones@amd.com, linux-kernel@vger.kernel.org,
	linux-mips@linux-mips.org
Subject: Re: about cs5536 interrupt ack
In-Reply-To: <4695D78F.8010806@lemote.com>
Message-ID: <Pine.LNX.4.64N.0707161556560.15539@blysk.ds.pg.gda.pl>
References: <4694A495.1050006@lemote.com> <Pine.LNX.4.64N.0707111347360.26459@blysk.ds.pg.gda.pl>
 <4694F4EB.8040000@lemote.com> <Pine.LNX.4.64N.0707111634430.26459@blysk.ds.pg.gda.pl>
 <4695D78F.8010806@lemote.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91/3681/Mon Jul 16 15:16:18 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 12 Jul 2007, Songmao Tian wrote:

> 8259 problem  seems to be done with the attached patch, IDE hung seems to be
> the dma setting problem.
> 
> Thanks all for your advise, comments. I have learned a lot. now I continue to
> trace down the IDE problem.

 I would still recommend you to investigate the option of making the 8259A 
cores "transparent" and using the mapper registers to dispatch interrupts 
directly -- it would make processing of interrupt requests considerably 
faster and less complicated.  Please note that ffs() is O(1) and actually 
some two or three machine instructions on MIPS architecture processors and 
the model used by the mapper is closer to the spirit of how MIPS 
processors do interrupt handling.  With such an approach it will also 
likely be easier to integrate your changes upstream, than it would for 
your changes to i8259.{c,h} needed for your unusual setup to work.

 Of course as an intermediate solution during development to make the 
whole thing work the complicated use of the 8259A cores may be justified.

  Maciej
