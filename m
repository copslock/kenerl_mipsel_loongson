Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Sep 2002 15:24:19 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:268 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122961AbSIRNYS>;
	Wed, 18 Sep 2002 15:24:18 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17rfk7-0005hi-00; Wed, 18 Sep 2002 09:23:51 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17reo6-0004KJ-00; Wed, 18 Sep 2002 09:23:54 -0400
Date: Wed, 18 Sep 2002 09:23:53 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: Johannes Stezenbach <js@convergence.de>
Cc: "Steven J. Hill" <sjhill@realitydiluted.com>,
	Stuart Hughes <seh@zee2.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
Message-ID: <20020918132353.GA16211@nevyn.them.org>
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com> <20020918121047.GA17744@convergence.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020918121047.GA17744@convergence.de>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 235
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Sep 18, 2002 at 02:10:47PM +0200, Johannes Stezenbach wrote:
> Steven J. Hill wrote:
> > Stuart Hughes wrote:
> > >
> > >Does anyone know whether there is some special setup needed on
> > >gdb/gdbserver to use the multi-threaded gdbserver ??
> ...
> > >binutils:	Version 2.11.90.0.25
> > >
> > Don't use H.J. Lu's binutils, use the released one. Use gcc-3.2 and
> > binutils-2.13 as they have fixes for the MIPS debugging symbols with
> > regards to DWARF.
> 
> Is this a general recommendation to avoid H.J. Lu's binutils, or do
> you just favor the newer binutils version?
> What about binutils 2.13.90.0.4?
> 
> I'm currently using gcc-2.95.4 with the Debian patches, and
> binutils binutils-2.12.90.0.14, which seem to work well.
> I planned to switch to gcc-3.2 but postponed it because I
> read about the DWARF debugging problems. Are they solved
> with gcc-3.2 / binutils-2.13 / gdb-5.3-CVS ?

Yes, they are fixed.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
