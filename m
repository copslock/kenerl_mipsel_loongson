Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Feb 2004 12:32:03 +0000 (GMT)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:14866 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225322AbUBVMcA>;
	Sun, 22 Feb 2004 12:32:00 +0000
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1Ausg9-0007Qi-00; Sun, 22 Feb 2004 12:25:49 +0000
Received: from olympia.mips.com ([192.168.192.128] helo=doms-laptop.algor.co.uk)
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1Auslm-0003F7-00; Sun, 22 Feb 2004 12:31:38 +0000
From:	Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16440.41255.372780.360154@doms-laptop.algor.co.uk>
Date:	Sun, 22 Feb 2004 12:31:35 +0000
To:	"Mark and Janice Juszczec" <juszczec@hotmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: r3000 instruction set
In-Reply-To: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
References: <Law10-F39hgbi1Kigvf000046ac@hotmail.com>
X-Mailer: VM 7.07 under 21.4 (patch 10) "Military Intelligence (RC5 Windows)" XEmacs Lucid
X-MTUK-Scanner:	Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.84, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4397
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Mark and Janice Juszczec (juszczec@hotmail.com) writes:

> I'm working with kaffe on a r3912 cpu. I'm getting an illegal instruction
> error. I disassembled the kaffe binary and thought I'd find the offending
> instruction.

Two suggestions, to make a hat-trick of responses from MIPS.  "See
MIPS Run" (I'm too modest to mention the author's name) has a pretty
accurate list of instructions covering R3000 and 39xx derivatives.

Any reasonable GNU assembler knows all the instructions there ever
were - and if you look at the table in mips-opc.c, fairly accurately
attributed to various instruction set definitions and extensions.

--
Dominic Sweetman
MIPS Technologies.
