Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Oct 2003 18:15:56 +0000 (GMT)
Received: from nevyn.them.org ([IPv6:::ffff:66.93.172.17]:27780 "EHLO
	nevyn.them.org") by linux-mips.org with ESMTP id <S8225394AbTJ2SPy>;
	Wed, 29 Oct 2003 18:15:54 +0000
Received: from drow by nevyn.them.org with local (Exim 4.24 #1 (Debian))
	id 1AEuqj-0003lH-3R; Wed, 29 Oct 2003 13:15:17 -0500
Date: Wed, 29 Oct 2003 13:15:17 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Jun Sun <jsun@mvista.com>
Cc: Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
Subject: Re: Huge dynamically linked program does not run on mips-linux
Message-ID: <20031029181516.GA14443@nevyn.them.org>
Mail-Followup-To: Jun Sun <jsun@mvista.com>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org,
	binutils@sources.redhat.com
References: <20031022.171118.88468465.nemoto@toshiba-tops.co.jp> <20031029.163201.39178653.nemoto@toshiba-tops.co.jp> <20031029101400.J30683@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031029101400.J30683@mvista.com>
User-Agent: Mutt/1.5.1i
Return-Path: <drow@crack.them.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 3551
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips

On Wed, Oct 29, 2003 at 10:14:00AM -0800, Jun Sun wrote:
> On Wed, Oct 29, 2003 at 04:32:01PM +0900, Atsushi Nemoto wrote:
> > >>>>> On Wed, 22 Oct 2003 17:11:18 +0900 (JST), Atsushi Nemoto <anemo@mba.ocn.ne.jp> said:
> > anemo> I have a problem that my huge dynamically linked program cause
> > anemo> SIGSEGV or SIGBUS immediately after running from main() on
> > anemo> mips-linux.
> > 
> > anemo> Digging into this problem, I found that GOT entries are
> > anemo> corrupted.
> > ...
> > anemo> My program is huge enough so that older binutils causes
> > anemo> "relocation truncated to fit" error.
> > 
> > More information.  My program's .got size exceeds 64K.  It seems the
> > corruption does not happen if .got size is smaller then 64K.
> > 
> > $ mips-linux-readelf -e myapp
> > ...
> > Section Headers:
> >   [Nr] Name              Type            Addr     Off    Size   ES Flg Lk Inf Al
> > ...
> >   [21] .got              PROGBITS        100b15d0 a075d0 013a04 04 WAp  0   0 16
> > 
> 
> Isn't this a known problem in binutils?  IIRC, someone is working or has
> added "--big-got" support.

Atsushi-san's program would not even link with a binutils that didn't
support multiple GOTs; I guess that something is going wrong with that
support.

I don't suppose you could provide a testcase?

-- 
Daniel Jacobowitz
MontaVista Software                         Debian GNU/Linux Developer
