Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Aug 2002 12:40:46 +0200 (CEST)
Received: from delta.ds2.pg.gda.pl ([213.192.72.1]:37266 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S1122959AbSHWKkp>; Fri, 23 Aug 2002 12:40:45 +0200
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id MAA16129;
	Fri, 23 Aug 2002 12:41:10 +0200 (MET DST)
Date: Fri, 23 Aug 2002 12:41:09 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
cc: linux-mips@linux-mips.org
Subject: Re: CVS Update@oss.sgi.com: linux
In-Reply-To: <20020823101310.GN12007@lug-owl.de>
Message-ID: <Pine.GSO.3.96.1020823122254.14127E-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
Content-Transfer-Encoding: 8bit
X-archive-position: 3
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips


On Fri, 23 Aug 2002, Jan-Benedict Glaw wrote:

> > Modified files:
> > 	drivers/scsi   : Tag: linux_2_4 dec_esp.c 
> > 	include/asm-mips: Tag: linux_2_4 scatterlist.h 
> > 	include/asm-mips64: Tag: linux_2_4 scatterlist.h 
> > 
> > Log message:
> > 	More mmu_sglist and dec_esp.c fixes, sigh...
> 
> Cool. Fixed now. I had send a similar patch around about a week or two
> ago on whitch Karsten and I had worked on. Nobody responded, nobody

 I've seen the report.  Since changes involved trivial string
substitutions and your patch worked for you I have considered it obvious
enough not to add any comments.  I apologize if you have found this
annoying. 

 I've done the changes a bit differently to keep the obsolete mmu_sglist
interface unchanged -- it was my fault it got changed by an accident. 

> checked it in... Not to talk about the R4600 issues...

 Hmm, haven't you got my suggestions?  I hope they were clear, at least
nobody complained.  If you'd like to test an ll/sc variant, I may try to
provide you some aid if needed.  Also, have you contacted IDT? 

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
