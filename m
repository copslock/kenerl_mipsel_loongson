Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Aug 2005 16:40:08 +0100 (BST)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:21962 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225197AbVH1Pjs>;
	Sun, 28 Aug 2005 16:39:48 +0100
Received: from drow by nevyn.them.org with local (Exim 4.52)
	id 1E9PLf-0006su-GT; Sun, 28 Aug 2005 11:45:31 -0400
Date:	Sun, 28 Aug 2005 11:45:31 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	Dave Johnson <djohnson+linuxmips@sw.starentnetworks.com>
Cc:	Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: gdb gets confused with o32 core files, WANT_COMPAT_REG_H needed?
Message-ID: <20050828154530.GA26423@nevyn.them.org>
References: <17162.16068.212165.340275@cortez.sw.starentnetworks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17162.16068.212165.340275@cortez.sw.starentnetworks.com>
User-Agent: Mutt/1.5.8i
Return-Path: <drow@nevyn.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 8832
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Mon, Aug 22, 2005 at 05:08:20PM -0400, Dave Johnson wrote:
> 
> I've been trying to fix core file support for 64bit kernel with o32
> userspace (working against 2.6.12 cvs tag).
> 
> After applying the patch posted on 13 Feb 2005 from Daniel Jacobowitz
> to fix binfmt_elfo32.c (any reason this didn't make it into CVS?),
> I still ran into trouble with gdb not understanding the NT_PRSTATUS
> header in the core file.
> 
> While Dan's fix makes the kernel use elf32 definitions, gdb was still
> getting confused by pr_reg contained in the core file.
> 
> Dan's definition of ELF_CORE_COPY_REGS in binfmt_elfo32.c is copying
> the registers using EF_R0 as 0 not 6 producing results into offset 0
> through 37 not 6 through 43 as gdb expects for 32bit core files.
> 
> Below patch (applied after Dan's patch) writes the registers at offset
> 6 making gdb much happier.

FYI, this has all been rearranged since - it did this correctly at the
time.  I don't know why the patch was dropped.


-- 
Daniel Jacobowitz
CodeSourcery, LLC
