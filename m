Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2004 15:35:14 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:33168 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225226AbUBCPfN>;
	Tue, 3 Feb 2004 15:35:13 +0000
Received: from drow by nevyn.them.org with local (Exim 4.30 #1 (Debian))
	id 1Ao2Zx-0007Qe-PZ; Tue, 03 Feb 2004 10:35:09 -0500
Date: Tue, 3 Feb 2004 10:35:09 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Toshio Seo <seo_tmi@charter.net>
Cc: Linux-Mips <linux-mips@linux-mips.org>
Subject: Re: Starter questions
Message-ID: <20040203153509.GA28469@nevyn.them.org>
References: <HGEAKBEJEJDAIDOBJGONOELECAAA.seo_tmi@charter.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <HGEAKBEJEJDAIDOBJGONOELECAAA.seo_tmi@charter.net>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 4260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Feb 03, 2004 at 10:15:48AM -0500, Toshio Seo wrote:
> Hi,
> 
> I am a bit new to Linux MIPS but I would really appreciate a few pointers.
> 
> 1. I am getting GCC 3.3.2, binutils-2.14..... and GLIB-2.3.2 off of
> Kernel.org.  Is there a source of patches for these to make a clean MIPS64
> and N32 build?

None of those three components supports N32 userspace applications. 
Binutils 2.14 is pretty close.  GCC 3.3.2 won't even configure for
mips64-linux.

You have to use the bleeding edge tools if you want to build a mips64
userland.

> 2. Are there any ioctl() examples for displaying and modifying processor
> registers from user programs?
> 
> Thanks
> Toshio
> 
> 
> ---
> Outgoing mail is certified Virus Free.
> Checked by AVG anti-virus system (http://www.grisoft.com).
> Version: 6.0.573 / Virus Database: 363 - Release Date: 1/28/2004
>  



-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
