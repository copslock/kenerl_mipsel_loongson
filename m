Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Nov 2004 15:01:34 +0000 (GMT)
Received: from p508B767E.dip.t-dialin.net ([IPv6:::ffff:80.139.118.126]:48177
	"EHLO mail.linux-mips.net") by linux-mips.org with ESMTP
	id <S8224897AbUKVPB3>; Mon, 22 Nov 2004 15:01:29 +0000
Received: from fluff.linux-mips.net (localhost [127.0.0.1])
	by mail.linux-mips.net (8.13.1/8.13.1) with ESMTP id iAMF180c004658;
	Mon, 22 Nov 2004 16:01:08 +0100
Received: (from ralf@localhost)
	by fluff.linux-mips.net (8.13.1/8.13.1/Submit) id iAMF18ro004657;
	Mon, 22 Nov 2004 16:01:08 +0100
Date: Mon, 22 Nov 2004 16:01:08 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Mad Props <madprops@gmx.net>
Cc: linux-mips@linux-mips.org
Subject: Re: beginners question
Message-ID: <20041122150108.GA4241@linux-mips.org>
References: <8709.1101086706@www8.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8709.1101086706@www8.gmx.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6400
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Mon, Nov 22, 2004 at 02:25:06AM +0100, Mad Props wrote:

> i wrote a little MIPS startup code that uses the serial port to print some
> output. Further I enabled timer interrupts. So far, I'm using kseg1 since
> nothing else is intialized.
> 
> I have a static variable in my C exception hander. The problem with it: it's
> apparently not within kseg1 but in the user segment and causes the exception
> handler to get invoked recursively. How can I change this so that all
> variables / code use kseg1 ?

Seems like you need a linker script.  The kernel has it's linker script
in arch/mips/kernel/vmlinux.lds.S but due to complexity that's probably
not a good example to look at.

  Ralf
