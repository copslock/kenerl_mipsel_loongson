Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Oct 2005 18:11:38 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:18955 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S8133474AbVJDRLV (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 4 Oct 2005 18:11:21 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id D3000F5A0A; Tue,  4 Oct 2005 19:11:11 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 12281-05; Tue,  4 Oct 2005 19:11:11 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 8E92CE1C7D; Tue,  4 Oct 2005 19:11:11 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j94HBG22016592;
	Tue, 4 Oct 2005 19:11:16 +0200
Date:	Tue, 4 Oct 2005 18:11:26 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Franck <vagabon.xyz@gmail.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Add support for 4KS cpu.
In-Reply-To: <cda58cb80510040810y286b06bcx@mail.gmail.com>
Message-ID: <Pine.LNX.4.61L.0510041752160.10696@blysk.ds.pg.gda.pl>
References: <cda58cb80510040149p690397afo@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041219500.10696@blysk.ds.pg.gda.pl> 
 <cda58cb80510040610k1a7f430fn@mail.gmail.com> 
 <Pine.LNX.4.61L.0510041430120.10696@blysk.ds.pg.gda.pl>
 <cda58cb80510040810y286b06bcx@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.86.2/1109/Tue Oct  4 00:06:28 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 9139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 4 Oct 2005, Franck wrote:

> >  See my other comment in this thread.  As to the SmartMIPS/crypto
> > instructions -- unless they are going to be emitted by GCC for the kernel
> > build (which I seriously doubt), there is no point in enabling them.
> 
> some assembly code could...

 In which case it has to be specific to the configuration used anyway and 
may just locally enable whatever instructions are needed (".set 
smartmips", etc.) and be enabled itself based on configuration, either at 
the run time, if possible and reasonable, or using a CONFIG_* option.

> hmm, I'm not an expert in MIPS cpu as you guys, so can you give me an
> example of others processors that have such TLB features ?

 Well, the extensions are a part of the SmartMIPS ASE, so they are 
certainly not bound to any particular CPU type.

  Maciej
