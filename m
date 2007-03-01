Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2007 18:56:13 +0000 (GMT)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:40709 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20039439AbXCAS4I (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 1 Mar 2007 18:56:08 +0000
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 5C146E1CCD;
	Thu,  1 Mar 2007 19:55:23 +0100 (CET)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QkHssIO0Ez2m; Thu,  1 Mar 2007 19:55:23 +0100 (CET)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id E8D1BE1C69;
	Thu,  1 Mar 2007 19:55:22 +0100 (CET)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l21Itbkh008692;
	Thu, 1 Mar 2007 19:55:37 +0100
Date:	Thu, 1 Mar 2007 18:55:30 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] Untangle the rest of the prom_printf mess and convert to
 early printk
In-Reply-To: <S20039493AbXCASgj/20070301183639Z+38846@ftp.linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0703011853230.25556@blysk.ds.pg.gda.pl>
References: <S20039493AbXCASgj/20070301183639Z+38846@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90/2690/Thu Mar  1 12:11:27 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 1 Mar 2007, linux-mips@linux-mips.org wrote:

>  arch/mips/dec/prom/console.c             |   38 +--------

 Any particular reason for replacing an optimised version with this 
miserable contraption?

  Maciej
