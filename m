Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 25 Nov 2002 13:53:21 +0100 (CET)
Received: from p508B747B.dip.t-dialin.net ([80.139.116.123]:65258 "EHLO
	dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S1121742AbSKYMxV>; Mon, 25 Nov 2002 13:53:21 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id gAPCrA212909;
	Mon, 25 Nov 2002 13:53:10 +0100
Date: Mon, 25 Nov 2002 13:53:10 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: henaldohzh@hotmail.com
Cc: linux-mips@linux-mips.org
Subject: Re: Problem about porting mips kernel
Message-ID: <20021125135310.A12492@linux-mips.org>
References: <F177Ll1r0sdVWb9eSry000080ef@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <F177Ll1r0sdVWb9eSry000080ef@hotmail.com>; from henaldohzh@hotmail.com on Mon, Nov 25, 2002 at 12:47:28PM +0000
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 709
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 25, 2002 at 12:47:28PM +0000, henaldohzh@hotmail.com wrote:

>   these days, I am busy with porting mips kernel to a board with vr4131 
> core. This board has only SIU serial port, and some hw have been modified. 
> Now, I have ported the kernel to it, and modified hw run well. But so 
> puzzling me, the execution file cann't run at all. If some one can help me 
> or give some advices. I have been crazy for the problem. Off hat for your 
> help. Thanks a lot.
>  btw, I use the ramdisk with busybox.

In general this kind of problem means the tlb or cache code for a particular
platform is faulty or the kernel not configured properly.

  Ralf
