Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Oct 2007 13:25:47 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:20922 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20022065AbXJEMZp (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Oct 2007 13:25:45 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l95CPiLF022536;
	Fri, 5 Oct 2007 13:25:44 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l95CPhtd022535;
	Fri, 5 Oct 2007 13:25:43 +0100
Date:	Fri, 5 Oct 2007 13:25:43 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Giuseppe Sacco <giuseppe@eppesuigoccas.homedns.org>
Cc:	linux-mips@linux-mips.org
Subject: Re: kernel bug using 2.6.23-rc9
Message-ID: <20071005122543.GB22239@linux-mips.org>
References: <1191502153.10050.15.camel@scarafaggio>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1191502153.10050.15.camel@scarafaggio>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16872
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, Oct 04, 2007 at 02:49:13PM +0200, Giuseppe Sacco wrote:

> Hi, while testing the latest kernel on SGI O2 I got may kernel bugs like
> this:
> 
> Kernel bug detected[#9]:
> Cpu 0
> $ 0   : 0000000000000000 ffffffff9001fce0 0000000000000001 0000000000000f18
> $ 4   : 980000000111b4b8 000000007f955f18 ffffffff80400000 0000000000003fff
> $ 8   : 00000000000050f1 000000007f955f18 9800000006073d68 9800000006073d60
> $12   : 0000000000000010 ffffffff80000008 ffffffff80091680 0000000000000000
> $16   : 980000000111b4b8 980000000768ddd0 000000000000000e 000000007f955f18
> $20   : 9800000000581908 9800000007898080 9800000006073d68 9800000006073d60
> $24   : 0000000000478284 000000002ac30580                                  
> $28   : 9800000006070000 9800000006073cd0 0000000000000000 ffffffff8001b390
> Hi    : 000000000000f2d3
> Lo    : 00000000000050f1
> epc   : ffffffff8001c800 kmap_coherent+0x10/0x118     Tainted: G      D
> ra    : ffffffff8001b390 __flush_anon_page+0x70/0x90

Very interesting.  Can you describe me your setup or maybe even come up
with a test case for this?

  Ralf
