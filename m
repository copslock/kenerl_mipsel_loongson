Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Jan 2007 15:56:14 +0000 (GMT)
Received: from nevyn.them.org ([66.93.172.17]:1947 "EHLO nevyn.them.org")
	by ftp.linux-mips.org with ESMTP id S20038614AbXA2P4J (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 29 Jan 2007 15:56:09 +0000
Received: from drow by nevyn.them.org with local (Exim 4.63)
	(envelope-from <drow@nevyn.them.org>)
	id 1HBYoQ-0000Z4-1Q; Mon, 29 Jan 2007 10:52:54 -0500
Date:	Mon, 29 Jan 2007 10:52:54 -0500
From:	Daniel Jacobowitz <dan@debian.org>
To:	Franck Bui-Huu <vagabon.xyz@gmail.com>
Cc:	linux-mips@linux-mips.org, ralf@linux-mips.org,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Subject: Re: RFC: Sentosa boot fix
Message-ID: <20070129155253.GA2070@nevyn.them.org>
References: <20070128180807.GA18890@nevyn.them.org> <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cda58cb80701290159m5eed331em5945eac4a602363a@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 13841
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Jan 29, 2007 at 10:59:37AM +0100, Franck Bui-Huu wrote:
> Hi,
> 
> On 1/28/07, Daniel Jacobowitz <dan@debian.org> wrote:
> >The problem is __pa_symbol(&_end); the kernel is linked at
> >0xffffffff80xxxxxx, so subtracting a PAGE_OFFSET of 0xa800000000000000
> >does not do anything useful to this address at all.
> >
> 
> In my understanding, if your kernel is linked at 0xffffffff80xxxxxx,
> you shouldn't have CONFIG_BUILD_ELF64 set.

What Maciej said.  But also: please compare the description of
CONFIG_BUILD_ELF64 with the targets that link at that address.
Almost every supported target links at that address, except for
IP27.  How do any of them work today?

config BUILD_ELF64
        bool "Use 64-bit ELF format for building"
        depends on 64BIT
        help
          A 64-bit kernel is usually built using the 64-bit ELF binary object
          format as it's one that allows arbitrary 64-bit constructs.  For
          kernels that are loaded within the KSEG compatibility segments the
          32-bit ELF format can optionally be used resulting in a somewhat
          smaller binary, but this option is not explicitly supported by the
          toolchain and since binutils 2.14 it does not even work at all.

          Say Y to use the 64-bit format or N to use the 32-bit one.

          If unsure say Y.


% grep load- arch/mips/Makefile | grep ffffffff8 | wc
     55     165    2743

-- 
Daniel Jacobowitz
CodeSourcery
