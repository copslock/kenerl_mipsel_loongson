Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Mar 2004 09:35:52 +0100 (BST)
Received: from alg145.algor.co.uk ([IPv6:::ffff:62.254.210.145]:49681 "EHLO
	dmz.algor.co.uk") by linux-mips.org with ESMTP id <S8225074AbUCaIfv>;
	Wed, 31 Mar 2004 09:35:51 +0100
Received: from alg158.algor.co.uk ([62.254.210.158] helo=olympia.mips.com)
	by dmz.algor.co.uk with esmtp (Exim 3.35 #1 (Debian))
	id 1B8b55-0005c9-00; Wed, 31 Mar 2004 09:28:15 +0100
Received: from arsenal.mips.com ([192.168.192.197])
	by olympia.mips.com with esmtp (Exim 3.36 #1 (Debian))
	id 1B8bBx-00032b-00; Wed, 31 Mar 2004 09:35:21 +0100
Received: from dom by arsenal.mips.com with local (Exim 3.35 #1 (Debian))
	id 1B8bBx-0000uN-00; Wed, 31 Mar 2004 09:35:21 +0100
From: Dominic Sweetman <dom@mips.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16490.33481.5505.705679@arsenal.mips.com>
Date: Wed, 31 Mar 2004 09:35:21 +0100
To: "Lijun Chen" <chenli@nortelnetworks.com>
Cc: linux-mips@linux-mips.org
Subject: Re: exception priority for BCM1250
In-Reply-To: <4069F90D.9060903@americasm01.nt.com>
References: <4069F90D.9060903@americasm01.nt.com>
X-Mailer: VM 7.03 under 21.4 (patch 6) "Common Lisp" XEmacs Lucid
X-MTUK-Scanner: Found to be clean
X-MTUK-SpamCheck: not spam, SpamAssassin (score=-4.849, required 4, AWL,
	BAYES_00)
Return-Path: <dom@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4707
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dom@mips.com
Precedence: bulk
X-list: linux-mips


Lijun,

> Does anybody know which mips family SB1 core on bcm1250 falls into?
> It is a MIPS64 processor

Yes, it complies to the MIPS64 Architecture specification...

> ... does it belong to 5K family or 20Kc?

Neither one.  5K and 20Kc are specific core CPUs licensed by MIPS
Technologies.  Broadcom have an "architecture license" and design
their own compatible MIPS64 CPUs, like the BCM1250.

> What about the exception priorities, such as cache error exception,
> bus error exception, and so on? Are they maskable or non-maskable? 

Other than interrupts, only a few obscure exception conditions are
maskable. 

Ralf was sensible to suggest you back off to the architecture manuals,
which talk about all MIPS CPUs.  You might also like to read a book
(like my "See MIPS Run").

> Further to my last email, another question is if multiple
> simultaneous exceptions occur, or kernel is handling an exception,
> another exception occurs, how linux handles this?

As always, that depends what you mean by "handling".

At the lowest level, the CPU:

o If ever confronted by multiple possible exceptions at the same time,
  picks the highest priority one which affects the oldest instruction
  in the pipeline...

o When it takes the exception and vectors into the kernel exception
  handler, it atomically sets the register bit SR[EXL] ("exception
  mode").  In this mode interrupts are disabled.  The kernel code
  should be careful not to cause an exception.

Read the book, is my advice.

Of course Linux goes on from the low-level exception handler to call
other kernel functions which you might regard as "handlers" too -
interrupt routines, for example.  In many cases these OS "handlers"
are run with SR[EXL] set to zero, making it possible to handle new
machine-level exceptions...  

But that's complicated.

--
Dominic Sweetman
MIPS Technologies
