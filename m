Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2002 22:47:41 +0200 (CEST)
Received: from crack.them.org ([65.125.64.184]:60680 "EHLO crack.them.org")
	by linux-mips.org with ESMTP id <S1122987AbSIQUrk>;
	Tue, 17 Sep 2002 22:47:40 +0200
Received: from nevyn.them.org ([66.93.61.169] ident=mail)
	by crack.them.org with asmtp (Exim 3.12 #1 (Debian))
	id 17rQBs-0004TP-00; Tue, 17 Sep 2002 16:47:28 -0500
Received: from drow by nevyn.them.org with local (Exim 3.35 #1 (Debian))
	id 17rPFp-0008Bi-00; Tue, 17 Sep 2002 16:47:29 -0400
Date: Tue, 17 Sep 2002 16:47:29 -0400
From: Daniel Jacobowitz <dan@debian.org>
To: "Steven J. Hill" <sjhill@realitydiluted.com>
Cc: Stuart Hughes <seh@zee2.com>,
	Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: cannot debug multi-threaded programs with gdb/gdbserver
Message-ID: <20020917204729.GA31458@nevyn.them.org>
References: <3D876053.C2CD1D8C@zee2.com> <3D87653E.9030702@realitydiluted.com> <20020917182536.GA25012@nevyn.them.org> <3D878695.3040101@realitydiluted.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D878695.3040101@realitydiluted.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Tue, Sep 17, 2002 at 02:46:29PM -0500, Steven J. Hill wrote:
> Daniel Jacobowitz wrote:
> >On Tue, Sep 17, 2002 at 12:24:14PM -0500, Steven J. Hill wrote:
> >
> >Steve, have you started memorizing my responses again? :)
> >
> *gurgle* Yeah, I have. I apologize if it seemed I was taking
> credit for anything.
> 
> >>>cross-gdb configured using: 
> >>>
> >>>configure --prefix=/usr --target=mipsel-linux --disable-sim
> >>>--disable-tcl --enable-threads --enable-shared
> >>>
> >>
> >>Use '--target=mips-linux' and you'll be better off. Don't worry, it
> >>will support both endians.
> >
> >
> >Except for this one - where'd that come from?  It should make no
> >functional difference either way, at least assuming you always give GDB
> >a binary.
> >
> I got some weird errors (unfortunately I can't remember) if I tried
> using 'mipsel-linux' as the target. So you're saying that a gdb
> configured for 'mipsel-linux' or 'mips-linux' should work the same?
> Thanks Daniel.

Hmm, if you can reproduce these let me know what they are.  I use a
mipsel GDB regularly.

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
