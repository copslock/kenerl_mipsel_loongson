Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 21 Sep 2007 17:08:46 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:19401 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20025958AbXIUQIo (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 21 Sep 2007 17:08:44 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l8LG8h2p027592;
	Fri, 21 Sep 2007 17:08:43 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l8LG8hkm027591;
	Fri, 21 Sep 2007 17:08:43 +0100
Date:	Fri, 21 Sep 2007 17:08:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Winson Yung <winson.yung@gmail.com>
Cc:	linux-mips@linux-mips.org
Subject: Re: branch delay slot
Message-ID: <20070921160843.GA21458@linux-mips.org>
References: <48413e3e0709210901g38e41164pf068f907596ebfeb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48413e3e0709210901g38e41164pf068f907596ebfeb@mail.gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16633
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Sep 21, 2007 at 09:01:15AM -0700, Winson Yung wrote:

> Hi there, in the following mips 32bit atomic cmp_xchg api, I was
> wondering why there is no nop after the two branch instructions. Does
> this introduce a bug, or is it a "feature" in the code to use the
> delay slot for an instructino to execut something whether or not they
> take the branch.
> 
> #define __arch_compare_and_exchange_xxx_32_int(mem, newval, oldval, rel, acq) \

Manual filling of the delay slot is only required when the assembler is
in .set noreorder mode.  Otherwise - and that's the default mode - it will
try do something sensible with the delay slot itself.

  Ralf
