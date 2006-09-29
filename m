Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Sep 2006 11:06:19 +0100 (BST)
Received: from ip-217-204-115-127.easynet.co.uk ([217.204.115.127]:24068 "EHLO
	apollo.linkchoose.co.uk") by ftp.linux-mips.org with ESMTP
	id S20038526AbWI2KGS (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 29 Sep 2006 11:06:18 +0100
Received: from [10.98.1.127] (helo=galaxy.dga.co.uk)
	by apollo.linkchoose.co.uk with esmtp (Exim 4.60)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GTFGN-0004na-CM
	for linux-mips@linux-mips.org; Fri, 29 Sep 2006 11:06:35 +0100
Received: from [10.0.1.63]
	by galaxy.dga.co.uk with esmtp (Exim 4.62)
	(envelope-from <david.goodenough@linkchoose.co.uk>)
	id 1GTFFr-0006kF-1F
	for linux-mips@linux-mips.org; Fri, 29 Sep 2006 11:06:04 +0100
From:	David Goodenough <david.goodenough@linkchoose.co.uk>
Organization: Linkchoose Ltd
To:	linux-mips@linux-mips.org
Subject: Problem with THREAD_SIZE_ORDER being undefined
Date:	Fri, 29 Sep 2006 11:06:01 +0100
User-Agent: KMail/1.9.4
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609291106.03055.david.goodenough@linkchoose.co.uk>
Return-Path: <david.goodenough@linkchoose.co.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12737
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.goodenough@linkchoose.co.uk
Precedence: bulk
X-list: linux-mips

Has anything changed in 2.6.17 from 2.6.15 with respect to 
THREAD_SIZE_ORDER and thread_info.h?

I have some patches for the Infineon ADM5120 which I am 
having difficulty compiling.  The very first thing it 
trys to build is arch/asm-mips/asm_offsets.c and this fails
saying that:-
include/linux/sched.h:1025: error: `THREAD_SIZE_ORDER' undeclared here (not in 
a function)

THREAD_SIZE_ORDER is defined in thread_info.h, and depends on various CONFIG
options, we have CONFIG_PAGE_SIZE_4K and CONFIG_32BIT both set to y which 
should set it properly, but the error message says it is not.

These patches used to compile, so my guess is that there has been a change
in the common code that the patches do not take account of.  Anyone got
any ideas?

Regards

David 
