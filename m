Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Jul 2005 16:29:25 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:39948 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226642AbVGLP3J>; Tue, 12 Jul 2005 16:29:09 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 9307BE1C85
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 17:30:05 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 31920-05 for <linux-mips@linux-mips.org>;
 Tue, 12 Jul 2005 17:30:05 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id F0BFDE1C84
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 17:30:04 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j6CFU7x1015406
	for <linux-mips@linux-mips.org>; Tue, 12 Jul 2005 17:30:07 +0200
Date:	Tue, 12 Jul 2005 16:30:17 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: CVS Update@linux-mips.org: linux
In-Reply-To: <20050712145438Z8226641-3678+2759@linux-mips.org>
Message-ID: <Pine.LNX.4.61L.0507121626370.14155@blysk.ds.pg.gda.pl>
References: <20050712145438Z8226641-3678+2759@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8461
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 12 Jul 2005 ralf@linux-mips.org wrote:

> Modified files:
> 	include/asm-mips: interrupt.h 
> 
> Log message:
> 	Use ei / di MIPS32 R2 instructions if available.

 Are you sure you don't want something like:

	andi	$1, \\flags, 1
	beqz    $1, 1f                                     
	 di                                                     
	ei                                                      
1:                                                             

instead for local_irq_restore?

  Maciej
