Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Oct 2003 15:03:30 +0100 (BST)
Received: from p508B6267.dip.t-dialin.net ([IPv6:::ffff:80.139.98.103]:58759
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225418AbTJIODX>; Thu, 9 Oct 2003 15:03:23 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h99E3LNK029511;
	Thu, 9 Oct 2003 16:03:21 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h99E3Kma029510;
	Thu, 9 Oct 2003 16:03:20 +0200
Date: Thu, 9 Oct 2003 16:03:20 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: exister99@velocitus.net
Cc: linux-mips@linux-mips.org
Subject: Re: mips 32 bit HIGHMEM support
Message-ID: <20031009140319.GA17647@linux-mips.org>
References: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5334.156.153.254.2.1065650433.squirrel@webmail.rmci.net>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3399
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 08, 2003 at 04:00:33PM -0600, exister99@velocitus.net wrote:

> I work for HP in Boise, ID, USA.  For the last six months I have been
> working with Linux in HP Laser jet Printers.  It is running in a formatter
> board that features an ASIC with a MIPS 20Kc core.

Reminds me of the HP Laserjet code in the kernel.  Anybody still using
or testing that?

> The original Linux port was achieved by others working before me.  I began
> working on applications for it when I started here (to make it print
> actually).  As I have tried to milk more performance out of this board the
> recurrent bottleneck has been the fact that the kernel only recognizes
> 512Mb of RAM.  So my current endeavor is fix the kernel so it sees the 1G
> of RAM that is physically present in the system.
> 
> I reconfigured and rebuilt the kernel with HIGHMEM support.  HIGHMEM is
> seen and booting up goes splendidly until init (pid 1) kicks off.  Early
> on in the execution of init the system crashes.  Specifically it crashes
> in do_page_fault().  A couple of strange things I have noticed:
> 
> 1.  All memory pages are divied up between the DMA Zone and the HIGHMEM
> Zone at bootup.  the NORMAL zone gets 0 pages.  Not sure if this is
> normal.
> 
> 2.  The virtual address that do_page_fault() chokes on is 0x00000000. 
> This doesn't seem like a reasonable address for init to be accessing
> especially considering its mem map only contains the chunks
> 0x10000000-0x10001000 and 0x400000-0x40b000 (I got these by traversing
> init's mm->mm_rb tree).
> 
> I decided to contact you about this after digging up this old posting of
> yours:

[... ancient posting deleted ...]

> I think this describes my machine.
> 
> If this is an issue who's solution is old news please point me to the
> solution.  In any case any ideas or guidance regarding this crash would be
> greatly appreciated.

In the meantime there is a highmem implementation for the MIPS kernel.
It's got a limitation - it only works on physically indexed D-caches or
more exactly processors that don't suffer from cache aliases.  On
processors that have such aliases the necessary flushes are rather bad
for performance so this currently simply isn't suported.

Anyway, for a 64-bit processor such as the 20Kc I suggest a 64-bit kernel.
Highmem is a pain and 64-bit is the cure.

  Ralf
