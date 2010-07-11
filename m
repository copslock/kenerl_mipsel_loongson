Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Jul 2010 01:09:00 +0200 (CEST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:52672 "EHLO h5.dl5rb.org.uk"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1492058Ab0GKXIw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 12 Jul 2010 01:08:52 +0200
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
        by h5.dl5rb.org.uk (8.14.4/8.14.3) with ESMTP id o6BN8pLX008235;
        Mon, 12 Jul 2010 00:08:52 +0100
Received: (from ralf@localhost)
        by h5.dl5rb.org.uk (8.14.4/8.14.4/Submit) id o6BN8p7v008233;
        Mon, 12 Jul 2010 00:08:51 +0100
Date:   Mon, 12 Jul 2010 00:08:51 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Chris Rhodin <chris@notav8.com>
Cc:     linux-mips@linux-mips.org
Subject: Re: IP22 Debian Install
Message-ID: <20100711230851.GA8181@linux-mips.org>
References: <4C36D31A.5000500@notav8.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4C36D31A.5000500@notav8.com>
User-Agent: Mutt/1.5.20 (2009-08-17)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Jul 09, 2010 at 12:43:22AM -0700, Chris Rhodin wrote:

> tip22: IP22 Linux tftpboot loader 0.3.8.6
> Loading program segment 2 at 0x88002000, size = 0x218000
> Zeroing memory at 0x8821a000, size = 0x365b0
> Starting kernel; entry point = 0x881e0040
> Copied initrd from 0x88aab190 to 0x88251000 (0x1d5ce2 bytes)
> 
> Exception: <vector=Normal>
> Status register: 0x30044803<CU1,CU0,CH,IM7,IM4,IPL=???,MODE=KERNEL,EXL,IE>
> Cause register: 0x30008010<CE=3,IP8,EXC=RADE>
> Exception PC: 0x88124c74, Exception RA: 0x881f61b0
> Read address error exception, bad address: 0x2a
> Local I/O interrupt register 1: 0x80 <VR/GIO2>
> Local I/O interrupt register 2: 0xc8 <EISA,SLOT0,SLOT1>
>  Saved user regs in hex (&gpda 0xa8740e48, &_regs 0xa8741048):
>  arg: a8740000 881dffe0 882505ac 88000000
>  tmp: a8740000 2 887fe378 887fe4cc 0 8 887fe7d4 881e0040
>  sve: a8740000 3 400000 8000000 16 3f80 0 c000000
>  t8 a8740000 t9 fffff7ff at bfefff7f v0 ffbff5ef v1 fff71fbf k1 500
>  gp a8740000 fp fefbfeff sp fffdffff ra feeffff7
> 
> PANIC: Unexpected exception
> 
> It looks like the kernel is loading at 0x88002000 which is more than
> 128MB away from the beginning of kseg0.

Yes and that's correct.  Memory doesn't always start at address zero!

  Ralf
