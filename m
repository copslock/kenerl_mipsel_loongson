Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Apr 2003 15:04:05 +0100 (BST)
Received: from p508B7959.dip.t-dialin.net ([IPv6:::ffff:80.139.121.89]:58564
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225073AbTDAOEF>; Tue, 1 Apr 2003 15:04:05 +0100
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.11.6/8.11.6) id h31E3QP15572;
	Tue, 1 Apr 2003 16:03:26 +0200
Date: Tue, 1 Apr 2003 16:03:26 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Brian Murphy <brm@tt.dk>
Cc: "Neeraj Garg, Noida" <ngarg@noida.hcltech.com>,
	linux-mips@linux-mips.org
Subject: Re: Linux-MIPS compilation
Message-ID: <20030401160326.B14479@linux-mips.org>
References: <E04CF3F88ACBD5119EFE00508BBB2121086ED859@exch-01.noida.hcltech.com> <20030401134258.A7618@linux-mips.org> <3E899ABF.3070704@tt.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <3E899ABF.3070704@tt.dk>; from brm@tt.dk on Tue, Apr 01, 2003 at 03:57:19PM +0200
Return-Path: <ralf@linux-mips.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1889
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Tue, Apr 01, 2003 at 03:57:19PM +0200, Brian Murphy wrote:

> >The options -D__linux__ -D_MIPS_SZLONG=32 and the error messages make it
> >look like you're forcing a non-Linux toolchain into building a kernel.
> >
> What is the problem with this? At least a mips(el)-elf should have no 
> problem compiling the kernel
> (at least apart from the check you have somewhere which gives an error 
> if you try).

These options are the default for every usable compiler.  If he actually
needed to add these options it looks like his compiler is pretty broken.
Similary the PIC-related error messages.  He's explicitly passing options
to disable PIC code yet the assembler and linker error messages indicate
he's using PIC code.  That's very strange also.

  Ralf
