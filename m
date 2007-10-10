Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Oct 2007 15:27:59 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:23736 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20024151AbXJJO14 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 10 Oct 2007 15:27:56 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9AERtns009436;
	Wed, 10 Oct 2007 15:27:55 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9AERtJc009435;
	Wed, 10 Oct 2007 15:27:55 +0100
Date:	Wed, 10 Oct 2007 15:27:55 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Franck Bui-Huu <fbuihuu@gmail.com>
Cc:	Thiemo Seufer <ths@networkno.de>,
	"Maciej W. Rozycki" <macro@linux-mips.org>,
	linux-mips@linux-mips.org
Subject: Re: [PATCH 2/6] tlbex.c: Remove relocs[] and labels[] from the
	init.data section
Message-ID: <20071010142755.GA9325@linux-mips.org>
References: <47038874.9050704@gmail.com> <20071003131158.GL16772@networkno.de> <4703F155.4000301@gmail.com> <20071003201800.GP16772@networkno.de> <47049734.6050802@gmail.com> <20071004121557.GA28928@linux-mips.org> <4705004C.5000705@gmail.com> <20071005115151.GA16145@linux-mips.org> <470BE58A.9070709@gmail.com> <470BE61F.5020108@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470BE61F.5020108@gmail.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16938
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Oct 09, 2007 at 10:35:43PM +0200, Franck Bui-Huu wrote:

> This patch reduces the kernel image size by making these 2 arrays
> automatic variables.
> 
> 	tlbex.o~old  =>  tlbex.o
> 	 text:     9840     9812      -28  0%
> 	 data:     3904     1344    -2560 -65%
> 	  bss:     1568     1568        0  0%
> 	total:    15312    12724    -2588 -16%
> 
> It increases the stack pressure a lot (more than 2500 bytes) but
> at this stage in the boot process, it shouldn't matter.

Even more for 64-bit kernel - and I would really like to keep reduce
the kernel stack for 64-bit kernels, THREAD_SIZE_ORDER 2 is already
slightly painful when memory becomes fragmented.

The other issue is that with CPU plugging (halfbreed patches to add that
to MIPS are around) this code can be called at any time, not only during
early startup when at most a timer interrupt may strike.  Bootmem maybe?

  Ralf
