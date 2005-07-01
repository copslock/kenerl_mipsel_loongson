Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 Jul 2005 09:38:55 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:29453 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8226127AbVGAIik>; Fri, 1 Jul 2005 09:38:40 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 41EDDE1C8A; Fri,  1 Jul 2005 10:38:27 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 07433-05; Fri,  1 Jul 2005 10:38:27 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 1A9C3E1C78; Fri,  1 Jul 2005 10:38:27 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.3/8.13.1) with ESMTP id j618cS6l008448;
	Fri, 1 Jul 2005 10:38:29 +0200
Date:	Fri, 1 Jul 2005 09:38:31 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Fabrizio Fazzino <fabrizio@fazzino.it>
Cc:	linux-mips@linux-mips.org
Subject: Re: Assembly macro with parameters
In-Reply-To: <42C429C3.2090905@fazzino.it>
Message-ID: <Pine.LNX.4.61L.0507010927130.30138@blysk.ds.pg.gda.pl>
References: <425573AD.9010702@fazzino.it> <20050407182549.GA24235@linux-mips.org>
 <4256B5BE.8070708@fazzino.it> <20050408165717.GA8157@nevyn.them.org>
 <42C429C3.2090905@fazzino.it>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.85.1/962/Fri Jul  1 07:19:05 2005 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8289
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Jun 2005, Fabrizio Fazzino wrote:

> Daniel suggested using .word and writing the function by hand,
> but which is the syntax I have to use?
> 
> #define myopcode(rs,rt,rd) { \
> int opcode_number = 0xC4000000 | (rs<<21) | (rt<<16) | (rd<<11); \
> char opcode_string[20]; \
> sprintf(opcode_string, ".word 0x%X", opcode_number); \
> asm(opcode_string); \
> }

 This is untested, but it should be a reasonable starting point:

#define myopcode(rs,rt,rd) do { \
	int opcode_number = 0xC4000000 | (rs<<21) | (rt<<16) | (rd<<11); \
	asm(".word %0" : : "i" (opcode_number)); \
} while (0)

But you may want to add code to tell GCC that these registers are used and 
how, because otherwise you may have little use of your macro.  You'll 
probably have to investigate the explicit register variable GCC feature 
and cpp stringification.  It should be straightforward though rather 
boring, so I'm leaving it as an exercise.

  Maciej
