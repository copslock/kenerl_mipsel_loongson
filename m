Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Oct 2007 20:54:13 +0100 (BST)
Received: from relay01.mx.bawue.net ([193.7.176.67]:51157 "EHLO
	relay01.mx.bawue.net") by ftp.linux-mips.org with ESMTP
	id S20035442AbXJNTyE (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 14 Oct 2007 20:54:04 +0100
Received: from lagash (88-106-176-50.dynamic.dsl.as9105.com [88.106.176.50])
	by relay01.mx.bawue.net (Postfix) with ESMTP id 5D21648BCB;
	Sun, 14 Oct 2007 21:52:40 +0200 (CEST)
Received: from ths by lagash with local (Exim 4.67)
	(envelope-from <ths@networkno.de>)
	id 1Ih9Wf-0008WU-5t; Sun, 14 Oct 2007 20:53:25 +0100
Date:	Sun, 14 Oct 2007 20:53:25 +0100
From:	Thiemo Seufer <ths@networkno.de>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	"Maciej W. Rozycki" <macro@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] mm/pg-r4k.c: Dump the generated code
Message-ID: <20071014195324.GT3379@networkno.de>
References: <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <Pine.LNX.4.64N.0710041616570.10573@blysk.ds.pg.gda.pl> <4705EFE5.7090704@gmail.com> <Pine.LNX.4.64N.0710051312490.17849@blysk.ds.pg.gda.pl> <470A4349.9090301@gmail.com> <Pine.LNX.4.64N.0710081611460.8873@blysk.ds.pg.gda.pl> <470BE1F4.3070800@gmail.com> <Pine.LNX.4.64N.0710101231290.9821@blysk.ds.pg.gda.pl> <47126EDC.1060305@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <47126EDC.1060305@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-11)
Return-Path: <ths@networkno.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17025
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ths@networkno.de
Precedence: bulk
X-list: linux-mips

Franck Bui-Huu wrote:
> Maciej W. Rozycki wrote:
> > On Tue, 9 Oct 2007, Franck Bui-Huu wrote:
> > 
> >>>  What would be the gain for the kernel from using "-march=4ksd" rather 
> >>> than "-march=mips32r2"?
> >>>
> >> It actually results in a kernel image ~30kbytes smaller for the former
> >> case. It has been discussed sometimes ago on this list. I'm sorry but
> >> I don't know why...
> > 
> >  Perhaps the pipeline description for the 4KSd CPU is different from the 
> > default for the MIPS32r2 ISA.  Barring a study of GCC sources, if that 
> > really troubles you, you could build the same version of the kernel with 
> > these options:
> > 
> > 1. "-march=mips32r2"
> > 
> > 2. "-march=4ksd"
> > 
> > 3. "-march=mips32r2 -mtune=4ksd"
> > 
> > and compare the results.  I expect the results of #2 and #3 to be the same 
> > and it would just back up my suggestion about keeping CPU-specific 
> > optimisations separate from the CPU selection.
> 
> I think you misunderstood me, my own fault: the kernel was smaller
> with "-march=4ksd". It was bigger when using "-march=mips32r2 -smartmips".

Could you check what "-march=mips32r2 -smartmips -mtune=4ksd" does?
I expect it to have the same result than "-march=4ksd".


Thiemo
