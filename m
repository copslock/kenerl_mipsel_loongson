Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Feb 2003 10:03:33 +0000 (GMT)
Received: from gandalf.physik.uni-konstanz.de ([IPv6:::ffff:134.34.144.69]:11180
	"EHLO gandalf.physik.uni-konstanz.de") by linux-mips.org with ESMTP
	id <S8225196AbTBJKDc>; Mon, 10 Feb 2003 10:03:32 +0000
Received: from merry.physik.uni-konstanz.de (merry.physik.uni-konstanz.de [134.34.144.91])
	by gandalf.physik.uni-konstanz.de (Postfix) with ESMTP
	id ADFB793; Mon, 10 Feb 2003 11:03:19 +0100 (CET)
Received: from agx by merry.physik.uni-konstanz.de with local (Exim 3.35 #1 (Debian))
	id 18iAmV-00080b-00; Mon, 10 Feb 2003 11:03:19 +0100
Date: Mon, 10 Feb 2003 11:03:19 +0100
From: Guido Guenther <agx@gandalf.physik.uni-konstanz.de>
To: Andrew Clausen <clausen@melbourne.sgi.com>
Cc: Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: porting arcboot
Message-ID: <20030210100319.GA30624@merry>
References: <20030210034549.GA8408@pureza.melbourne.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030210034549.GA8408@pureza.melbourne.sgi.com>
User-Agent: Mutt/1.3.28i
Return-Path: <agx@mittelerde.physik.uni-konstanz.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 1372
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: agx@gandalf.physik.uni-konstanz.de
Precedence: bulk
X-list: linux-mips

Hi,
On Mon, Feb 10, 2003 at 02:45:49PM +1100, Andrew Clausen wrote:
>  * I'll be cross-compiling (using the mips64-linux-gcc & friends that
> are provided on ftp.linux-mips.org), which means some makefile hacking...
There hopefully shouldn't be any trouble with that outside of e2fslib.

>  * the e2fs stuff... how is this being maintained?  It uses libc
> headers a bit... can I kill them?  Or will this make it hard to update
> to new upstream e2fsprogs releases?
E2fslib will move out of arcboot with the next release and arcboot will
link against the non pic version in the debian archive. I'd really like
to keep e2fslib out of arcboot (at least for the debian version which is
quiet different from the oss.sgi.com version). There should't be many
libc header dependencies left then. If there are still any I'd be happy
to kill them.

> Anything else?
Except for the above change I was working on a better command line
handling among other things which I never got around to finish. Maybe
this beats me to it.
Regards,
 -- Guido
