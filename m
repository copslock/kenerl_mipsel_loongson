Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 19 Oct 2007 13:39:58 +0100 (BST)
Received: from cerber.ds.pg.gda.pl ([153.19.208.18]:44236 "EHLO
	cerber.ds.pg.gda.pl") by ftp.linux-mips.org with ESMTP
	id S20044267AbXJSMjt (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 19 Oct 2007 13:39:49 +0100
Received: from localhost (unknown [127.0.0.17])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id 0B4B0400A4;
	Fri, 19 Oct 2007 14:39:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at cerber.ds.pg.gda.pl
Received: from cerber.ds.pg.gda.pl ([153.19.208.18])
	by localhost (cerber.ds.pg.gda.pl [153.19.208.18]) (amavisd-new, port 10024)
	with ESMTP id bJD6xWGyO56S; Fri, 19 Oct 2007 14:39:14 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by cerber.ds.pg.gda.pl (Postfix) with ESMTP id ADD6440083;
	Fri, 19 Oct 2007 14:39:14 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.8/8.13.8) with ESMTP id l9JCdHLb002455;
	Fri, 19 Oct 2007 14:39:17 +0200
Date:	Fri, 19 Oct 2007 13:39:14 +0100 (BST)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Ralf Baechle <ralf@linux-mips.org>
cc:	Wolfgang Denk <wd@denx.de>, linux-mips@linux-mips.org
Subject: Re: MIPS Makefile not picking up CROSS_COMPILE from environment
 setting
In-Reply-To: <20071019111823.GB30767@linux-mips.org>
Message-ID: <Pine.LNX.4.64N.0710191323060.13279@blysk.ds.pg.gda.pl>
References: <20071018184636.48637242E9@gemini.denx.de> <20071019111823.GB30767@linux-mips.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: ClamAV 0.91.2/4545/Wed Oct 17 23:05:57 2007 on piorun.ds.pg.gda.pl
X-Virus-Status:	Clean
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17130
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, 19 Oct 2007, Ralf Baechle wrote:

> The idea of passing CROSS_COMPILE from the environment always seemed to
> be wrong to me - I keep jumping between all sorts of weird different
> kernel configurations so no single setting of an environment variable
> would cut it.

 Yes, picking stuff from the environment tends to lead to surprising 
behaviour some time later when one has already forgotten they have got 
that setting put there.  However, for the insistent, it is always possible 
to override the variable at the make's command line, so you can say e.g.:

$ make "CROSS_COMPILE=mips64el-linux-" vmlinux

which is what I actually do, or, for the hard-liners:

$ make "CROSS_COMPILE=$CROSS_COMPILE" vmlinux

;-)

> What I'd really like to see is a properly working CONFIG_MYARCH option
> selectable in Kconfig.  Then the makefiles should figure out if it's a
> native or crosscompile and add the right tool prefix.  The user should
> not need to know that sort of stuff unless he wants to.

 Well, the tool prefix cannot be figured out automatically anyway, as, 
assuming 32-bit little-endian MIPS for example, it can be one of:

mipsel-linux-
mipsel-unknown-linux-gnu-
mipsel-dec-linux-
...

-- essentially any remotely sane setting that whoever configured the 
toolchain considered would suit them best.

 Also at one point I plan to implement that long-standing (and 
long-ago-agreed-upon) idea of encoding the default ABI in the canonical 
system name, which will help people with a 64-bit kernel getting their 
userland builds pick the right ABI of their choice with just `./configure; 
make', but which will make the choice of tool prefixes yet richer.

  Maciej
