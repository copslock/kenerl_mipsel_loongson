Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 16 Jul 2004 16:14:10 +0100 (BST)
Received: from jurand.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.2]:57558 "EHLO
	jurand.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225002AbUGPPOF>; Fri, 16 Jul 2004 16:14:05 +0100
Received: by jurand.ds.pg.gda.pl (Postfix, from userid 1011)
	id DB5A747392; Fri, 16 Jul 2004 17:13:59 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by jurand.ds.pg.gda.pl (Postfix) with ESMTP
	id CAACA36DB2; Fri, 16 Jul 2004 17:13:59 +0200 (CEST)
Date: Fri, 16 Jul 2004 17:13:59 +0200 (CEST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
Cc: linux-mips@linux-mips.org
Subject: Re: Help with MOP network boot install on DECstation 5000/240
In-Reply-To: <20040716150414.GB2019@lug-owl.de>
Message-ID: <Pine.LNX.4.55.0407161709130.6227@jurand.ds.pg.gda.pl>
References: <BAY2-F21njXXBARdkfw0003b0c8@hotmail.com> <20040710100412.GA23624@linux-mips.org>
 <00ba01c46823$3729b200$0deca8c0@Ulysses> <20040713003317.GA26715@linux-mips.org>
 <000701c468ae$141c3e50$0a9913ac@swift> <20040713080320.GC18841@lug-owl.de>
 <000e01c4696f$f65cf4f0$0a9913ac@swift> <20040714124318.GQ2019@lug-owl.de>
 <000c01c46b42$fd6f9b60$0a9913ac@swift> <20040716150414.GB2019@lug-owl.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5492
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 16 Jul 2004, Jan-Benedict Glaw wrote:

> > Does mopd work with a.out files? I read somewhere it doesn't. Is this the
> 
> Depends on your mopd:) There are several mopds around...

 I don't think any version supports MIPS ECOFF.  COFF and ECOFF are nasty
formats defined differently for different processors, so generic support,
similar to one for ELF, is impossible.  Just don't use ECOFF unless you
absolutely have to.

  Maciej
