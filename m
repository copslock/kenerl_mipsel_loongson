Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Dec 2003 02:30:23 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:47491 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225226AbTL2CaW>;
	Mon, 29 Dec 2003 02:30:22 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1AanAL-0000xR-6s; Sun, 28 Dec 2003 21:29:57 -0500
Date: Sun, 28 Dec 2003 21:29:57 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Guido Guenther <agx@sigxcpu.org>, linux-mips@linux-mips.org
Subject: Re: 2.6 64bit kernels
Message-ID: <20031229022957.GA3652@nevyn.them.org>
References: <20031228195433.GH1298@bogon.ms20.nix>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031228195433.GH1298@bogon.ms20.nix>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3843
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Sun, Dec 28, 2003 at 08:54:34PM +0100, Guido Guenther wrote:
> Hi,
> could anybody explain to me how one builds 2.6 (current CVS) 64bit
> kernel resulting in a 32bit ELF executable with a current (gcc >= 3.3,
> bintuils >= 2.14.90.0.5) toolchain.
> Major showstopper is that -Wa,-mabi=o64 doesn't work anymore, but
> -Wa,-mabi=32 -Wa,-mgp64 doesn't either since the assembler doesn't
> accept it.
> Thanks for any help,

I have found that the best way is to build a 64-bit ELF executable. 
Then, use:
  mips64_fp_le-objcopy -O elf32-ntradlittlemips vmlinux vmlinux.32bit

or the equivalent command.

You lose some space (lots) on wasted addressing calculations; no one
has found a good solution AFAIK.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
