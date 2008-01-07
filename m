Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Jan 2008 16:19:02 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:7117 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S28574287AbYAGQTA (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 7 Jan 2008 16:19:00 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id m07GIbZM001042;
	Mon, 7 Jan 2008 16:18:37 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id m07GIZKT001041;
	Mon, 7 Jan 2008 16:18:35 GMT
Date:	Mon, 7 Jan 2008 16:18:35 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Thiemo Seufer <ths@networkno.de>
Cc:	KokHow.Teh@infineon.com, linux-mips@linux-mips.org
Subject: Re: Arch/mips/kernel/vpe.c
Message-ID: <20080107161835.GB674@linux-mips.org>
References: <31E09F73562D7A4D82119D7F6C1729860320EADA@sinse303.ap.infineon.com> <20080105170546.GG22809@networkno.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080105170546.GG22809@networkno.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17944
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Sat, Jan 05, 2008 at 05:05:46PM +0000, Thiemo Seufer wrote:

> > 	I am working on MIPS34KC with APRP kernel and I use uclibc
> > gccc-3.4.4 to build applications to run on VPE1. The present
> > implementation of VPE loader is limited to a few relocation types which
> > are used when mips_sde compiler is used. However, the relocatable binary
> > churn out from my uclibc-gcc-3.4.4 has more other relocation types than
> > the ones defined in arch/mips/kernel/vpe.c, especially those with GOT
> > relocation types. I have taken a look at the System V ABI Third Edition
> > but if anybody has any code reference and pointers to how each
> > relocation types should be implemented in C-code, it would be very
> > helpful.
> 
> The most likely place to look at would be the binutils source code. That
> said, you can probably get away without enhancing the VPE loader by using
>   a) fully linked (non-relocatable) executables, or
>   b) non-PIC code, like SDE does
> 
> Regardless of your choice, you will have to make sure the uclibc toolchain
> doesn't use any libraries which need Linux facilities, as the bare-metal
> environment on VPE1 doesn't provide them. For that reason I believe you
> are better of with SDE or a similiar mips*-elf configured toolchain.

I'm tempted to replace the existing vpe loader with something like the 2.4
version of insmod which does all the relocation handling in userspace and a
device file which make the vpe memory available to userspace for the loader
to write to.  Or something like spufs.

  Ralf
