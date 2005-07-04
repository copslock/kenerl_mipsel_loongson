Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Jul 2005 13:12:50 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:32529 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226154AbVGDMMd>; Mon, 4 Jul 2005 13:12:33 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id E0C0FF599D; Mon,  4 Jul 2005 14:12:39 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 22610-03; Mon,  4 Jul 2005 14:12:39 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id B0C97F5969; Mon,  4 Jul 2005 14:12:39 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j64CCh0V025438;
	Mon, 4 Jul 2005 14:12:43 +0200
Date:	Mon, 4 Jul 2005 13:12:48 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
In-Reply-To: <42C7BE64.7020102@fazzino.it>
Message-ID: <Pine.LNX.4.61L.0507041306440.32001@blysk.ds.pg.gda.pl>
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org>
 <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org>
 <42C429C3.2090905@fazzino.it> <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl>
 <42C7BE64.7020102@fazzino.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/965/Sun Jul  3 21:23:29 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8341
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sun, 3 Jul 2005, Fabrizio Fazzino wrote:

> By the way, is there any quick way of writing a setreg(reg_num,reg_val)
> C macro to set the value of a register?

 It would make no sense as GCC would still be free to use this register
for something else, therefore either destroying your "explicitly" assigned 
data or getting data already there destroyed.  You are really after asm 
constraints and explicit register variables as outlined in my previous 
response.  See GCC documentation for how to make use of these.

 BTW, how about adding support for opcodes you are interested in to 
binutils instead?  It would make interfacing them to GCC much easier.

  Maciej
