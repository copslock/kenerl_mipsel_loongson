Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 10 Jul 2007 14:07:54 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([153.19.208.7]:47121 "EHLO
	pollux.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20021456AbXGJNHw (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 10 Jul 2007 14:07:52 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 703C2E1CB5
	for <linux-mips@linux-mips.org>; Tue, 10 Jul 2007 15:07:18 +0200 (CEST)
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
	by localhost (pollux.ds.pg.gda.pl [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zRqLfRHbKWtv for <linux-mips@linux-mips.org>;
	Tue, 10 Jul 2007 15:07:18 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP id 28E50E1C65
	for <linux-mips@linux-mips.org>; Tue, 10 Jul 2007 15:07:18 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l6AD7NWn016252
	for <linux-mips@linux-mips.org>; Tue, 10 Jul 2007 15:07:23 +0200
Date:	Tue, 10 Jul 2007 14:07:21 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	linux-mips@linux-mips.org
Subject: Re: [MIPS] DEC: Fix modpost warning.
In-Reply-To: <S20022577AbXGJLug/20070710115036Z+13637@ftp.linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0707101401001.18036@blysk.ds.pg.gda.pl>
References: <S20022577AbXGJLug/20070710115036Z+13637@ftp.linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.90.3/3620/Tue Jul 10 03:30:39 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 15665
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, 10 Jul 2007, linux-mips@linux-mips.org wrote:

>   LD      vmlinux
>   SYSMAP  System.map
>   SYSMAP  .tmp_System.map
>   MODPOST vmlinux
> WARNING: drivers/built-in.o(.data+0x2480): Section mismatch: reference to .init.text: (between 'sercons' and 'ds_parms')
> 
> Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
> 
> ---
> 
>  drivers/tc/zs.c |    6 +++---
>  1 files changed, 3 insertions(+), 3 deletions(-)

 It looks like a bogus warning -- I presume it comes from a reference from 
"sercons" to serial_console_setup() -- but the driver is going away, so I 
could not care less...

  Maciej
