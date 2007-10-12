Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Oct 2007 19:49:11 +0100 (BST)
Received: from localhost.localdomain ([127.0.0.1]:7584 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20030681AbXJLStJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 12 Oct 2007 19:49:09 +0100
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id l9CIn9cA003815;
	Fri, 12 Oct 2007 19:49:09 +0100
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id l9CIn9G4003814;
	Fri, 12 Oct 2007 19:49:09 +0100
Date:	Fri, 12 Oct 2007 19:49:09 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	David Daney <ddaney@avtrex.com>
Cc:	MIPS Linux List <linux-mips@linux-mips.org>
Subject: Re: Gcc 4.2.2 broken for kernel builds
Message-ID: <20071012184909.GA4832@linux-mips.org>
References: <20071012172254.GA10835@linux-mips.org> <470FB386.6080709@avtrex.com> <20071012175317.GB1110@linux-mips.org> <470FBE08.8090004@avtrex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <470FBE08.8090004@avtrex.com>
User-Agent: Mutt/1.5.14 (2007-02-12)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17004
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Oct 12, 2007 at 11:33:44AM -0700, David Daney wrote:
> From: David Daney <ddaney@avtrex.com>
> Date: Fri, 12 Oct 2007 11:33:44 -0700
> To: Ralf Baechle <ralf@linux-mips.org>,
> 	MIPS Linux List <linux-mips@linux-mips.org>
> Subject: Re: Gcc 4.2.2 broken for kernel builds
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> 
> Ralf Baechle wrote:
> >On Fri, Oct 12, 2007 at 10:48:54AM -0700, David Daney wrote:
> >>From: David Daney <ddaney@avtrex.com>
> >>Date: Fri, 12 Oct 2007 10:48:54 -0700
> >>To: Ralf Baechle <ralf@linux-mips.org>
> >>Cc: linux-mips@linux-mips.org
> >>Subject: Re: Gcc 4.2.2 broken for kernel builds
> >>Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> >>
> >>Ralf Baechle wrote:
> >>>So it looks as if gcc 4.2.2 is broken for kernel builds resulting in the
> >>>following error message with binutils 2.18:
> >>>
> >>> CC      drivers/mtd/mtd_blkdevs.o
> >>>mipsel-linux-ld: drivers/mtd/.tmp_mtd_blkdevs.o: Can't find matching 
> >>>LO16 reloc against `$LC6' for R_MIPS_HI16 at 0x9e0 in section `.text'
> >>> CC      drivers/mtd/chips/chipreg.o
> >>>
> >>>Older binutils throw a more cryptic error message about the bad assembler
> >>>code generated by gcc:
> >>>
> >>> CC      drivers/mtd/mtd_blkdevs.o
> >>>mipsel-linux-ld: final link failed: Bad value
> >>>make[2]: *** [drivers/mtd/mtd_blkdevs.o] Error 1
> >>>make[1]: *** [drivers/mtd] Error 2
> >>>make: *** [drivers] Error 2
> >>>
> >>>Just as heads up ...
> >>>
> >>Could you file a bug report here:
> >>
> >>http://gcc.gnu.org/bugzilla/
> >>
> >>If you could include a pointer to the kernel sources you were using and 
> >>perhaps attach your .config to the bug that might be useful as well.
> >
> >If I had the time I'd have done that.  Short of that posting a warning is
> >what I can do.
> 
> I opened this bug:
> 
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33755
> 
> As more information becomes available about this feel free to add it to 
> the GCC bug report.

For the moment the receipe to reproduce is to checkout
7b94a571d6f31ac6303d62c2aafcae40b66f24a3 from the linux-mips.org kernel
tree (that's on linux-2.6.18-stable) and build malta_defconfig with
gcc 4.2.2 and binutils 2.17 or 2.18, both configured for mipsel-linux.

  Ralf
